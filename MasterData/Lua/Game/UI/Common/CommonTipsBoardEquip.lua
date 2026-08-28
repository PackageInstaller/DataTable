---
--[[
通用提示板 显示道具的信息 带一个数量
unity prefab中的相关属性
--]]

------------ import ------------
local ContentSizeFitter = CS.UnityEngine.UI.ContentSizeFitter

local KTool = CS.Engine.Lib.KTool
------------ import ------------

------------ define ------------
local _ContentSizeFitter = typeof(ContentSizeFitter)
local TitleNodePath = "Game.UI.Common.CommonTitleNode"
local GoodsConfMgr = GoodsConfMgr
------------ define ------------

--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')

---@class CommonTipsBoardEquip
---@field AttrNumText                    UnityEngine.UI.Text @主属性数值的显示
---@field AttrNameText                    UnityEngine.UI.Text @主属性名称
---@field OpenAwayNodePrefab                UnityEngine.RectTransform
---@field NoWayNode                        UnityEngine.RectTransform @是否存在跳转方式
---@field Arrow                            UnityEngine.RectTransform
---@field ContentTxt                        UnityEngine.UI.Text @描述内容
---@field TitleNode                       UnityEngine.RectTransform @装备名称
---@field Bg                                UnityEngine.RectTransform @背景用来计算屏幕位置的
local CommonTipsBoardEquip = Class('CommonTipsBoardEquip', CommonTipsBoard)

function CommonTipsBoardEquip:__init()
    
    CommonTipsBoard.__init(self)
end

function CommonTipsBoardEquip:__delete()
    
    CommonTipsBoard.__delete(self)
end

function CommonTipsBoardEquip:Awake()
    CommonTipsBoard.Awake(self)
    self:Init()
end

function CommonTipsBoardEquip:Start()
    CommonTipsBoard.Start(self)
end

function CommonTipsBoardEquip:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil    --luabehaviour 中CSharp对象 self:Delete()
    self = nil
end

---------------------------------------------------
-- init begin --
---------------------------------------------------

---InitValue 初始化数值
function CommonTipsBoardEquip:InitValue()
    CommonTipsBoard.InitValue(self)
end

---InitView 初始化界面
function CommonTipsBoardEquip:InitView()
    CommonTipsBoard.InitView(self)
    -- 初始化界面
    self.TitleTxt.text = ''
    self.ContentTxt.text = ''
    --self.NumTxt.text = ''
end

---------------------------------------------------
-- init end --
---------------------------------------------------

---RefreshBoardByEquipId 根据装备id刷新面板
---@param equipId number 装备id
---@param playerEquipId number 是否是自己的
function CommonTipsBoardEquip:RefreshBoardByEquipId(equipId, playerEquipId)
    ---@type GoodsVo
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(equipId)
    if isNull(goodsVo) then
        -- 未找到道具配置
        self:RefreshBoardByContent(
                checkString(equipId),
                string.format('%s%s', localize('未找到道具配置'), 0)
        )

    else
        ---添加获取途径的逻辑
        if isSet(goodsVo, "jumpAway") and table.length(goodsVo.jumpAway) > 0 then
            ---存在获取途径
        else
            ---不存在时
            KTool.SetActive(self.NoWayNode.gameObject, true)
        end
    end
    local cardConfMgr = CardConfMgr:GetInstance()
    ---@type EquipVo
    local equipVo = cardConfMgr:GetEquipVoById(equipId)
    if not isNull(equipVo) then
        ---刷新显示主属性的信息
        if isNull(playerEquipId) then
			---这个装备部件不是自己的
			---@type EquipAttrVo
			local mainEquipAttrVo = cardConfMgr:GetEquipAttrVoById(equipVo.poolMain)
			local attrVo = cardConfMgr:GetBasicAttrAdditionById(mainEquipAttrVo.attrAdditionId)
			local attrName = cardConfMgr:GetBasicAttrNameByType(attrVo.attrId)
			--self.AttrNameText.text = tostring(attrName)
			--self.AttrNumText.text = tostring(math.floor(checkInt(mainEquipAttrVo.attrNum[tostring(equipVo.rare)].baseValue)))
        else
            ---这个装备部件是自己的
			local tarotEquip = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
			---@type EquipDojo
			local dojo = tarotEquip:GetEquipById(playerEquipId)
			local attrName = cardConfMgr:GetBasicAttrNameByType(dojo.mainAttrId)
			--self.AttrNameText.text = tostring(attrName)
			--self.AttrNumText.text = tostring(dojo.mainAttrNum)
        end

        ---@type EquipCoreEffectVo
        local suitVo = cardConfMgr:GetEquipSuitVoById(equipVo.suitId)
        local contentText = ""
        for i, v in pairs(suitVo.effectDesc) do
            contentText = contentText .. localize('[_num_]件套效果', { _num_ = i }) .. '\n' .. tostring(v.desc) .. '\n'
        end

        self:RefreshBoardByContent(string.format('[%d]%s', checkInt(equipVo.part), goodsVo.name), contentText, equipVo.rare)
    end
end

---RefreshBoardByContent 根据内容刷新提示板
---@param titleText string 标题文字
---@param contentText string 内容文字
function CommonTipsBoardEquip:RefreshBoardByContent(titleText, contentText, rare)
    -- 刷新文字
    local mb = GetLuaBehaviour(self.TitleNode.gameObject, TitleNodePath)
    if not isNull(mb) then
        if not KTool.IsNull(mb.Env) then
            ---@type CommonTitleNode
            local env = mb.Env
            env:RefreshUI(titleText, rare)
        end
    end
    self.ContentTxt.text = contentText

    -- self.TitleTxt:GetComponent(_ContentSizeFitter):SetLayoutHorizontal()
    self.ContentTxt:GetComponent(_ContentSizeFitter):SetLayoutVertical()
    --self.Bg:GetComponent(_ContentSizeFitter):SetLayoutVertical()
end

---------------------------------------------------
-- content fix end --
---------------------------------------------------

return CommonTipsBoardEquip