
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type HomelandTalentConstants
local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
--endregion

--region define

local LineAniNames = {
    HomelandTalentConstants.AnimNames.Line_Red,
    HomelandTalentConstants.AnimNames.Line_Green,
    HomelandTalentConstants.AnimNames.Line_Blue,
}

--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentDisplayDialog.prefab > name: Cell
---@class HomelandTalentDisplayCell
---@field Env                           	HomelandTalentDisplayCell               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ConnectionLine                	UnityEngine.Animation                   	@ 0    
---@field SmallPoints                   	UnityEngine.RectTransform               	@ 1    
---@field SmallNode1                    	UnityEngine.RectTransform               	@ 2    
---@field SmallNode2                    	UnityEngine.RectTransform               	@ 3    
---@field SmallNode3                    	UnityEngine.RectTransform               	@ 4    
---@field BigPoint                      	UnityEngine.RectTransform               	@ 5    
---@field BigNode                       	UnityEngine.RectTransform               	@ 6    
local HomelandTalentDisplayCell = Class('HomelandTalentDisplayCell')

function HomelandTalentDisplayCell:__init()
    self._bigPointEnv = nil
    self._smallPointEnvs = {}
    
end


function HomelandTalentDisplayCell:__delete()

end


function HomelandTalentDisplayCell:Awake()
    self._smallPointNodes = {
        self.SmallNode1,
        self.SmallNode2,
        self.SmallNode3,
    }

    self._lineName2StatusNodeConf = {}
end


-- function HomelandTalentDisplayCell:Start()
-- end


function HomelandTalentDisplayCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param talentDataList table 天赋数据列表
---@param nextTalentDataList table 下一组天赋数据列表
---@param position number 天赋树 列下标
---@param labelType number 界面标签类型
function HomelandTalentDisplayCell:FreshUI(talentDataList, nextTalentDataList, position, labelType, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    self._labelType = labelType
    self._position = position
    self._talentDataList = talentDataList
    
    local talentData = talentDataList[1]
    ---@type HomelandTalentVo
    local vo         = talentData.vo
    local isBig      = vo.iconType == 1
    
    CfUtils.SetActive(self.SmallPoints, not isBig)
    CfUtils.SetActive(self.BigPoint, isBig)
    if isBig then
        self:FreshBigPoint(talentData, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    else
        self:FreshSmallPoints(talentDataList, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    end

    self:FreshLineColor(labelType)

    local mapLineName = vo.map_line
    self:FreshConnectLine(mapLineName, talentDataList, nextTalentDataList)
    
    self._lastMapLineName = mapLineName
    
end

function HomelandTalentDisplayCell:FreshSelectState(isSelect, dataIndex)
    local talentData = self._talentDataList[dataIndex]
    if talentData == nil then
        return
    end
    ---@type HomelandTalentVo
    local vo         = talentData.vo
    local isBig      = vo.iconType == 1
    self:FreshPointNodeSelectState(isSelect, dataIndex, isBig)
end

function HomelandTalentDisplayCell:FreshBigPoint(talentData, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    ---@type HomelandTalentPositionNode
    local env = self:GetBigPointEnv()
    if isNull(env) then
        return
    end
    local isSelected = selectDataIndex == 1 and isSelectTalent
    env:FreshUI(talentData, true, self._labelType, self._position, 1)
    env:FreshSelectState(isSelected)
    env:SetCallback(self._callback)

    if isPlayUpgradeEff and isSelected then
        env:PlayUpgradeEffect()
    end

end

function HomelandTalentDisplayCell:FreshSmallPoints(talentDataList, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    -- print("FreshPoints", table.toString(talentDataList))
    for index, value in ipairs(self._smallPointNodes) do
        local data = talentDataList[index]
        local iShow = data ~= nil
        CfUtils.SetActive(value, iShow)
        if iShow then
            self:FreshSmallPoint(index, data, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
        end
    end

end

function HomelandTalentDisplayCell:FreshSmallPoint(index, data, selectDataIndex, isSelectTalent, isPlayUpgradeEff)
    ---@type HomelandTalentPositionNode
    local env = self:GetSmallPointEnv(index)
    if isNull(env) then
        return
    end
    local isSelected = selectDataIndex == index and isSelectTalent
    env:FreshUI(data, false, self._labelType, self._position, index)
    env:FreshSelectState(isSelected)
    env:SetCallback(self._callback)
    if isSelected and isPlayUpgradeEff then
        env:PlayUpgradeEffect()
    end
end

---FreshPointNodeSelectState
---@param env HomelandTalentPositionNode
---@param dataIndex number
---@param isBig boolean
function HomelandTalentDisplayCell:FreshPointNodeSelectState(isSelect, dataIndex, isBig)
    ---@type HomelandTalentPositionNode
    local env = isBig and self:GetBigPointEnv() or self:GetSmallPointEnv(dataIndex)
    if isNull(env) then
        return
    end
    env:FreshSelectState(isSelect)
end

function HomelandTalentDisplayCell:FreshLineColor(labelType)
    local aniName = LineAniNames[labelType]
    self.ConnectionLine:Play(aniName)

end

function HomelandTalentDisplayCell:FreshConnectLine(lineName, talentDataList, nextTalentDataList)
    if string.isEmpty(lineName) then
        local conf = self._lineName2StatusNodeConf[self._lastMapLineName]
        if conf then
            local line = conf.line
            CfUtils.SetActive(line, false)
            for key, node in pairs(conf.statusConf) do
                CfUtils.SetActive(node, false)
            end
        end

        return
    end
    local line = self[lineName]

    if isNull(line) then
        line = self.ConnectionLine.transform:Find(lineName)
        if isNull(line) then return end
        self[lineName] = line
        self._lineName2StatusNodeConf[lineName] = {
            line = line,
            statusConf = {},
        }
    end

    --- 先隐藏所有节点
    local conf = self._lineName2StatusNodeConf[self._lastMapLineName]
    if conf then
        local line = conf.line
        CfUtils.SetActive(line, false)
        for key, node in pairs(conf.statusConf) do
            CfUtils.SetActive(node, false)
        end
    end
    local curConf = self._lineName2StatusNodeConf[lineName]
    if curConf then
        CfUtils.SetActive(curConf.line, true)
    end

    if nextTalentDataList == nil or next(nextTalentDataList) == nil then
        return
    end

    local currentTalent2Lv = {}
    local currentTalent2Status = {}
    for index, value in ipairs(talentDataList) do
        currentTalent2Lv[value.vo.talentId] = value.talentLv
        currentTalent2Status[value.vo.talentId] = value.status
    end

    --- 在显示目标节点
    local nextNodeCount = #nextTalentDataList
    if nextNodeCount == 1 then
        --  3 - 1
        --  2 - 1
        local nextTalentData = nextTalentDataList[nextNodeCount]
        ---@type HomelandTalentVo
        local vo        = nextTalentData.vo
        local preTalent = vo:GetPreTalent()
        local nameConf        = HomelandTalentConstants.LineEffectNameConf[#preTalent]
        for index, value in ipairs(preTalent) do
            local isActive = self:CheckPreTalentActiveStatus(currentTalent2Lv, currentTalent2Status, value)
            self:FreshLineShowState(line, lineName, isActive, nameConf, index)

        end
        
    elseif nextNodeCount >= 2 then
        --  2 - 2
        --  1 - 2
        --  1 - 3
        local nameConf        = HomelandTalentConstants.LineEffectNameConf[#nextTalentDataList]
        
        for index, nextTalentData in ipairs(nextTalentDataList) do
            ---@type HomelandTalentVo
            local vo        = nextTalentData.vo
            local preTalent = vo:GetPreTalent()
            local isActive  = true
            -- print("preTalent", self._position, table.toString(preTalent))
            for preIndex, value in ipairs(preTalent) do
                isActive = isActive and self:CheckPreTalentActiveStatus(currentTalent2Lv, currentTalent2Status, value)
                
            end
            
            self:FreshLineShowState(line, lineName, isActive, nameConf, index)
           
        end

    end

end

function HomelandTalentDisplayCell:CheckPreTalentActiveStatus(currentTalent2Lv, currentTalent2Status, value)
    local talentId    = value[1]
    local talentLevel = value[2]
    return checkNumber(currentTalent2Lv[talentId]) >= talentLevel and (talentLevel > 0 or currentTalent2Status[talentId] == HomelandTalentConstants.TalentNodeStatus.ActiveUnmet)
end

function HomelandTalentDisplayCell:FreshLineShowState(line, lineName, isActive, nameConf, index)
    local statusConf = self._lineName2StatusNodeConf[lineName].statusConf

    local conf = nameConf[index]
    if next(statusConf) == nil then
        local count  = line.childCount
        for i = 1, count do
            local child = line:GetChild(i - 1)
            local name = child.name
            statusConf[name] = child
            CfUtils.SetActive(child, false)
        end
    
    end

    local child = isActive and statusConf[conf.UnLock] or statusConf[conf.Lock]
    CfUtils.SetActive(child, true)
   
end

--endregion 


--region get/set 

function HomelandTalentDisplayCell:SetCallback(callback)
    self._callback = callback
end

---GetBigPointEnv
---@return HomelandTalentPositionNode
function HomelandTalentDisplayCell:GetBigPointEnv()
    if isNull(self._bigPointEnv) then
        self._bigPointEnv = CfUtils.GetLuaScr(self.BigNode, HomelandTalentConstants.EnvPath.HomelandTalentPositionNode)
    end
    return self._bigPointEnv
end

---GetSmallPointEnv
---@param index number
---@return HomelandTalentPositionNode
function HomelandTalentDisplayCell:GetSmallPointEnv(index)
    local smallNodeEnv = self._smallPointEnvs[index]
    if isNull(smallNodeEnv) then
        smallNodeEnv = CfUtils.GetLuaScr(self._smallPointNodes[index], HomelandTalentConstants.EnvPath.HomelandTalentPositionNode)
        self._smallPointEnvs[index] = smallNodeEnv
    end
    return smallNodeEnv
end

---endregion 


--region handler 


---endregion 


return HomelandTalentDisplayCell
