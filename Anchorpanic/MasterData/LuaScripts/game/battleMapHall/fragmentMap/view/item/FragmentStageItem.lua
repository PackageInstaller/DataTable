--[[ 
    支线关卡城池item
]]
module("battleMap.FragmentStageItem", Class.impl(BaseComponent))

function __initData(self)
    super.__initData(self)

    self.mLinePrefabName = ""

    self.m_parent = nil
    self.mNextNodeTranses = {}
    self.mLineGos = {}

    self.mGoPointDic = nil
    self.mGoSelectPointDic = nil
    self.mImgBg = nil
    self.mTxtName = nil
    self.mImgLock = nil
    self.mImgSelect = nil
    self.mImgArrowTrans = nil
    --未解锁 “01” 解锁 “00”
    self.mUnlock = "01"
    self.mArrowTween = nil
end

function __reset(self)
    for k,v in pairs(self.mLineGos) do
        if (v and not gs.GoUtil.IsGoNull(v)) then
            gs.GOPoolMgr:Recover(v, self.mLinePrefabName)
        end
    end
    self.mNextNodeTranses = {}
    if self.mArrowTween then
        self.mArrowTween:Kill()
        self.mArrowTween = nil
    end
    super.__reset(self)
end

function getClickTrans(self)
    return self.m_childTrans["click"]
end

function onClickStageItemHandler(self, stageVo)
    local stageVo = self:getData()
    local stageId = stageVo.stageId

    GameDispatcher:dispatchEvent(EventName.SET_SELECT_MAIN_ITEM,{stageId = stageId})

    local function _openStage()
        GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_INFO, {stageId = stageId})
        GameDispatcher:dispatchEvent(EventName.UPDATE_MIAN_STAGE_LIST,{ stageId = stageId})
    end
    -- 已通关/未通关
    if battleMap.FragmentMapManager:isStagePass(stageId) or battleMap.FragmentMapManager:isStageCanFight(stageId) then
        _openStage()
    else
        local isActive, needPassStageId = stageVo:isActive()
        local needStageVo = battleMap.FragmentMapManager:getStageVo(needPassStageId)
        -- 未解锁
        gs.Message.Show(_TT(31717, battleMap.getMainMapStyleName(needStageVo.styleType), needStageVo.indexName))
    end
end

function __removeEventList(self)
end

function __addEventList(self)
    self:addOnClick(self.m_childGos["click"],self.onClickStageItemHandler)
end

function __getPrefabName(self)
    local stageVo = self:getData()
    local stageType = stageVo.type
    if (stageType == battleMap.FragmentMapStageType.Normal or stageType == battleMap.FragmentMapStageType.StoryFight) then
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_0_1.prefab")
    elseif (stageType == battleMap.FragmentMapStageType.Story) then
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_2.prefab")
    elseif (stageType == battleMap.FragmentMapStageType.Boss) then
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_3.prefab")
    elseif (stageType == battleMap.FragmentMapStageType.Explore) then
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_3.prefab")
    elseif (stageType == battleMap.FragmentMapStageType.Cream) then
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_4.prefab")
    else
        return UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageItem_0_1.prefab")
    end
end

function __initGo(self)
    self.mGoPointDic = {}
    self.mGoSelectPointDic = {}
    for pointIndex = 1, 4 do
        self.mGoPointDic[pointIndex] = self.m_childGos["mImgPoint_" .. pointIndex]
        self.mGoSelectPointDic[pointIndex] = self.m_childGos["mImgSelectPoint_" .. pointIndex]
    end
    self.mImgStageGo = self.m_childGos["mImgStage"]
    if self.mImgStageGo then
     self.mImgStage = self.mImgStageGo:GetComponent(ty.AutoRefImage) 
    end
    self.mTxtName = self.m_childGos["mTxtName"]:GetComponent(ty.Text)
    self.mImgLock = self.m_childGos["mImgLock"]
    self.mImgSelect = self.m_childGos["mImgSelect"]
    
    self.mImgArrowTrans = self.m_childTrans["mImgArrow"]
    self.mTxtExploreTip = self.m_childGos["mTxtExploreTip"]:GetComponent(ty.Text)

    self.mImgPass = self.m_childGos["mImgPass"]
    self.mGroup = self.m_childGos["Group"]
    self.mImgNameBg = self:getChildGO("mImgNameBg"):GetComponent(ty.Image)

    self.mEff = self.m_childGos["eff"]

    self:setGuideTrans("guide_mainMapStage_item_" .. self:getData().stageId, self:getClickTrans())
end

-- 更新信息显示
function __updateCustomView(self)
    if battleMap.FragmentMapManager:isStagePass(self:getData().stageId) then 
        self:updateLineAssets()
    end
    self:updateContentView()
    self:updateStyle()
end

