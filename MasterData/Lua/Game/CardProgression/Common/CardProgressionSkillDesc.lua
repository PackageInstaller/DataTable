
------------ import ------------
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr      = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils     = import("Game.CardProgression.CardProgressionSkillUtils")
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/Common/CommonCardSkillDesc.prefab > name: CommonCardSkillDesc
---@class CardProgressionSkillDesc
---@field Env                           	CardProgressionSkillDesc                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field DescNode                      	UnityEngine.RectTransform               
---@field StarUpUnlock                  	UnityEngine.RectTransform               
---@field Arrow                         	UnityEngine.RectTransform               
---@field Bg                            	UnityEngine.RectTransform               
---@field SkillDescText                 	UnityEngine.UI.Text                     
---@field SkillDescribeNode             	UnityEngine.RectTransform               
---@field ImgIcon                       	Engine.UI.ImageAlterable                
---@field SkillWorkPlaceNode            	UnityEngine.RectTransform               
---@field KeywordCell                   	UnityEngine.RectTransform               
---@field KeywordNode                   	UnityEngine.RectTransform               
---@field TextNumberLevel               	TMPro.TextMeshProUGUI                   
---@field Level                         	UnityEngine.RectTransform               
---@field TextName                      	UnityEngine.UI.Text                     
---@field SkillNode3                    	UnityEngine.RectTransform               
---@field SkillNode2                    	UnityEngine.RectTransform               
---@field SkillNode1                    	UnityEngine.RectTransform               
---@field OtherTipsNode                 	UnityEngine.RectTransform               
---@field OtherTipsNodeGroup            	UnityEngine.RectTransform               
---@field OtherTipsContainer            	UnityEngine.RectTransform               
---@field BuffTipsNode                  	UnityEngine.RectTransform               
---@field BuffTipsNodeGroup             	UnityEngine.RectTransform               
---@field BuffTipsContainer             	UnityEngine.RectTransform               
local CardProgressionSkillDesc = Class('CardProgressionSkillDesc', CommonTipsBoard)

function CardProgressionSkillDesc:__init()
    CommonTipsBoard.__init(self)
    self._effectLabels = {}
    self._buffTipNodes = {}
    self._keywordCells = {}
    self._otherTipsNodes = {}
    self._starUnlockDescNodes = {}
    self._selectSkillIndex = 1
end


function CardProgressionSkillDesc:__delete()
    CommonTipsBoard.__delete(self)

end


function CardProgressionSkillDesc:Awake()
    --- 默认隐藏LV 11.22版本内容 去掉大招和被动lv显示
    KTool.SetActive(self.Level.gameObject, false)

    CommonTipsBoard.Awake(self)
    self._skillNodes = {
        self.SkillNode1,
        self.SkillNode2,
        self.SkillNode3,
    }

    KTool.SetActive(self.ImgIcon.gameObject, false)
    KTool.SetActive(self.OtherTipsNode.gameObject, false)
    KTool.SetActive(self.KeywordCell.gameObject, false)
end


function CardProgressionSkillDesc:Start()
    CommonTipsBoard.Start(self)
end


function CardProgressionSkillDesc:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------


---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

--- FreshUI
---@param params table{
---@    skillData:table {skillId：integer, skillLevel: integer, skillGroupType: integer}, 
---@    cardVo: CardVo
---@    isSpecify: boolean
---@}
function CardProgressionSkillDesc:FreshUI(params)
    local skillData, cardVo, isSpecify = params.skillData, params.cardVo, checkBool(params.isSpecify)
    ---@type CardVo
    self._cardVo    = cardVo
    self._isSpecify = isSpecify

    local skillId, skillLevel, skillGroupType = SafeUnpack(skillData)
    self:InitSkillLevel2Star(skillGroupType)

    ---@type SkillCardVo | TalentVo
    local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillId, skillGroupType, cardVo.cardId)

    local skillDataList = self:GetSkillDataList(skillData, skillGroupType, vo, cardVo, skillLevel)
    self._skillDataList = skillDataList
    local realSkillData = skillDataList[self._selectSkillIndex]

    self:FreshSkills(skillDataList, skillGroupType)
    self:FreshPanel(realSkillData, cardVo.roleId)

end

