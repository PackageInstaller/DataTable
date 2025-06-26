--[[ 
-----------------------------------------------------
@filename       : MiningStarAwardItem
@Description    : 挖矿阶段奖励item
@date           : 2023-12-13 17:54:17
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.MiningStarAwardItem', Class.impl('lib.component.BaseItemRender'))

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
    GameDispatcher:dispatchEvent(EventName.REQ_MINING_GAIN_STAR_REWARD, { self.data.config.id })
end

function setData(self, param)
    super.setData(self, param)

    self.mTxtTitle.text = _TT(self.data.config.des)

    self.mPropsGridList = {}
    local awardList = self.data.config.reward
    for i = 1, #awardList do
        local propsGrid = PropsGrid:createByData({ tid = awardList[i][1], num = awardList[i][2], parent = self.mContent })
        propsGrid:setHasRec(false)
        table.insert(self.mPropsGridList, propsGrid)
    end

    self.mBtnGet:SetActive(self.data.isCanGet)

    self.mGroupGeted:SetActive(self.data.isGet)
    if not self.data.isCanGet and not self.data.isGet then
        self.mTextCurStar.gameObject:SetActive(true)
        self.mTextMaxStar.gameObject:SetActive(true)

    else
        self.mTextCurStar.gameObject:SetActive(false)
        self.mTextMaxStar.gameObject:SetActive(false)

    end
    self.mTextCurStar.text = self.data.starCount
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

function onDelete(self)
    super.onDelete(self)
end

return _M