function updateLineAssets(self)
    local stageVo = self:getData()
    local canPass = battleMap.FragmentMapManager:isStagePass(stageVo.stageId)
    if canPass then
        self.mLinePrefabName = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageLine_3.prefab")
    else
        self.mLinePrefabName = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainStageLineNoPass_3.prefab")
    end
    for k,v in pairs(stageVo.pointLineData) do
        local pointIndex = v[1]
        local rotation = v[2]
        local length = v[3]
        local nextStageId = v[4]
        local lineGo = gs.GOPoolMgr:Get(self.mLinePrefabName):GetComponent(ty.RectTransform)
        lineGo.eulerAngles = gs.Vector3(0, 0, rotation) 

        lineGo.sizeDelta = gs.Vector2(length, lineGo.rect.height)
        lineGo:SetParent(self.m_childTrans["point_" .. pointIndex], false)
        self.mNextNodeTranses[nextStageId] = lineGo:Find("NodeNext").transform
        table.insert(self.mLineGos, lineGo.gameObject)
    end
end

function updateContentView(self)
    local stageVo = self:getData()
    local pointIndex = nil
    if (#stageVo.pointLineData >= 2) then
        pointIndex = stageVo.pointLineData[1]
    end

    local stageId = stageVo.stageId
    
    if battleMap.FragmentMapManager:isStagePass(stageId) then
        self.mImgLock:SetActive(false)
        self.mImgPass:SetActive(true)
    elseif battleMap.FragmentMapManager:isStageCanFight(stageId) then
        self.mImgLock:SetActive(false)
        self.mImgPass:SetActive(false)
    else
        self.mImgLock:SetActive(true)
        self.mImgPass:SetActive(false)
    end

    self.mTxtName.text = stageVo.indexName

    -- local exploreStageId = battleMap.FragmentMapManager:getCurExploreStageId()
    -- if (exploreStageId == stageVo.stageId) then
    --     self.mTxtExploreTip.text = _TT(71308)
    -- else
    --     self.mTxtExploreTip.text = ""
    -- end
end

function setShowFirstEff(self,show)
    self.mEff:SetActive(show)
end

function setSelectState(self, isSelect)
    self.isSelect = isSelect
    for _pointIndex, go in pairs(self.mGoSelectPointDic) do
        go:SetActive(isSelect)
    end
    self.mImgSelect:SetActive(isSelect)
    if isSelect then
        self.mImgArrowTrans.gameObject:SetActive(true)
        self:tweenArrow()
    else
        self.mImgArrowTrans.gameObject:SetActive(false)
    end
end

function getSelectState(self)
    return self.isSelect
end

function getNextNodeTrans(self)
    return self.mNextNodeTranses
end

function getSize(self)
    local stageVo = self:getData()
    local stageType = stageVo.type
    if (stageType == battleMap.FragmentMapStageType.Normal or stageType == battleMap.FragmentMapStageType.StoryFight) then
        return 188, 58
    elseif (stageType == battleMap.FragmentMapStageType.Story) then
        return 72, 82
    elseif (stageType == battleMap.FragmentMapStageType.Boss) then
        return 231, 142
    elseif (stageType == battleMap.FragmentMapStageType.Explore) then
        return 231, 142
    end
    return 231, 142
end

function getRelativePos(self, standardTrans)
    local x = self.m_uiGo.transform.position.x
    local y = self.m_uiGo.transform.position.y
    local z = self.m_uiGo.transform.position.z
    local xx = standardTrans.position.x
    local yy = standardTrans.position.y
    local zz = standardTrans.position.z
    local size = standardTrans:GetComponent(ty.RectTransform).sizeDelta
    local a = standardTrans:InverseTransformPoint(self.m_uiGo.transform.position)
    return standardTrans:InverseTransformPoint(self.m_uiGo.transform.position)
end

function updateStyle(self)
    local styleType = battleMap.FragmentMapManager.style and battleMap.FragmentMapManager.style or battleMap.FragmentMapStyleType.Easy
    local stageVo = self:getData()
    local stageType = stageVo.type

    self.isPass = battleMap.FragmentMapManager:isStagePass(stageVo.stageId)
    self.isFight = battleMap.FragmentMapManager:isStageCanFight(stageVo.stageId)
    self.mUnlock = "00"
    if (self.isPass) then
        self.state = 1
    elseif (self.isFight) then
        self.state = 2
    else
        self.state = 3
        self.mUnlock = "01"
    end

    --锚点空间未出图，暂时按照boss版出
    if stageType == battleMap.FragmentMapStageType.Explore then
        stageType = battleMap.FragmentMapStageType.Boss
    end

    if (stageType == battleMap.FragmentMapStageType.Boss) then
        local source = UrlManager:getPackPath("mainMap4/mainMap_0" .. stageVo.chapter .. "_0" .. stageType .. "_" .. self.mUnlock .. ".png")
        self.mImgStage:SetImg(source, true)
    end

end

function setShowInfo(self, isShow)
end

function tweenArrow(self)
    if self.mArrowTween then
        self.mArrowTween:Kill()
        self.mArrowTween = nil
    end
    gs.TransQuick:LPosY(self.mImgArrowTrans, self:getArrowY())
    self.mArrowTween = TweenFactory:move2LPosY(self.mImgArrowTrans, self:getArrowY() + 10, 0.3, nil, nil, true)
end

function getArrowY(self)
    return 70
end

function poolRecover(self)
    self:getTrans().localEulerAngles = gs.Vector3(0, 0, 0)
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71308):	"继续挑战"
]]