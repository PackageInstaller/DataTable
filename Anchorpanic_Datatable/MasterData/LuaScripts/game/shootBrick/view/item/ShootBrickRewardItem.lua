-- @FileName:   ShootBrickRewardItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2024-02-01 11:10:37
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.view.ShootBrickRewardItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mContent = self:getChildTrans("mContent")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mTextCurStar = self:getChildGO("mTextCurStar"):GetComponent(ty.Text)
    self.mTextMaxStar = self:getChildGO("mTextMaxStar"):GetComponent(ty.Text)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, self.onGetAward)
end

function onGetAward(self)
    GameDispatcher:dispatchEvent(EventName.ONREQ_SHOOTBRICK_GET_AWARD, {self.data.config.id})
end

function setData(self, param)
    super.setData(self, param)

    self.mTxtTitle.text = _TT(self.data.config.des)

    self.mPropsGridList = {}
    local awardList = self.data.config.reward
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({tid = awardList[i][1], num = awardList[i][2], parent = self.mContent})
        propsGrid:setHasRec(false)
        table.insert(self.mPropsGridList, propsGrid)
    end

    self.mBtnGet:SetActive(self.data.state == 0)
    self.mGroupGeted:SetActive(self.data.state == 2)

    self.mTextCurStar.gameObject:SetActive(self.data.state == 1)
    self.mTextMaxStar.gameObject:SetActive(self.data.state == 1)

    self.mTextCurStar.text = self.data.star_count
    self.mTextMaxStar.text = "/" .. self.data.config.star_num
end

function deActive(self)
    super.deActive(self)

    if self.mPropsGridList ~= nil then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
        self.mPropsGridList = {}
    end
end

return _M
