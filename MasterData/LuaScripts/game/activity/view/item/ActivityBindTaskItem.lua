module("activity.ActivityBindTaskItem", Class.impl("lib.component.BaseItemRender"))

--构造函数
function ctor(self)
    super.ctor(self)
    self.mAwardItemList = {}
end
function onInit(self, go)
    super.onInit(self, go)
    self.mImgIng = self:getChildGO("mImgIng")
    self.mBtnRecive = self:getChildGO("mBtnRecive")
    self.mImgRecived = self:getChildGO("mImgRecived")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
    self.mImgBar = self:getChildGO("mImgBar"):GetComponent(ty.Image)
    self.mTxtPress = self:getChildGO("mTxtPress"):GetComponent(ty.Text)
    self.mTxtTaskDes = self:getChildGO("mTxtTaskDes"):GetComponent(ty.Text)
    self.mTxtTaskName = self:getChildGO("mTxtTaskName"):GetComponent(ty.Text)
    self:setBtnLabel(self.mImgIng, 36520, "进行中")
    self:setBtnLabel(self.mBtnRecive, 412, "领取")
    self:addOnClick(self.mBtnRecive, self.onClickGetHandler)
end

function setData(self, param)
    super.setData(self, param)
    self:updateDataView()
end

function updateDataView(self)
    self:recoverAllGrid()
    local curNum=self.data.msgData.count
    self.mTxtTaskDes.text = _TT(self.data.describe)
    --self.mTxtTaskName.text = _TT(self.data.title)
    self.mTxtPress.text=_TT(45013,curNum,self.data.time)
    self.mImgBar.fillAmount=curNum/self.data.time
    self.mImgIng:SetActive(self.data.msgData.state==Celebration.CelebrationConst.CelebrationTaskState.Nomal)
    self.mBtnRecive:SetActive(self.data.msgData.state==Celebration.CelebrationConst.CelebrationTaskState.Recive)
    self.mImgRecived:SetActive(self.data.msgData.state==Celebration.CelebrationConst.CelebrationTaskState.Recived)
    for _, awardVo in pairs(self.data.reward) do
        local tempGrid = PropsGrid:create(self.mAwardTrans, { awardVo[1], awardVo[2] }, 1, false)
        table.insert(self.mAwardItemList, tempGrid)
    end
end

function onClickGetHandler(self)
    local type = activity.ActitvityExtraManager:getJointPlayerType()
    local jointPlayerInfo = activity.ActitvityExtraManager:getJointPlayerInfo()
    if jointPlayerInfo.player_id ~= "0" then
        GameDispatcher:dispatchEvent(EventName.REQ_JOINT_TASK_RECEIVE,{taskIdList = {self.data.id}} ) 
    else
        gs.Message.Show(_TT(41789))
    end
end

function recoverAllGrid(self)
    if #self.mAwardItemList>0 then
        for i = 1, #self.mAwardItemList do
            self.mAwardItemList[i]:poolRecover()
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