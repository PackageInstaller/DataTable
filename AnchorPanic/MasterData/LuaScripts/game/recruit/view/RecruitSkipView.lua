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
isScreensave = 0
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
    self.ContentTxt = self:getChildGO("ContentTxt"):GetComponent(ty.Text)
    self.mFfxRecTran = self.mFfx:GetComponent(ty.RectTransform)
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.ContentTxt.text = _TT(10000348)--"長按充能"
    self:setBtnLabel(self.mBtnSkip, 46805, "跳过")

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSkip, self.onSkip)
    self:addUIEvent(self.mImgMsk, self.onClickMask)
end

--激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.RECRUIT_HERO_CLICK, self.clearTimer, self)

    -- self:refreshView(args)
end

--反激活（销毁工作）
function deActive(self)
    GameDispatcher:removeEventListener(EventName.RECRUIT_HERO_CLICK, self.clearTimer, self)

    super.deActive(self)
end

function refreshView(self, args)
    self.mBtnSkip:SetActive(args.isNeedSkip)
    self.mImgMsk:SetActive(args.isNeedClick)
    self.mSkillCallFun = args.skillCall

    self.mFfx:SetActive(false)

    if args.isNeedEfx then
        self.mFfx:SetActive(true)
        gs.CameraMgr:World2UI(args.efxPoint.position, self.mFfxRecTran.parent, self.mFfxRecTran)
    end
end

function clearTimer(self)
    self.mFfx:SetActive(false)
end

function onClickMask(self)
    self:close()
    GameDispatcher:dispatchEvent(EventName.RECRUIT_OPEN_DOOR)
end

function onSkip(self)
    self:close()

    if self.mSkillCallFun then
        self.mSkillCallFun()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
