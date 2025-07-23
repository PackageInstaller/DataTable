--[[ 
    主线关卡城池item
]]
module("mainActivity.ActiveDupStageItem", Class.impl(BaseComponent))

function __initData(self)
    super.__initData(self)

    self.mLinePrefabName = ""

    self.m_parent = nil
    self.mNextNodeTranses = {}
    self.mLineGos = {}

    self.mGoPointDic = nil
    self.mGoSelectPointDic = nil
    self.mImgBg = nil
    self.mImgIcon = nil
    self.mTxtName = nil
    self.mImgLock = nil
    self.mImgSelect = nil
    self.mImgArrowTrans = nil
    --未解锁 “01” 解锁 “00”
    self.mUnlock = "01"
    self.mArrowTween = nil
end

function __reset(self)
    for k, v in pairs(self.mLineGos) do
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

    GameDispatcher:dispatchEvent(EventName.SET_SELECT_MAINACTIVITY_ITEM, { stageId = stageId })

    local function _openStage()
        -- GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_INFO, { stageId = stageId })
        GameDispatcher:dispatchEvent(EventName.UPDATE_MAINACTIVITY_STAGE_LIST, { stageId = stageId })
    end
    -- 已通关/未通关
    if mainActivity.ActiveDupManager:isStagePass(stageId) or mainActivity.ActiveDupManager:isStageCanFight(stageId) then
        _openStage()
    else
        local isActive, needPassStageId = stageVo:isActive()
        local needStageVo = mainActivity.ActiveDupManager:getStageVo(needPassStageId)
        -- 未解锁
        gs.Message.Show(_TT(31717, battleMap.getMainMapStyleName(needStageVo.styleType), needStageVo.indexName))
    end
end

function __removeEventList(self)
end

function __addEventList(self)
    self:addOnClick(self.m_childGos["click"], self.onClickStageItemHandler)
end

function __getPrefabName(self)
    local stageVo = self:getData()
    local stageType = stageVo.type
    -- if (stageType == mainActivity.MainMapStageType.Normal or stageType == mainActivity.MainMapStageType.StoryFight) then
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_0_1.prefab")
    -- elseif (stageType == mainActivity.MainMapStageType.Story) then
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_2.prefab")
    -- elseif (stageType == mainActivity.MainMapStageType.Elite) then
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_3.prefab")
    -- elseif (stageType == mainActivity.MainMapStageType.Boss) then
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_4.prefab")
    -- else
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_0_1.prefab")
    -- end
    return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_0_1.prefab")
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
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self:setGuideTrans("guide_mainMapStage_item_" .. self:getData().stageId, self:getClickTrans())
    local rect = self.m_uiGo:GetComponent(ty.RectTransform)
    if self.m_data then
        gs.TransQuick:Pivot(rect, self.m_data.pivot.x, self.m_data.pivot.y)

        gs.TransQuick:UIPos(rect, -9, 0)
    end
end

-- 更新信息显示
function __updateCustomView(self)
    for i = 1, 4 do
        self.m_childGos["mStar" .. i]:SetActive(false)
    end
    if mainActivity.ActiveDupManager:isStagePass(self:getData().stageId) then
        self:updateLineAssets()
        self:updateStar()
    end
    self:updateContentView()
    self:updateStyle()

    local stageVo = self:getData()
    self.mImgBg:SetImg(UrlManager:getPackPath("mainActivity/mainActivity_dup_0"..stageVo.styleType + 1 ..".png"),false)

    local stageVo = self:getData()
    local stageType = stageVo.type
    self.mImgIcon.color = gs.ColorUtil.GetColor("ffffffff")
    local typeid = 1
      if (stageType == mainActivity.MainMapStageType.Normal or stageType == mainActivity.MainMapStageType.StoryFight) then
        typeid = 1
    elseif (stageType == mainActivity.MainMapStageType.Story) then
        typeid = 2
        self.mImgIcon.color = gs.ColorUtil.GetColor("ffffffff")
    elseif (stageType == mainActivity.MainMapStageType.Elite) then
        typeid = 3
    elseif (stageType == mainActivity.MainMapStageType.Boss) then
        typeid = 3
        self.mImgIcon.color = gs.ColorUtil.GetColor("ed2e37ff")
    -- else
    --     return UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageItem_0_1.prefab")
    end
    self.mImgIcon:SetImg(UrlManager:getPackPath("mainActivity/icon_"..typeid..".png"),false)
