module("branchStory.BranchMainStageItem", Class.impl(BaseComponent))

function __initData(self)
    super.__initData(self)
    self.m_linePrefabName = ""
    self.m_parent = nil
    self.m_nextNodeTrans = nil
    self.m_lineGo = nil
    self.m_goPointDic = nil
    self.m_goSelectPointDic = nil
    self.m_imgBg = nil
    self.mTxtName = nil
    self.m_normalTxtName = nil
    self.m_goLock = nil
    self.m_goSelect = nil
    self.m_transArrow = nil
    self.m_arrowTween = nil
    self.m_textShadow = nil
    self.m_figthImg = nil
end

function __reset(self)
    if (self.m_lineGo and not gs.GoUtil.IsGoNull(self.m_lineGo)) then
        gs.GOPoolMgr:Recover(self.m_lineGo, self.m_linePrefabName)
    end
    if self.m_arrowTween then
        self.m_arrowTween:Kill()
        self.m_arrowTween = nil
    end
    super.__reset(self)
end

function getStageVo(self)
    return self:getData().data
end

function __getPrefabName(self)
    local stageType = self:getStageVo().type
    if (stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight) then
        return UrlManager:getUIPrefabPath("branchStory/map/BranchStoryStageItem.prefab")
    elseif(stageType == battleMap.MainMapStageType.Story)then
        return UrlManager:getUIPrefabPath("branchStory/map/BranchStoryStoryItem.prefab")
    end
    return ""
end

function __initGo(self)
    self.m_goPointDic = {}
    self.m_goSelectPointDic = {}
    for pointIndex = 1, 4 do
        self.m_goPointDic[pointIndex] = self.m_childGos["ImgPoint_" .. pointIndex]
        self.m_goSelectPointDic[pointIndex] = self.m_childGos["ImgSelectPoint_" .. pointIndex]
    end
    self.m_imgBg = self.m_uiGo:GetComponent(ty.AutoRefImage)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_normalTxtName = self.m_childGos["NormalTextName"]:GetComponent(ty.Text)
    self.m_textShadow = self.m_childGos["TextName"]:GetComponent(ty.Shadow)
    self.m_goLock = self.m_childGos["ImgLock"]
    self.m_goSelect = self.m_childGos["ImgSelect"]
    self.m_transArrow = self.m_childTrans["ImgArrow"]
    self.m_goPass = self.m_childGos["ImgPass"]
    self.m_figthImg = self.m_childGos["FightImg"]
    self.mBranchStoryStageIcon = self:getChildGO("BranchStoryStageIcon")
end

-- 更新信息显示
function __updateCustomView(self)
    self:__updateLineAssets()
    self:__updateContentView()
end

function getCanPass(self)
    return branchStory.BranchStoryManager:isStagePass(self:getStageVo().chapterId, self:getStageVo().stageId)
end

function __updateLineAssets(self)
    local stageVo = self:getStageVo()
    local canPass = self:getCanPass()

    if (#stageVo.pointLineData >= 2) then
        local pointIndex = stageVo.pointLineData[1]
        local lineType = stageVo.pointLineData[2]
        if canPass then
            self.m_linePrefabName = UrlManager:getUIPrefabPath("branchStory/map/BranchStoryLine_" .. lineType .. ".prefab")
        else
            self.m_linePrefabName = UrlManager:getUIPrefabPath("branchStory/map/BranchStoryLineNoPass_" .. lineType .. ".prefab")
        end
        self.m_lineGo = gs.GOPoolMgr:Get(self.m_linePrefabName).gameObject
        self.m_lineGo.transform:SetParent(self.m_childTrans["point_" .. pointIndex], false)
        self.m_nextNodeTrans = self.m_lineGo.transform:Find("NodeNext").transform
    end
end

function __updateContentView(self)
    local stageVo = self:getStageVo()
    local pointIndex = nil
    if (#stageVo.pointLineData >= 2) then
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
        self.m_transArrow.gameObject:SetActive(false)
        if(stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_1.png")
        elseif (stageType == battleMap.MainMapStageType.Story)then
            source = UrlManager:getPackPath("branchStory4/branchStory_map_2.png")
        else
            source = ""
        end
        self.mTxtName.gameObject:SetActive(true)
        
    elseif branchStory.BranchMainManager:canMainStageFight(stageVo.chapterId, stageId) then
        self.m_goLock:SetActive(false)
        self.mBranchStoryStageIcon:SetActive(true)
        self.m_goPass:SetActive(false)
        self.m_transArrow.gameObject:SetActive(true)
       
        self:__tweenArrow()
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
        self.m_transArrow.gameObject:SetActive(false)
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

function setSelectState(self, isSelect)
    for _, go in pairs(self.m_goSelectPointDic) do
        go:SetActive(isSelect)
    end
    self.m_goSelect:SetActive(isSelect)

    if isSelect then
        self.m_transArrow.gameObject:SetActive(true)
        self:__tweenArrow()
    else
        self.m_transArrow.gameObject:SetActive(false)
    end
end

function getNextNodeTrans(self)
    return self.m_nextNodeTrans
end

function getSize(self)
    local stageVo = self:getStageVo()
    local stageType = stageVo.type
    if (stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight) then
        return 178, 40
    elseif (stageType == battleMap.MainMapStageType.Story) then
        return 65, 69
    elseif (stageType == battleMap.MainMapStageType.Boss) then
        return 251, 179
    end
end

function getRelativePos(self, standardTrans)
    return standardTrans:InverseTransformPoint(self.m_uiGo.transform.position)
end

function __tweenArrow(self)
    if self.m_arrowTween then
        self.m_arrowTween:Kill()
        self.m_arrowTween = nil
    end
    gs.TransQuick:LPosY(self.m_transArrow, self:getArrowY())
    self.m_arrowTween = TweenFactory:move2LPosY(self.m_transArrow, self:getArrowY() + 10, 0.3, nil, nil, true)
end

function getArrowY(self)
    local stageVo = self:getStageVo()
    local stageType = stageVo.type
    if (stageType == battleMap.MainMapStageType.Normal or stageType == battleMap.MainMapStageType.StoryFight) then
        return 40
    elseif (stageType == battleMap.MainMapStageType.Story) then
        return 40
    elseif (stageType == battleMap.MainMapStageType.Boss) then
        return -125
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
