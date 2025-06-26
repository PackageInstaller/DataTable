--[[ 
-----------------------------------------------------
@filename       : DupClimbTowerDeepDupItem
@Description    : 爬塔副本item
@date           : 2021-01-28 15:46:35
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("dup.DupClimbTowerDeepDupItem", Class.impl(BaseComponent))

function __getPrefabName(self)
    return UrlManager:getUIPrefabPath("domainSurvey/DomainSurveyDeepStageItem.prefab")
end

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

function getDupVo(self)
    return self:getData().data
end

function getAreaVo(self)
    return self:getData().msgInfo
end

function __initGo(self)
    self.m_goPointDic = {}
    self.m_goSelectPointDic = {}
    for pointIndex = 1, 4 do
        self.m_goPointDic[pointIndex] = self.m_childGos["ImgPoint_" .. pointIndex]
        self.m_goSelectPointDic[pointIndex] = self.m_childGos["ImgSelectPoint_" .. pointIndex]
    end
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_normalTxtName = self.m_childGos["NormalTextName"]:GetComponent(ty.Text)
    self.m_textShadow = self.m_childGos["TextName"]:GetComponent(ty.Shadow)
    self.m_goLock = self.m_childGos["ImgLock"]
    self.m_goSelect = self.m_childGos["ImgSelect"]
    self.m_transArrow = self.m_childTrans["ImgArrow"]
    self.m_goPass = self.m_childGos["ImgPass"]
    self.m_goBigPass = self.m_childGos["ImgBigPass"]
    self.m_figthImg = self.m_childGos["FightImg"]
    self.mDomainSurveyStageIcon = self:getChildGO("DomainSurveyStageIcon")
    self.mTxtSelectName = self.m_childGos["mTxtSelectName"]:GetComponent(ty.Text)
end

-- 更新信息显示
function __updateCustomView(self)
    self:__updateLineAssets()
    self:__updateContentView()
end

function getCanPass(self)
    return self:getDupVo().dupId <= self:getAreaVo().maxDup
end

function __updateLineAssets(self)
    local dupVo = self:getDupVo()
    if (dupVo.pointLine and dupVo.pointLine ~= 0) then
        local lineType = dupVo.dupId % 2
        if lineType == 0 then
            lineType = 2 
        end
        self.m_linePrefabName = UrlManager:getUIPrefabPath("domainSurvey/DupTowerDeepLine" .. lineType .. ".prefab")
        if not self.m_linePrefabName then 
            return
        end 
        self.m_lineGo = gs.GOPoolMgr:Get(self.m_linePrefabName).gameObject
        self.m_lineGo.transform:SetParent(self.m_childTrans["point_1" ], false)
        self.m_nextNodeTrans = self.m_lineGo.transform:Find("NodeNext").transform
    end
end

function __updateContentView(self)
    local dupVo = self:getDupVo()
    local areaVo = self:getAreaVo()
    if self:getDupVo().dupId == 2001 then
        self:setGuideTrans("guide_DomainSurveyStageItem_"..self:getDupVo().dupId,self.m_uiGo.transform)
    end
   
    self.mTxtName.text = dupVo:getName()
    self.mTxtSelectName.text = dupVo:getName()
    if self:getCanPass() then
        self.m_goLock:SetActive(false)
        self.mDomainSurveyStageIcon:SetActive(true)
        self.m_goPass:SetActive(true)
        self.m_goBigPass:SetActive(true)
        self.m_transArrow.gameObject:SetActive(false)
    elseif areaVo.curDup ~= 0 then
        if dupVo.dupId == areaVo.curDup then
            self.m_goLock:SetActive(false)
            self.mDomainSurveyStageIcon:SetActive(true)
            self.m_goPass:SetActive(false)
            self.m_goBigPass:SetActive(false)
            self.m_transArrow.gameObject:SetActive(true)
            self:__tweenArrow()
        else
            self.m_goLock:SetActive(true)
            self.mDomainSurveyStageIcon:SetActive(false)
            self.m_goPass:SetActive(false)
            self.m_goBigPass:SetActive(false)
            self.m_transArrow.gameObject:SetActive(false)
        end 
    end
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
    return 178, 40
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
    return 40
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
