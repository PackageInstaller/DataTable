--[[ 
    英雄传记关卡item
]]
module("battleMap.HeroBiographyDupItem", Class.impl(BaseComponent))

-- 是否异步
IsAsyn = false

function __initData(self)
    super.__initData(self)

    self.m_linePrefabName = ""

    self.m_parent = nil
    self.m_nextNodeTrans = nil
    self.m_lineGo = nil

    self.m_imgBg = nil
    self.mTxtName = nil
    self.m_goLock = nil
    self.m_goSelect = nil
    self.m_transArrow = nil

    self.m_arrowTween = nil
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

function __removeEventList(self)
end

function __addEventList(self)
end

function __getPrefabName(self)
    local stageId = self:getData().stageId
    local stageVo = battleMap.BiographyManager:getDupConfigVo(stageId)
    if (stageVo:getType() == battleMap.DupContentType.NORMAL) then
        return UrlManager:getUIPrefabPath("battleMapHall/biography/item/BiographyStageItem.prefab")
    else
        return UrlManager:getUIPrefabPath("battleMapHall/biography/item/BiographyStoryItem.prefab")
    end
end

function __initGo(self)
    self.m_imgBg = self.m_childGos["ImgIcon"]:GetComponent(ty.AutoRefImage)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_goLock = self.m_childGos["ImgLock"]
    self.m_goSelect = self.m_childGos["ImgSelect"]
    self.m_transArrow = self.m_childTrans["ImgArrow"]
    self.m_goPass = self.m_childGos["ImgPass"]
end

-- 更新信息显示
function __updateCustomView(self)
    self:__updateLineAssets()
    self:__updateContentView()
end

function __updateLineAssets(self)
    local heroTid = self:getData().heroTid
    local biographyId = self:getData().biographyId
    local stageId = self:getData().stageId
    local biographyVo = battleMap.BiographyManager:getBiographyVo(heroTid, biographyId)
    local stageVo = battleMap.BiographyManager:getDupConfigVo(stageId)

    if (#stageVo:getPointLine() >= 2) then
        local pointIndex = stageVo:getPointLine()[1]
        local lineType = stageVo:getPointLine()[2]
        self.m_linePrefabName = UrlManager:getUIPrefabPath("battleMapHall/biography/item/BiographyStageLine_" .. lineType .. ".prefab")
        self.m_lineGo = gs.GOPoolMgr:Get(self.m_linePrefabName).gameObject
        self.m_lineGo.transform:SetParent(self.m_childTrans["point_" .. pointIndex], false)
        self.m_nextNodeTrans = self.m_lineGo.transform:Find("NodeNext").transform

        local img = self.m_lineGo:GetComponent(ty.AutoRefImage)
        -- 已开启
        if(biographyVo)then
            if(table.indexof(biographyVo.historyDupList, stageId))then      -- 已通关
                img:SetGray(false)
            elseif(biographyVo.curDupId == stageId)then -- 当前关
                img:SetGray(true)
            end
        else
            img:SetGray(true)
        end
    end
end

function __updateContentView(self)
    local heroTid = self:getData().heroTid
    local biographyId = self:getData().biographyId
    local stageId = self:getData().stageId
    local biographyVo = battleMap.BiographyManager:getBiographyVo(heroTid, biographyId)
    local stageVo = battleMap.BiographyManager:getDupConfigVo(stageId)

    local pointIndex = nil
    if (#stageVo:getPointLine() >= 2) then
        pointIndex = stageVo:getPointLine()[1]
    end 

    self.mTxtName.text = HtmlUtil:color(stageVo:getName(), ColorUtil.BLACK_NUM)
    self.m_transArrow.gameObject:SetActive(biographyVo.curDupId == stageId)
    self.m_goSelect:SetActive(biographyVo.curDupId == stageId)
    self.m_goPass:SetActive(table.indexof(biographyVo.passDupList, stageId))
    -- 已开启
    if(biographyVo)then
        if(biographyVo.curDupId == stageId)then     -- 当前关
            self.m_goLock:SetActive(false)
            self:__tweenArrow()
        elseif(table.indexof(biographyVo.historyDupList, stageId))then          -- 已通关
            self.m_goLock:SetActive(false)
        else
            self.m_goLock:SetActive(true)
        end
    else
        self.m_goLock:SetActive(true)
    end

    if (stageVo:getType() == battleMap.DupContentType.NORMAL) then
        self.m_imgBg:SetImg(UrlManager:getPackPath("biography/img_checkp_01.png"), false)
    else
        self.m_imgBg:SetImg(UrlManager:getPackPath(string.format("biography/img_checkp_0%s.png", stageId)), false)
    end
end

function setSelectState(self, isSelect)
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
    local stageId = self:getData().stageId
    local stageVo = battleMap.BiographyManager:getDupConfigVo(stageId)

    if (stageVo:getType() == battleMap.DupContentType.NORMAL) then
        return 185, 44
    else
        return 66, 76
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
    local stageId = self:getData().stageId
    local stageVo = battleMap.BiographyManager:getDupConfigVo(stageId)

    if (stageVo:getType() == battleMap.DupContentType.NORMAL) then
        return 50
    else
        return 50
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