function CardProgressionSkillDesc:InitSkillLevel2Star(skillGroupType)
    if skillGroupType == CardProgressionConstants.SkillGroupType.Normal then
        return
    end
    local isFinal = skillGroupType == CardProgressionConstants.SkillGroupType.Final
    local idList = cardConfMgr:GetCardStarIdList(self._cardVo.roleId)
    local lv2Star = {}
    for index, value in ipairs(idList) do
        ---@type CardStarVo
        local vo = cardConfMgr:GetCardStarVo(value)
        if isFinal then
            if vo.spLevel > 0 then
                lv2Star[cardConfMgr:GetFinalSkillDisplayLevel(vo.spLevel)] = vo.star
            end
        else
            if vo.passiveLevel > 0 then
                lv2Star[vo.passiveLevel] = vo.star
            end
        end
    end
    self._lv2Star = lv2Star
end

--- FreshSkills
--- 刷新技能节点
---@param skillDataList any
function CardProgressionSkillDesc:FreshSkills(skillDataList, skillGroupType)
    for i, node in ipairs(self._skillNodes) do
        local data = skillDataList[i]
        local isShow = data ~= nil and (skillGroupType == CardProgressionConstants.SkillGroupType.Normal or (i == 1 and skillGroupType ~= CardProgressionConstants.SkillGroupType.Normal))
        KTool.SetActive(node.gameObject, isShow)
        if isShow then
            self:FreshSkillNode(node, data, i)
        end
    end
end

--- FreshPanel
---@param realSkillData table 
---@param cardId number
function CardProgressionSkillDesc:FreshPanel(realSkillData, cardId)
    local skillId, skillLevel, skillGroupType = SafeUnpack(realSkillData)
    ---@type SkillCardVo | TalentVo
    local vo = CardProgressionSkillUtils.GetSkillVoBySkillGroupType(skillId, skillGroupType, cardId)
    if skillGroupType == CardProgressionConstants.SkillGroupType.Buff then
        self:FreshEffectLabels(vo, skillLevel, cardId)
    else
        KTool.SetActive(self.BuffTipsContainer.gameObject, false)
        self:FreshKeyWords(vo, skillLevel)
    end

    self:FreshSkillInfo(vo, skillLevel, skillGroupType, cardId)
end

--- FreshEffectLabels
---@param vo TalentVo
function CardProgressionSkillDesc:FreshEffectLabels(vo, awakeLevel, cardId)
    local effShowList = self:GetEffShowList(vo.effShowList, awakeLevel, cardId)
    local isShowLimit = #effShowList > 0
    local effectLabelParent      = self.SkillWorkPlaceNode
    KTool.SetActive(effectLabelParent.gameObject, isShowLimit)
    KTool.SetActive(self.BuffTipsContainer.gameObject, isShowLimit)
    if isShowLimit then
        self:FreshOrCreateNode(effectLabelParent, self.ImgIcon, effShowList, self._effectLabels, function(cell, data, isInit) 
            local photoPath = cardConfMgr:GetBuffEffectOccasionVo(data).icon
            CfUtils.FillImage(cell, photoPath)
        end)

        self:FreshOrCreateNode(self.BuffTipsNodeGroup, self.BuffTipsNode, effShowList, self._buffTipNodes, function(cell, data, isInit) 
            ---@type CardProgressionSkillDescBuffTipNode
            local env = CfUtils.GetLuaScr(cell, CardProgressionConstants.EnvPath.CardProgressionSkillDescBuffTipNode)
            if isNull(env) then return end
            ---@type BuffEffectOccasionVo
            local vo = cardConfMgr:GetBuffEffectOccasionVo(data)
            local photoPath = vo.icon
            local desc = vo.desc
            env:FreshUI(photoPath, desc)
        end)
    end
end

--- FreshKeyWords
---@param vo SkillCardVo
function CardProgressionSkillDesc:FreshKeyWords(vo, skillLevel)
    -- print("CardProgressionSkillDesc", table.toString(vo))
    -- abstractLabel字段，可以支持分星级配置，同星级之间的不同标签ID通过"，"分割，
    -- 不同星级技能之间的标签ID通过"；"分割。若果当前星级标签未找到数据，就向上查找上一星级的配置数据。都未查到数据则不显示
    local abstractLabel = checkTable(vo.abstractLabel)
    local keywords = CardProgressionSkillUtils.GetSkillTags(abstractLabel, skillLevel)
    local count    = #keywords
    local parent   = self.KeywordNode
    KTool.SetActive(parent.gameObject, count > 0)
    if count > 0 then
        self:FreshOrCreateNode(parent, self.KeywordCell, keywords, self._keywordCells, function(cell, data)
            ---@type CardProgressionSkillDescKeywordCell
            local env = CfUtils.GetLuaScr(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionSkillDescKeywordCell)
            if not isNull(env) then
                local name = CfUtils.GetCfData(AutoIds.IdSetting284, data, "desc", Constants.DataType.LocalString)
                env:FreshUI(name)
            end
        end)
    end