end

function updateLineAssets(self)
    local stageVo = self:getData()
    local canPass = mainActivity.ActiveDupManager:isStagePass(stageVo.stageId)
    if canPass then
        self.mLinePrefabName = UrlManager:getUIPrefabPath("mainActivity/ActiveDupStageLine_3.prefab")
    end
    for _, m_pointDataVo in pairs(stageVo.pointLineData) do
        local lineGo = gs.GOPoolMgr:Get(self.mLinePrefabName):GetComponent(ty.RectTransform)
        lineGo.eulerAngles = gs.Vector3(0, 0, m_pointDataVo.rotation)
        lineGo.sizeDelta = gs.Vector2(m_pointDataVo.length, lineGo.rect.height)
        lineGo:SetParent(self.m_childTrans["point_" .. m_pointDataVo.pointIndex], false)
        self.mNextNodeTranses[m_pointDataVo.nextStageId] = lineGo:Find("NodeNext").transform
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

    if mainActivity.ActiveDupManager:isStagePass(stageId) then
        self.mImgLock:SetActive(false)
        self.mImgPass:SetActive(true)
    elseif mainActivity.ActiveDupManager:isStageCanFight(stageId) then
        self.mImgLock:SetActive(false)
        self.mImgPass:SetActive(false)
    else
        self.mImgLock:SetActive(true)
        self.mImgPass:SetActive(false)
    end

    self.mTxtName.text = stageVo.indexName

    local exploreStageId = mainActivity.ActiveDupManager:getCurExploreStageId()
    if (exploreStageId == stageVo.stageId) then
        self.mTxtExploreTip.text = _TT(71308)
    else
        self.mTxtExploreTip.text = ""
    end
end

function updateStar(self)
    if (self:getData().type == mainActivity.MainMapStageType.Story) then
        self.m_childGos["mStarGroup"]:SetActive(false)
        return
    end
    self.m_childGos["mStarGroup"]:SetActive(true)

    self.m_stageVo = mainActivity.ActiveDupManager:getStageVo(self:getData().stageId)

    local starList = mainActivity.ActiveDupManager:getStarListByStage(self:getData().stageId)
    if not starList then
        starList = {}
    end
    for i = 1, #self.m_stageVo.starList do
        self.m_childGos["mStar" .. i]:SetActive(true)
        if i <= #starList then
            self.m_childGos["mStar" .. i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("ffe76fff")
        else
            self.m_childGos["mStar" .. i]:GetComponent(ty.Image).color = gs.ColorUtil.GetColor("82898cff")
        end
    end
end

-- function setShowFirstEff(self, show)
--     self.mEff:SetActive(show)
-- end

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
    if (stageType == mainActivity.MainMapStageType.Normal or stageType == mainActivity.MainMapStageType.StoryFight) then
        return 188, 58
    elseif (stageType == mainActivity.MainMapStageType.Story) then
        return 72, 82
    elseif (stageType == mainActivity.MainMapStageType.Elite) then
        return 231, 142
    elseif (stageType == mainActivity.MainMapStageType.Boss) then
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
    local styleType = mainActivity.ActiveDupManager.style and mainActivity.ActiveDupManager.style or battleMap.MainMapStyleType.Easy
    local stageVo = self:getData()
    local stageType = stageVo.type

    self.isPass = mainActivity.ActiveDupManager:isStagePass(stageVo.stageId)
    self.isFight = mainActivity.ActiveDupManager:isStageCanFight(stageVo.stageId)
    self.mUnlock = "00"
    if (self.isPass) then
        self.state = 1
    elseif (self.isFight) then
        self.state = 2
    else
        self.state = 3
        self.mUnlock = "01"
    end

    -- if (stageType == mainActivity.MainMapStageType.Boss) then
    --     local source = UrlManager:getPackPath("mainMap4/mainMap_01" .. "_0" .. stageType .. "_" .. self.mUnlock .. ".png")
    --     self.mImgStage:SetImg(source, true)
    -- end

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