--[[ 
-----------------------------------------------------
@filename       : MainMapStageAwardItem
@Description    : 主线阶段性奖励
@date           : 2022-11-23 17:27:35
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("mainActivity.ActiveDupStageAwardItem", Class.impl('lib.component.BaseItemRender'))
--构造函数
function ctor(self)
    super.ctor(self)
end
function onInit(self, go)
    super.onInit(self, go)
    self.mStageAwardItemList = {}
    self.mStageAwardList = {}
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mContent = self:getChildTrans("mContent")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self:addOnClick(self.mBtnGet, self.onClickGetHandler)
    mainActivity.ActiveDupManager:addEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE, self.updateDataView, self)
end

function setData(self, param)
    super.setData(self, param)
    self.mStageAwardList = {}
    self.mStageAwardList = self.data.reward
    self:updateDataView()
end

function updateDataView(self)
    self:recoverAllGrid()
    self.mTxtGet.text = _TT(412)--领取
    -- self.mTxtIng.text = _TT(36520)--进行中
    -- self.mTxtDes.text = _TT(2912)--阶段
    self.mTxtTitle.text = _TT(self.data.des)
    self.mNowStar = mainActivity.ActiveDupManager:getAllStarNum()
    local stepStarNum = mainActivity.ActiveDupManager:getAllStepConfig()[self.data.stepId].starNum
    self.mTxtCurNum.text = _TT(45013, "<size=38>"..self.mNowStar .. "</size>", stepStarNum)
    for _, awardVo in pairs(self.mStageAwardList) do
        local tempGrid = PropsGrid:create(self.mContent, { awardVo[1], awardVo[2] }, 1, false)
        table.insert(self.mStageAwardItemList, tempGrid)
    end
    self:updateSate()
end

function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVEDUP_STAGE_AWARD, { id = tostring(self.data.stepId) })
end

function updateSate(self)
    self.mTxtCurNum.gameObject:SetActive(self.data.type ~= 2)
    if self.data.type == 2 then 
        self.mBtnGet:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mImgBar.color = gs.ColorUtil.GetColor("000000ff")
    elseif self.data.type == 1 then 
        self.mGroupGeted:SetActive(false)
        self.mBtnGet:SetActive(false)
        self.mImgBar.color = gs.ColorUtil.GetColor("000000ff")
    else
        self.mGroupGeted:SetActive(false)
        self.mBtnGet:SetActive(true)
        self.mImgBar.color = gs.ColorUtil.GetColor("ffe76fff")
    end
end
function recoverAllGrid(self)
    for i = 1, #self.mStageAwardItemList do
        self.mStageAwardItemList[i]:poolRecover()
    end
    self.mStageAwardItemList = {}
end

function deActive(self)
    super.deActive(self)
    mainActivity.ActiveDupManager:removeEventListener(mainActivity.ActiveDupManager.EVENT_STAGE_AWARD_UPDATE, self.updateDataView, self)
    self:recoverAllGrid()
end
function onDelete(self)
    super.onDelete(self)

end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71308):	"继续挑战"
]]