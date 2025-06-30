--[[ 
-----------------------------------------------------
@filename       : MainMapStageAwardItem
@Description    : 主线阶段性奖励
@date           : 2022-11-23 17:27:35
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("battleMap.MainMapStageAwardItem", Class.impl('lib.component.BaseItemRender'))
--构造函数
function ctor(self)
    super.ctor(self)
end
function onInit(self, go)
    super.onInit(self, go)
    self.mStageAwardItemList = {}
    self.mStageAwardList = {}

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mContent = self:getChildTrans("mContent")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)

    self:addOnClick(self.mBtnGet, self.onClickGetHandler)

    battleMap.MainMapManager:addEventListener(battleMap.MainMapManager.EVENT_STAGE_AWARD_UPDATE, self.updateDataView, self)
end

function setData(self, param)
    super.setData(self, param)
    self.mStageAwardList = {}
    self.mStageAwardList = self.data.stageAwardList
    self:updateDataView()
end

function updateDataView(self)
    self:recoverAllGrid()
    self.mTxtGet.text = _TT(412)--领取
    self.mTxtIng.text = _TT(36520)--进行中
    self.mTxtDes.text = _TT(2912)--阶段
    self.mTxtName.text = self.data.awardIndex
    self.mTxtTitle.text = _TT(2913, self.data.sort)
    self.mImgProBar.fillAmount = self.data.stageProgress / self.data.sort
    self.mTxtCurNum.text = self.mImgProBar.fillAmount >= 1 and _TT(45013, HtmlUtil:color(self.data.sort, "404548ff"), self.data.sort) or _TT(45013, HtmlUtil:color(self.data.stageProgress, "fa3a2bff"), self.data.sort)
    for _, awardVo in pairs(self.mStageAwardList) do
        local tempGrid = PropsGrid:create(self.mContent, { awardVo[1], awardVo[2] }, 1, false)
        table.insert(self.mStageAwardItemList, tempGrid)
    end
    self:updateSate()
end

function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_STORY_MAIN_STORY_STAGE_AWARD, { id = tostring(self.data.stageId) })
end

function updateSate(self)
    if #battleMap.MainMapManager:getReceivedStageAwardList() > 0 and table.indexof(battleMap.MainMapManager:getReceivedStageAwardList(), self.data.stageId) then
        self.mBtnGet:SetActive(false)
        self.mGroupIng:SetActive(false)
        self.mGroupGeted:SetActive(true)
    else
        self.mGroupGeted:SetActive(false)
        self.mBtnGet:SetActive(self.mImgProBar.fillAmount >= 1)
        self.mGroupIng:SetActive(self.mImgProBar.fillAmount < 1)
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
    battleMap.MainMapManager:removeEventListener(battleMap.MainMapManager.EVENT_STAGE_AWARD_UPDATE, self.updateDataView, self)
    self:recoverAllGrid()
end
function onDelete(self)
    super.onDelete(self)

end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71308):	"继续挑战"
]]