end

function CardProgressionSkillDesc:FreshSkillNode(node, data, index)
    ---@type CardProgressionSkillDescSkillNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionSkillDescSkillNode)
    if not isNull(env) then
        env:FreshUI(data, self._cardVo, true)
        env:FreshSelectState(self._selectSkillIndex == index)
        env:SetCallback(function ()
            if self._selectSkillIndex == index then
                return
            end
            env:FreshSelectState(true)
            self:FreshSkillNodeSelectState(self._selectSkillIndex, false)
            self._selectSkillIndex = index

            local realSkillData = self._skillDataList[index]
            self:FreshPanel(realSkillData, self._cardVo.roleId)
        end)
    end
end

function CardProgressionSkillDesc:FreshSkillNodeSelectState(index, isSelect)
    ---@type CardProgressionSkillDescSkillNode
    local env = CfUtils.GetLuaScr(self._skillNodes[index], CardProgressionConstants.EnvPath.CardProgressionSkillDescSkillNode)
    if not isNull(env) then
        env:FreshSelectState(isSelect)
    end
end

--- FreshSkillInfo
---@param vo SkillCardVo | TalentVo 技能逻辑表数据
function CardProgressionSkillDesc:FreshSkillInfo(vo, skillLevel, skillGroupType, cardId)
    self.TextName.text = vo.skillName or vo.name

    local desc, skillOtherDescInfo, starUnlockDescInfo = self:GetDesc(vo, skillLevel, skillGroupType, cardId)
    self.SkillDescText.text = desc

    self:FreshStarUnlockDescInfo(starUnlockDescInfo)

    self:FreshOtherTips(skillOtherDescInfo)

    -- --- 默认隐藏LV 11.22版本内容 去掉大招和被动lv显示
    -- local isShowLv = skillGroupType ~= CardProgressionConstants.SkillGroupType.Normal
    -- KTool.SetActive(self.Level.gameObject, isShowLv)
    -- if isShowLv then
    --     self.TextNumberLevel.text = skillLevel
    -- end

end

function CardProgressionSkillDesc:FreshStarUnlockDescInfo(starUnlockDescInfo)
    local isShow = starUnlockDescInfo ~= nil
    KTool.SetActive(self.StarUpUnlock.gameObject, isShow)
    if not isShow then return end

    self:FreshOrCreateNode(self.StarUpUnlock, self.DescNode, starUnlockDescInfo, self._starUnlockDescNodes, function(cell, data, isInit, index)
        ---@type CardProgressionSkillDescStarDescNode
        local env = CfUtils.GetLuaScr(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionSkillDescStarDescNode)
        if not isNull(env) then
            env:FreshUI(data)
        end
    end)
    

end

function CardProgressionSkillDesc:FreshOtherTips(skillOtherDescInfo)
    local isShowOtherDesc = skillOtherDescInfo ~= nil and next(skillOtherDescInfo) ~= nil
    KTool.SetActive(self.OtherTipsContainer.gameObject, isShowOtherDesc)
    if not isShowOtherDesc then
        return
    end

    self:FreshOrCreateNode(self.OtherTipsNodeGroup, self.OtherTipsNode, skillOtherDescInfo, self._otherTipsNodes, function(cell, data)
        ---@type CardProgressionSkillDescOtherTipNode
        local env = CfUtils.GetLuaScr(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionSkillDescOtherTipNode)
        if not isNull(env) then
            env:FreshUI(data)
        end
    end)

end

---FreshOrCreateNode
function CardProgressionSkillDesc:FreshOrCreateNode(parent, child, dataList, childList, refreshCb)
    local cellCount     = #childList
    local funcCount     = #dataList
    local forTimes      = math.max(cellCount, funcCount)
    for i = 1, forTimes do
        self:FreshOrCreateNodeByIndex(i, i, parent, child, dataList, childList, refreshCb)
    end

end

function CardProgressionSkillDesc:FreshOrCreateNodeByIndex(i, dataStartIndex, parent, child, dataList, childList, refreshCb)
    local data = dataList[dataStartIndex]
    local cell = childList[i]
    if data then
        local isInitCell = cell == nil
        if isInitCell then
            cell = parent.gameObject:AddChild(child.gameObject)
            childList[i] = cell
        end
        
        KTool.SetActive(cell.gameObject, true)
        if refreshCb then
            refreshCb(cell, data, isInitCell, i)
        end

    elseif cell then
        KTool.SetActive(childList[i].gameObject, false)
    end
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

