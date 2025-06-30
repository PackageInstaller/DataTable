-- @FileName:   OrganizeBackpacksSettlementPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('organizeBackpacks.OrganizeBackpacksSettlementPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("organizeBackpacks/OrganizeBackpackSettlementPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAddMask = 0 --窗口模式下是否需要添加mask (1 添加 0 不添加)

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
    self.mBtnNextFight = self:getChildGO("mBtnNextFight")
    self.mBtnExit = self:getChildGO("mBtnExit")
    -- self.props = self:getChildTrans("props")
    self.mDescItem = self:getChildGO("mDescItem")
    self.descLayer = self:getChildTrans("descLayer")
    self.mImgWin = self:getChildGO("mImgWin")

end

function initViewText(self)
    self:setBtnLabel(self.mBtnNextFight, 101014, "再次挑战")
    self:setBtnLabel(self.mBtnExit, 101013, "退出挑战")
end

--激活
function active(self, args)
    super.active(self)

    self.mStageId = args
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnExit, self.onExit)
    self:addUIEvent(self.mBtnNextFight, self.onNextFight)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function onExit(self)
    self:close()

    GameDispatcher:dispatchEvent(EventName.CLOSE_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
    GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
end

function onNextFight(self)
    self:close()
    
    GameDispatcher:dispatchEvent(EventName.CLOSE_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
    GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_PANEL, self.mStageId)
end

return _M
