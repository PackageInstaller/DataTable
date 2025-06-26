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
end

-- 初始化
function configUI(self)
    self.mImgBlack = self:getChildGO("mImgBlack")
    self.mImgBlackAni = self.mImgBlack:GetComponent(ty.Animator)
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
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    GameDispatcher:removeEventListener(EventName.SHOW_BIGHOSTEL_BLACK, self.onShowBlack, self)
    GameDispatcher:removeEventListener(EventName.HIDE_BIGHOSTEL_BLACK, self.onHideBlack, self)
end

function getUiNodeName(self)
    return "SCENE"
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
