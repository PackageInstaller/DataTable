--[[ 
-----------------------------------------------------
@filename       : RecruitSkipView
@Description    : 十连抽跳过UI
@date           : 2021-04-01 16:24:13
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.RecruitSkipView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/RecruitSkipView.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0
isAdapta = 1 --是否开启适配刘海
isScreensave  = 0
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mBtnSkip = self:getChildGO("mBtnSkip")
    self.mImgMsk = self:getChildGO("mImgMsk")
    self.mFfx = self:getChildGO("mFfx")
    self.mFfxRecTran = self.mFfx:GetComponent(ty.RectTransform)
end

--激活
function active(self,args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.RECRUIT_HERO_CLICK, self.clearTimer, self)

    self.mBtnSkip:SetActive(args.isNeedSkip)
    self.mImgMsk:SetActive(args.isNeedClick)
    self.mFfx:SetActive(false)

    if args.isNeedEfx then 
        self.mFfx:SetActive(true)
        gs.CameraMgr:World2UI(args.efxPoint.position, self.mFfxRecTran.parent,self.mFfxRecTran)
    end
end

function clearTimer(self)
    self.mFfx:SetActive(false)
end

--反激活（销毁工作）
function deActive(self)
    GameDispatcher:removeEventListener(EventName.RECRUIT_HERO_CLICK, self.clearTimer, self)

    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSkip, self.onSkip)
    self:addUIEvent(self.mImgMsk, self.onClickMask)
end

function onClickMask(self)
    -- self:close()
    GameDispatcher:dispatchEvent(EventName.RECRUIT_OPEN_DOOR)
end

function onSkip(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.RECRUIT_SKIP)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
