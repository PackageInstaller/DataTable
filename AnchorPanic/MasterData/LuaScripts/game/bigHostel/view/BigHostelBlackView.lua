-- @FileName:   BigHostelBlackView.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2025-05-21 19:14:52
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.view.BigHostelBlackView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bigHostel/BigHostelBlackView.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0 --是否开启适配刘海
escapeClose = 0
isAddMask = 0
isBlur = 0
destroyTime = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.m_showEfx = true
end

-- 初始化
function configUI(self)
    self.mImgBlack = self:getChildGO("mImgBlack")
    self.mImgBlackAni = self.mImgBlack:GetComponent(ty.Animator)

    self.mInteractiveEfxGroup = self:getChildTrans("mInteractiveEfxGroup")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function __playOpenAction(self)

end

--激活
function active(self)
    super.active(self)

    GameDispatcher:addEventListener(EventName.SHOW_BIGHOSTEL_BLACK, self.onShowBlack, self)
    GameDispatcher:addEventListener(EventName.HIDE_BIGHOSTEL_BLACK, self.onHideBlack, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, self.addInteractiveEfx, self)

    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.showEfx, self)
    GameDispatcher:addEventListener(EventName.EVENT_UI_OPEN, self.hideEfx, self)

    self.m_screenCamera = gs.CameraMgr:GetToScreenSceneCamera()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SHOW_BIGHOSTEL_BLACK, self.onShowBlack, self)
    GameDispatcher:removeEventListener(EventName.HIDE_BIGHOSTEL_BLACK, self.onHideBlack, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_REFRESH_INTERACTIVEEFX, self.addInteractiveEfx, self)

    GameDispatcher:removeEventListener(EventName.SHOW_MAIN_UI, self.showEfx, self)
    GameDispatcher:removeEventListener(EventName.EVENT_UI_OPEN, self.hideEfx, self)

    self:clearFrame()
    self:clearEfx()
end

--打开窗口
function open(self, args, isReshow)
    if self.isPop == 1 then
        return
    end
    self.isPop = 1

    -- 是否是恢复的打开（被前置窗口互斥后恢复）
    self.isReshow = isReshow

    -- 取消了注册进UI管理器里

    -- if self.panelType ~= 1 and self.isBlur == 1 and self:getUiNodeName() then
    --     gs.UIBlurManager.SetSuperBlur(true, self.UIRootNode, self:getUiNodeName(), self.blurTweenTime)
    -- end

    if self.UIObject then
        self:addOnParent(args)
    end
    GameDispatcher:dispatchEvent(EventName.EVENT_UI_OPEN, self)
    if (self.panelType and self.panelType ~= 1) then
        local OpenSoundPath = self:getOpenSoundPath()
        if not string.NullOrEmpty(OpenSoundPath) then
            AudioManager:playSoundEffect(OpenSoundPath)
        end
    end

    if self.isShow3DBg == 1 then
        Perset3dHandler:setupShowData(MainCityConst.UI_COMMON_3D_BG)
        self:setBg("")
    end

end

function getUiNodeName(self)
    return "SCENE"
end

function hideEfx(self, args)
    if args.panelName ~= 'game.bigHostel.view.BigHostelSceneUI' and args.panelType == 1 then
        self:onMainUIHide()
    elseif args.panelName == 'game.bigHostel.view.BigHostelSceneUI' then
        self:showEfx()
    end
end

function showEfx(self)
    self.m_showEfx = true

    if not self.m_InteractiveEfx then
        return
    end

    for key, efx in pairs(self.m_InteractiveEfx) do
        if efx.efx.effectGo ~= nil and not gs.GoUtil.IsGoNull(efx.efx.effectGo) then
            if efx.efx.effectGo.activeInHierarchy == false then
                efx.efx.effectGo:SetActive(true)
            end
        end
    end
end

function onMainUIHide(self)
    self.m_showEfx = false

    if not self.m_InteractiveEfx then
        return
    end

    for key, efx in pairs(self.m_InteractiveEfx) do
        if efx.efx.effectGo ~= nil and not gs.GoUtil.IsGoNull(efx.efx.effectGo) then
            if efx.efx.effectGo.activeInHierarchy then
                efx.efx.effectGo:SetActive(false)
            end
        end
    end
end

function addInteractiveEfx(self, args)
    if not self.m_InteractiveEfx then
        self.m_InteractiveEfx = {}
    end

    if args.target ~= nil and not gs.GoUtil.IsTransNull(args.target) then
        if self.m_InteractiveEfx[args.key] == nil then
            local efxVo = UIEffectMgr:addEffect("fx_ui_common_guide_1", self.mInteractiveEfxGroup, 0, 0, function (val, efx_go)
                efx_go:SetActive(self.m_showEfx)
                efx_go.transform.anchoredPosition = gs.Vector2(100000, 100000)
            end)

            self.m_InteractiveEfx[args.key] =
            {
                efx = efxVo,
                follow_trans = args.target,
                offset = args.offset,
                timeOutSn = nil,
            }

            if args.life_time and args.life_time ~= 0 then
                self.m_InteractiveEfx[args.key].timeOutSn = LoopManager:setTimeout(args.life_time, self, self.onRemoveEfx, args.key)
            end
        end

        if self.m_frameSn == nil then
            self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
        end
    else
        self:onRemoveEfx(args.key)
    end
end

function onRemoveEfx(self, key)
    if not self.m_InteractiveEfx then
        return
    end

    if self.m_InteractiveEfx[key] == nil then
        return
    end

    if self.m_InteractiveEfx[key].timeOutSn ~= nil then
        LoopManager:clearTimeout(self.m_InteractiveEfx[key].timeOutSn)
        self.m_InteractiveEfx[key].timeOutSn = nil
    end

    UIEffectMgr:removeEffectByVo(self.m_InteractiveEfx[key].efx)
    self.m_InteractiveEfx[key] = nil

    if table.empty(self.m_InteractiveEfx) then
        self:clearFrame()
    end
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

function onFrame(self)
    if not self.m_InteractiveEfx then
        return
    end

    for key, efx in pairs(self.m_InteractiveEfx) do
        if efx.efx.effectGo ~= nil and not gs.GoUtil.IsGoNull(efx.efx.effectGo) then
            local position = efx.follow_trans.position
            if efx.offset ~= nil then
                position = efx.follow_trans:TransformPoint(efx.offset)
            end

            --检测是不是在屏幕内
            if gs.CameraMgr:IsInView(position) then
                gs.CameraMgr:World2UI(position, self.mInteractiveEfxGroup, efx.efx.effectGo.transform)
            else
                efx.efx.effectGo.transform.anchoredPosition = gs.Vector2(10000, 10000)
            end

        end
    end
end

function clearEfx(self)
    if not self.m_InteractiveEfx then
        return
    end

    for key, efx in pairs(self.m_InteractiveEfx) do
        UIEffectMgr:removeEffectByVo(efx.efx)
    end

    self.m_InteractiveEfx = nil
end

function onShowBlack(self)
    if not self.mImgBlack.activeInHierarchy then
        self.mImgBlack:SetActive(true)
    end

    self.mImgBlackAni:SetTrigger("open")
end

function onHideBlack(self)
    self.mImgBlackAni:SetTrigger("close")
end

return _M
