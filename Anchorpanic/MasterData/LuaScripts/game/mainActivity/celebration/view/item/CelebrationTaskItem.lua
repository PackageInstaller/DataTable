--[[ 
-----------------------------------------------------
@filename       : CelebrationTaskItem
@Description    : --周年庆典--庆典任务Item
@date           : 2024-06-20 14:51:00
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module("Celebration.CelebrationTaskItem", Class.impl('lib.component.BaseItemRender'))
--构造函数
function ctor(self)
    super.ctor(self)
    self.mAwardItemList = {}
end
function onInit(self, go)
    super.onInit(self, go)
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mBtnRecive = self:getChildGO("mBtnRecive")
    self.mImgRecived = self:getChildGO("mImgRecived")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
    self.mTxtPress = self:getChildGO("mTxtPress"):GetComponent(ty.Text)
    self.mTxtTaskName = self:getChildGO("mTxtTaskName"):GetComponent(ty.Text)
    self:setBtnLabel(self.mBtnGoto, 4, "前往")
    self:setBtnLabel(self.mBtnRecive, 412, "领取")
    self:addOnClick(self.mBtnRecive, self.onClickGetHandler)
    self:addOnClick(self.mBtnGoto, self.onClickGotoHandler)
end

function setData(self, param)
    super.setData(self, param)
    self:updateDataView()
end

function updateDataView(self)
    self:recoverAllGrid()
    self.mTxtTaskName.text = self.data:getDes()
    self.mImgBar.fillAmount=self.data:getProgress()
    self.mTxtPress.text=self.data:getProgressShow()
    self.mBtnGoto:SetActive(self.data:getState()==Celebration.CelebrationConst.CelebrationTaskState.Nomal)
    self.mBtnRecive:SetActive(self.data:getState()==Celebration.CelebrationConst.CelebrationTaskState.Recive)
    self.mImgRecived:SetActive(self.data:getState()==Celebration.CelebrationConst.CelebrationTaskState.Recived)
    for _, awardVo in pairs(self.data:getAwardList()) do
        local tempGrid = PropsGrid:create(self.mAwardTrans, { awardVo.tid, awardVo.num  }, 1, false)
        table.insert(self.mAwardItemList, tempGrid)
    end
    self:updateSate()
end

function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_CELEBRATION_TASK_AWARD, { self.data.id })
end

function onClickGotoHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.data:getUICode() })
end

function updateSate(self)
    
end
function recoverAllGrid(self)
    if #self.mAwardItemList>0 then
        for i, item in ipairs(self.mAwardItemList) do
            item:poolRecover()
            item=nil
        end
    end
    self.mAwardItemList = {}
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
	语言包: _TT(71308):	"继续挑战"
]]