--- GetSkillDataList
---@param skillData table
---@param skillGroupType CardProgressionConstants.SkillGroupType
---@param vo SkillCardVo
---@param cardVo CardVo
function CardProgressionSkillDesc:GetSkillDataList(skillData, skillGroupType, vo, cardVo, skillLevel)
    if skillGroupType == CardProgressionConstants.SkillGroupType.Buff then
        return {skillData}
    elseif skillGroupType == CardProgressionConstants.SkillGroupType.Final then
        return {skillData}
    elseif skillGroupType == CardProgressionConstants.SkillGroupType.Normal then
        local t = {}
        local skillLvMax = #vo.orginSkills
        for i = 1, skillLvMax, 1 do
            local skillDataClone = clone(skillData)
            skillDataClone[2] = i
            table.insert(t, skillDataClone)
        end
        return t
    end
end

function CardProgressionSkillDesc:InitSkillDataList(initLv, maxLv, curLv, skillData)
    local t = {}
    local index = 1
    local selectIndex = 1
    for i = initLv, maxLv do
        local skillDataClone = clone(skillData)
        skillDataClone[2] = i
        table.insert(t, skillDataClone)
        if i == curLv then
            selectIndex = index
        end
        index = index + 1
    end
    return t, selectIndex
end

function CardProgressionSkillDesc:GetDesc(vo, skillLevel, skillGroupType, cardId)
    --- buff 和 Final 分为 基础描述（使用1星描述） 和 星级描述 
    local desc, skillOtherDescInfo, starUnlockDescInfo
    if skillGroupType == CardProgressionConstants.SkillGroupType.Buff then
        -- desc, descOther  = CardProgressionSkillUtils.GetEffectiveTalentDescInfo(cardId, skillLevel)
        local maxLv = cardConfMgr:GetMaxBuffSkillLv(self._cardVo.roleId)
        local skillDescInfo, descOther = CardProgressionSkillUtils.GetAllTalentDescInfo(cardId, maxLv, skillLevel)
        desc = skillDescInfo[1]
        starUnlockDescInfo = self:GetStarUnlockDescInfo(skillDescInfo, skillLevel)

        skillOtherDescInfo = CardProgressionSkillUtils.ParseOtherDesc(descOther)
        
    elseif skillGroupType == CardProgressionConstants.SkillGroupType.Final then
        local maxLv = cardConfMgr:GetMaxFinalSkillLv(self._cardVo.rare)
        local skillDescInfo = CardProgressionSkillUtils.ParseSkillDesc(vo, maxLv, true, skillLevel, self._isSpecify, self._cardVo.rare, true)
        desc = skillDescInfo[1]
        starUnlockDescInfo = self:GetStarUnlockDescInfo(skillDescInfo, skillLevel)

        skillOtherDescInfo = CardProgressionSkillUtils.ParseSkillOtherDesc(vo, skillGroupType)[1]
    elseif skillGroupType == CardProgressionConstants.SkillGroupType.Normal then
        local skillDescInfo = CardProgressionSkillUtils.ParseSkillDesc(vo, skillLevel, false, nil, self._isSpecify, nil, true)
        desc = skillDescInfo[skillLevel]

        local otherDescStarList = CardProgressionSkillUtils.ParseSkillOtherDesc(vo, skillGroupType)
        local star = self._selectSkillIndex
        skillOtherDescInfo = otherDescStarList[star]
        --- 指定的找不到向上查
        if skillOtherDescInfo == nil then
            for i = star, 1, -1 do
                skillOtherDescInfo = otherDescStarList[i]
                if skillOtherDescInfo then
                    break
                end
            end
        end

    end
    return desc, skillOtherDescInfo, starUnlockDescInfo
end

function CardProgressionSkillDesc:GetStarUnlockDescInfo(skillDescInfo, skillLevel)
    local starUnlockDescInfo = {}
    local displayLevel = skillLevel
    for lv, desc in ipairs(skillDescInfo) do
        if lv > 1 then
            local status = displayLevel >= lv and 2 or 1
            table.insert(starUnlockDescInfo, {desc = desc, lv = self._lv2Star[lv], status = status})
        end
    end
    return starUnlockDescInfo
end

function CardProgressionSkillDesc:GetEffShowList(effShowList, awakeLevel, cardId)
    while #effShowList == 0 and awakeLevel > 1 do
        awakeLevel = awakeLevel - 1
        ---@type TalentVo
        local talentVo = CardProgressionSkillUtils.GetTalentVo(cardId, awakeLevel)
        effShowList = talentVo.effShowList
        
    end
    return effShowList
end


function CardProgressionSkillDesc:SetSmallTipsDirection()
    
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionSkillDesc
