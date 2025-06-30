--[[ 
-----------------------------------------------------
@filename       : DupApostlesRewardItem
@Description    : 使徒之战奖励item
@date           : 2021-06-13 20:03:20
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.item.DupApostlesRewardItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mPropsGridList = {}
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    -- self.mTxtAllNum = self:getChildGO("mTxtAllNum"):GetComponent(ty.Text)
    -- self.mTxtDesc = self:getChildGO("mTxtDesc"):GetComponent(ty.Text)
    self.mTxtStage = self:getChildGO("mTxtStage"):GetComponent(ty.Text)
    self.Content = self:getChildTrans("mContent")

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mTxtGeted = self:getChildGO("mTxtGeted"):GetComponent(ty.Text)
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)
    self.mBlackLine = self:getChildGO("mBlackLine"):GetComponent(ty.Image)
    self.mImgProgress = self:getChildGO("mImgProgress"):GetComponent(ty.Image)
    self.mTxtGet = _TT(3)
    self.mTxtGeted = _TT(7)
    self.mTxtIng = _TT(36520)
    self:addOnClick(self.mBtnGet, self.onClickGet)
end

function setData(self, param)
    super.setData(self, param)
    self.mInfoData = dup.DupApostlesWarManager:getPanelInfo()
    self:recoverAllGrid()
    self.mTxtName.text = _TT(self.data.title)
    self.mTxtStage.text = "阶段" .. self.data.id
    self.mTxtCurNum.text = self.mInfoData.starNum .. "/" .. self.data.star
    self.mImgProgress.fillAmount = self.mInfoData.starNum / self.data.star
    local state = 1
    local hasGetList = self.mInfoData.receivedStarId
    if (self.mInfoData.starNum >= self.data.star) then
        state = 0
        for i = 1, #hasGetList do
            if (hasGetList[i] == self.data.id) then
                state = 2
            end
        end
    end
    self.mBlackLine.gameObject:SetActive(true)
    if state == 0 then
        -- 0:已完成未领奖
        self.mBlackLine.color = gs.ColorUtil.GetColor("ffb644ff")
        self.mBtnGet:SetActive(true)
        self.mGroupGeted:SetActive(false)
        self.mGroupIng:SetActive(false)
    elseif state == 1 then
        -- 1:未完成    
        self.mBlackLine.color = gs.ColorUtil.GetColor("000000ff")
        self.mBtnGet:SetActive(false)
        self.mGroupGeted:SetActive(false)
        self.mGroupIng:SetActive(true)
        self.mTxtCurNum.text = self.mInfoData.starNum .. "/" .. self.data.star
    else
        -- 2：已领取奖励
        self.mBlackLine.gameObject:SetActive(false)
        self.mBtnGet:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mGroupIng:SetActive(false)
    end

    for i = 1, #self.data.rewards do
        local propsGrid = PropsGrid:create(self.Content, self.data.rewards[i])
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function onClickGet(self)
    GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_START_REWARD, self.data.id)  --请求获取奖励
end

function recoverAllGrid(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
    LoopManager:clearTimeout(self.tweenId)
    self.tweenId = nil
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3528):	"星级奖励"
	语言包: _TT(36520):	"进行中"
	语言包: _TT(7):	"已领取"
	语言包: _TT(3):	"领取"
]]