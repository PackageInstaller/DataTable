module("branchStory.BranchPowerChapterItem", Class.impl(branchStory.BranchMainChapterItem))

function onInit(self, go)
    super.onInit(self, go)
    self.mComplete = self:getChildGO('Complete')
end

function onClickItemHandler(self)
    local chapterVo = self.data
    if(battleMap.MainMapManager:isStagePass(chapterVo.unlockStage)) then 
        branchStory.BranchPowerManager:setLastId(chapterVo.chapterId)
        formation.checkFormationFight(PreFightBattleType.BranchPower, nil, chapterVo.chapterId, nil, nil, nil)
    else
        gs.Message.Show(_TT(25204))
    end
end

function onClickAwardHandler(self)
    local chapterVo = self.data
    local propsList = AwardPackManager:getAwardListById(chapterVo.showDrop)
    GameDispatcher:dispatchEvent(EventName.OPEN_DAILY_TASK_AWARD_PANEL, { tip = _TT(44210), propsList = propsList })
end

function setData(self, param)
    super.setData(self, param)

    local chapterVo = self.data
    self.mTextName.text = _TT(chapterVo.mName)
    self.mIconImg:SetImg(UrlManager:getIconPath(chapterVo.mIconPath))
    local canFight = battleMap.MainMapManager:isStagePass(chapterVo.unlockStage)
    self.mLockTxt.gameObject:SetActive(false)
    self.mGroupUnlock:SetActive(false)
    self.mLockImg:SetActive(not canFight)

    local isPass = branchStory.BranchPowerManager:isPass(chapterVo.chapterId)
    self.mImgAward:SetGray(isPass)
    self.mComplete:SetActive(isPass)     --已领取
    self.mImgName.color = gs.ColorUtil.GetColor("242728ff")
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44210):	"通关可获得"
]]
