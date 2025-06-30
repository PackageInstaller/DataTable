--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarGoalItem
@Description    : 使徒之战目标奖励
@date           : 2021-08-12 20:03:20
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostle_war.view.item.DupApostlesWarGoalItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)

    self.m_propsGridList = {}

    self.mTxtInfo = self:getChildGO("mTxtInfo"):GetComponent(ty.Text)
    self.mTxtOver = self:getChildGO("mTxtOver"):GetComponent(ty.Text)
    self.Content = self:getChildTrans("Content")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnUnFinish = self:getChildGO("mBtnUnFinish")

    self:addOnClick(self.mBtnGet, self.onClickGet)
end

function setData(self, param)
    super.setData(self, param)

    self:recoverAllGrid()

    self.mTxtInfo.text = _TT(self.data.langId, self.data.param)

    if self.data.state == 0 then
        -- 0:已完成未领奖
        self.mBtnGet:SetActive(true)
        self.mBtnUnFinish:SetActive(false)
        self.mTxtOver.gameObject:SetActive(false)
    elseif self.data.state == 1 then
        -- 1:未完成
        self.mBtnGet:SetActive(false)
        self.mBtnUnFinish:SetActive(true)
        self.mTxtOver.gameObject:SetActive(false)
    else
        -- 2：已领取奖励
        self.mBtnGet:SetActive(false)
        self.mBtnUnFinish:SetActive(false)
        self.mTxtOver.gameObject:SetActive(true)
    end

    for i = 1, #self.data.rewards do
        local propsGrid = PropsGrid:create(self.Content, self.data.rewards[i], 0.7)
        table.insert(self.m_propsGridList, propsGrid)
    end
end

function onClickGet(self)
    if self.data.state == 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_APOSTLES_WAR_REWARD, self.data.id)
    else
        gs.Message.Show(_TT(36516))
    end
end

function recoverAllGrid(self)
    for i = 1, #self.m_propsGridList do
        self.m_propsGridList[i]:poolRecover()
    end
    self.m_propsGridList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(36516):	"领取失败"
]]
