-- @FileName:   SandPlayFishingResultPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.view.SandPlayFishingResultPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("sandPlay/SandPlayFishingResultPanel.prefab")

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
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTextName = self:getChildGO("mTextName"):GetComponent(ty.Text)
    self.mTextCount = self:getChildGO("mTextCount"):GetComponent(ty.Text)
    self.mTextSize = self:getChildGO("mTextSize"):GetComponent(ty.Text)
    self.mClose = self:getChildGO("mClose")

    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)
    self.mTextAutoFish = self:getChildGO("mTextAutoFish"):GetComponent(ty.Text)
end

function initViewText(self)

end

--激活
function active(self, args)
    super.active(self)

    self.data = args
    local fishConfigVo = sandPlay.SandPlayManager:getFishConfigVo(self.data.result.fish_info.fish_id)
    if fishConfigVo then
        self.mImgIcon:SetImg(fishConfigVo:getBodyPath())

        self.mTextName.text = _TT(fishConfigVo.name)
        self.mTextCount.text = _TT(98330, self.data.result.fish_info.amount)
        self.mTextSize.text = _TT(98342, self.data.result.fish_info.cur_size * 0.01)
    end

    if sandPlay.SandPlayManager:isAutoFish() then
        if bag.BagManager:getPropsCountByTid(self.data.bait_id) > 0 then
            self.mTextAutoFish.gameObject:SetActive(true)

            self.mAutoTime = 3
            self.mTextAutoFish.text = _TT(98976, self.mAutoTime)

            self:addTimer(1, self.mAutoTime, self.refreshAutoFishTime, self.onAutoFish)
        else
            self.mTextAutoFish.gameObject:SetActive(false)
        end
    else
        self.mTextAutoFish.gameObject:SetActive(false)
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mClose, self.onClickClose)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

end

-- 玩家点击关闭
function onClickClose(self)
    super.__closeOpenAction(self)

    ShowAwardPanel:showPropsAwardMsg(self.data.result.award_list, function ()
        if self.data.finishCall then
            self.data.finishCall(false)
        end
    end)
end

function refreshAutoFishTime(self)
    self.mAutoTime = self.mAutoTime - 1
    self.mTextAutoFish.text = _TT(98976, self.mAutoTime)
end

function onAutoFish(self)
    self:close()

    if self.data.finishCall then
        self.data.finishCall(true)
    end

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_START_FISHING)
end

return _M
