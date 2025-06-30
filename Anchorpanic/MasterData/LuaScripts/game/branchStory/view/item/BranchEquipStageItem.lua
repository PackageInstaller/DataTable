--[[ 
    关卡城池item
]]
module("branchStory.BranchEquipStageItem", Class.impl(branchStory.BranchMainStageItem))

function getStageVo(self)
    return self:getData()
end

function getCanPass(self)
    return branchStory.BranchStoryManager:isStagePass(self:getStageVo().stageId)
end

function __updateContentView(self)    
    self.mBranchStoryStageIcon:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("tacticeTrain/img_stage_item_bz.png"), false)
    local stageVo = self:getStageVo()
    local pointIndex = nil
    if(#stageVo.pointLineData >= 2)then
        pointIndex = stageVo.pointLineData[1]
    end

    local stageType = stageVo.type
    if(stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight)then
        self.mTxtName.text = stageVo:getName()
    elseif(stageType == battleMap.MainMapStageType.Story)then
        self.mTxtName.text = ""
    elseif(stageType == battleMap.MainMapStageType.Boss)then
        self.mTxtName.text = stageVo.stageId .. " " .. stageVo:getName()
    end
    
    local source
    local stageId = stageVo.stageId
   
    if self:getCanPass() then
        self.m_goLock:SetActive(false)
        self.mBranchStoryStageIcon:SetActive(true)
        self.m_goPass:SetActive(true)
        if(stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_1.png")
        elseif (stageType == battleMap.MainMapStageType.Story)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_2.png")
        else
            source = ""
        end
        self.mTxtName.gameObject:SetActive(true)
    elseif branchStory.BranchStoryManager:canStageFight(stageId) then
        self.m_goLock:SetActive(false)
        self.mBranchStoryStageIcon:SetActive(true)
        self.m_goPass:SetActive(false)
        if(stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_1.png")
        elseif (stageType == battleMap.MainMapStageType.Story)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_2.png")
        else
            source = ""
        end
        self.mTxtName.gameObject:SetActive(true)
    else
        self.m_goLock:SetActive(true)
        self.mBranchStoryStageIcon:SetActive(false)
        self.m_goPass:SetActive(false)
        --self.m_transArrow.gameObject:SetActive(false)
        if(stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_1.png")
        elseif (stageType == battleMap.MainMapStageType.Story)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_2.png")
        else
            source = ""
        end
        self.mTxtName.gameObject:SetActive(true)
    end
    self.m_imgBg:SetImg(source, true)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
