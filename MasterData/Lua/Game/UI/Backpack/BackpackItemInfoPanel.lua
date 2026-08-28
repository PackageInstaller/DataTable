------------ import ------------
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local Text = CS.UnityEngine.UI.Text
local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local Image = CS.UnityEngine.UI.Image
local CardConfMgr = CardConfMgr
local Button = CS.UnityEngine.UI.Button
local ImageAlterable = CS.Engine.UI.ImageAlterable
local UISwitchParticleSystem = CS.Game.Native.Common.UISwitchParticleSystem
local UIEventProxy = CS.Engine.UI.UIEventProxy
local cs_coroutine = require("XLua.cs_coroutine")
local GameObject = CS.UnityEngine.GameObject
local FontStyleButton = CS.Game.Native.Common.FontStyleButton
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local OverseaTowerUtils = import('Game.UI.FightReady.OverseaTower.OverseaTowerUtils')
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------

------------ define ------------
--- 物品品质背景图
local TxtSubAttrUnLockPath = "TxtLv"
local AttrNameNodePath = "AttrNameText"
local AttrValueNodePath = "AttrNumText"
local AttrNodePathTitle = "AttrUnLockedNode"
local AttrLockedNodePath = "AttrLockedNode"
local AttrRawImg = "ImgIcon"
------------ define ------------

--- from: Assets/BundleResources/Prefabs/Backpack/Backpack.prefab > name: DescrPanel
---@class BackpackItemInfoPanel
---@field Env                           	BackpackItemInfoPanel                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field EngraveTxtNumberCurrent       	UnityEngine.RectTransform               
---@field EngraveTxtAttack              	UnityEngine.RectTransform               
---@field EngraveImgAttributeIcon       	UnityEngine.RectTransform               
---@field EngraveEffective              	UnityEngine.RectTransform               
---@field EngraveInvalid                	UnityEngine.RectTransform               
---@field Engrave                       	UnityEngine.RectTransform               
---@field ImgStar                       	UnityEngine.RectTransform
---@field StarGroup                     	UnityEngine.RectTransform
---@field ImgIcon                       	UnityEngine.RectTransform
---@field ImgStrengthen                 	UnityEngine.RectTransform
---@field InforGroup1                   	UnityEngine.RectTransform
---@field FontStyleButton1              	UnityEngine.RectTransform 出售按钮
---@field FontStyleButton2              	UnityEngine.RectTransform 使用按钮
---@field ButtonGroup                   	UnityEngine.RectTransform
---@field Spine_GoodIcon                	Spine.Unity.SkeletonGraphic
---@field EdibleGroup                   	UnityEngine.RectTransform
---@field Item_PathWayList              	UnityEngine.RectTransform
---@field Item_EdibleList               	UnityEngine.RectTransform
---@field Text                          	UnityEngine.RectTransform
---@field EmptyNode                     	UnityEngine.RectTransform
---@field Root_ShowInfo                 	UnityEngine.RectTransform
---@field CardNode                      	Engine.Modules.LuaBehaviour
---@field ItemPathNotWayGo              	UnityEngine.RectTransform
---@field ItemPathNodeGo                	UnityEngine.RectTransform
---@field ItemWholeInfoElementRoot      	UnityEngine.RectTransform
---@field ItemWholeInfoRoot             	UnityEngine.RectTransform
---@field Txt_ItemDes2                  	UnityEngine.UI.Text
---@field Txt_ItemDes                   	UnityEngine.UI.Text
---@field Txt_ItemNum                   	TMPro.TextMeshProUGUI
---@field AttrOtherNode                 	UnityEngine.RectTransform
---@field AttrOtherRoot                 	UnityEngine.RectTransform
---@field AttrMainNode                  	UnityEngine.RectTransform
---@field SuitDesRoot                   	UnityEngine.UI.Text
---@field SuitTitle                     	UnityEngine.RectTransform
---@field ItemJumpAwayNodeRoot          	UnityEngine.RectTransform
---@field EquipJumpAwayNodeRoot         	UnityEngine.RectTransform
---@field EquipPropertyLayout           	UnityEngine.RectTransform
---@field EquipPropertyRoot             	UnityEngine.RectTransform
---@field Img_EquipCharactorIcon        	UnityEngine.RectTransform
---@field Img_EquipPartIcon             	UnityEngine.RectTransform
---@field BtnLock                       	UnityEngine.UI.Button
---@field Root_EquipLock                	Game.Native.Common.UISwitchImage
---@field Img_GoodIcon                  	Engine.UI.RawImageAlterable
---@field Img_EquipIcon                 	Engine.UI.RawImageAlterable
---@field EquipIconRoot                 	UnityEngine.RectTransform
---@field EquipUserInfoRoot             	UnityEngine.RectTransform
---@field SwitchShowItemsRoot           	UnityEngine.RectTransform
---@field Txt_ItemName                  	UnityEngine.UI.Text
---@field SwitchQualityLine             	Game.Native.Common.UISwitchImage
---@field RootPTCSmoke                  	UnityEngine.RectTransform
local BackpackItemInfoPanel = Class("BackpackItemInfoPanel")

------------ LifeCycle ------------

function BackpackItemInfoPanel:__init()
    self.equipComp = nil --@type EquipmentComponent
    self.equipDoJo = nil -- 装备服务器数据
    self.equipCoreDojo = nil -- 装备核心服务器数据
    self.typeEquip = nil -- 装备类型
    self.eventItemTimeCountDown = nil -- 时限物品倒计时更新事件
    self.listSwitchPTC = nil
    self.spineEmojiPrefabCache = nil  -- 动态表情预制体的缓存列表
    self.data = nil ---数据信息
    self.bgRare = nil
end

function BackpackItemInfoPanel:__delete()
    self.equipComp = nil
    self.equipDoJo = nil
    self.equipCoreDojo = nil
    self.typeEquip = nil
    self.eventItemTimeCountDown = nil
    self.listSwitchPTC = nil
    self.spineEmojiPrefabCache = nil
    self.data = nil ---数据版本
    self.bgRare = nil
end


function BackpackItemInfoPanel:Awake()
    ---装备锁定点击事件
    SetButtonAction(self.BtnLock.gameObject, Bind(self, self.OnClickLockBtnAction))
    ---@type EquipmentComponent
    self.equipComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
    self.listSwitchPTC = {}
    local arraySwitchPTC = self.RootPTCSmoke:GetComponentsInChildren(typeof(UISwitchParticleSystem))
    for i = 1, arraySwitchPTC.Length do
        table.insert(self.listSwitchPTC, arraySwitchPTC[i - 1])
    end

    self.bgRare = self.InforGroup1.transform.parent:Find("ImgBgRare")
    SetButtonAction(self.FontStyleButton1, function()
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.goodsId)
        local equipId
        local idType = GoodsUtils.GetIdType(goodsVo.id)
        if idType == Constants.IDType.Equipment then
            ---如果是装备的情况下
            --去培养页面
            EquipUtils.EnterCultivateEquipDialog(self.data.vo)
            return
        elseif idType == Constants.IDType.GoodsSameCard then
            local cardId = goodsVo.cardId
            ---@type CardComponent
            local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
            if cardComp:IsHasCard(cardId) then
                return
            end
            local goodsConfMgr = GoodsConfMgr:GetInstance()
            local row = goodsConfMgr:GetJumpModuleRow(709)
            -- print(goodsVo.effectId, goodsVo.id, table.toString(goodsVo))
            goodsConfMgr:ExecuteJump(row, {}, nil, nil, {goodsId = cardId})
            return
        end
        UIModule.OpenDialog({ id = Constants.UITypeIds.BackpackPopupDialog, parameters = { goodsVo = goodsVo, stack = checkNumber(self.data.num), type = 2, equipId = equipId } })
    end)
    SetButtonAction(self.FontStyleButton2, function()
        ---使用按钮
        local goodsId = self.data.goodsId
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if goodsVo then
            local idType = GoodsUtils.GetIdType(goodsId)
            if idType == Constants.IDType.OptionalGift then
                UIModule.OpenDialog({ id = Constants.UITypeIds.OptionalGiftSelectRewardDialog,
                                      parameters = {
                                          giftId = goodsVo.id,
                                          giftNum = self.data.num,
                                      }
                })
            elseif idType == Constants.IDType.Equipment then
                UIModule.OpenDialog(
                        { id = Constants.UITypeIds.CultivateOverseaEquipmentReclaimDialog},
                        { {id = Constants.UITypeIds.Backpack} }
                )
            elseif idType == Constants.IDType.GoodsSameCard then
                -- CfUtils.DialogOpen(Constants.UITypeIds.OverseaStoreCoreExchangeDialog, {goodsId = goodsVo.effectId}, { {id = Constants.UITypeIds.Backpack}})
                local goodsConfMgr = GoodsConfMgr:GetInstance()
                local row = goodsConfMgr:GetJumpModuleRow(706)
                goodsConfMgr:ExecuteJump(row, {}, nil, nil, {goodsId = goodsVo.effectId})

            elseif checkNumber(goodsVo.effectType) == Constants.GoodsEffectType.ConversionGoodsGroup then
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonChestUsePopUpDialog, parameters = { goodsVo = goodsVo, stack = checkNumber(self.data.num), type = 1 } })
            else
                UIModule.OpenDialog({ id = Constants.UITypeIds.BackpackPopupDialog, parameters = { goodsVo = goodsVo, stack = checkNumber(self.data.num), type = 1 } })
            end
        end
    end)
end

function BackpackItemInfoPanel:OnDestroy()
    if self.eventItemTimeCountDown then
        Events.RemoveListener(Constants.EventNames.UIEventUsableGoodsTimeCountDown, self.eventItemTimeCountDown)
        self.eventItemTimeCountDown = nil
    end
    Events.RemoveListener(Constants.EventNames.CardProgressEquipLevelUpFinish, self.levelUpFinishEvent)
    self.levelUpFinishEvent = nil
    if self.spineEmojiPrefabCache then
        for i, v in pairs(self.spineEmojiPrefabCache) do
            GameObject.Destroy(v)
        end
    end
    self.controller = nil --luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

------------ LifeCycle ------------

---NotSelectedGood
---设置物品详情界面为未选中物品状态
function BackpackItemInfoPanel:NotSelectedGood()
    --KTool.SetActive(self.EmptyNode.gameObject, true)
    local dialog = UIModule.CurrentScreen:LastDialog()
    if dialog and dialog.Env then
        ---@type Backpack
        local env = dialog.Env
        if env and env.SetDescriptionEmptyState then
            env:SetDescriptionEmptyState(false)
        end
    end
    KTool.SetActive(self.Root_ShowInfo.gameObject, false)
end

---ApplyCommonComponent
--- 启用通用组件
---@param data table
function BackpackItemInfoPanel:ApplyCommonComponent(data)
    self.data = data
    if self.eventItemTimeCountDown then
        Events.RemoveListener(Constants.EventNames.UIEventUsableGoodsTimeCountDown, self.eventItemTimeCountDown)
        self.eventItemTimeCountDown = nil
    end
    --战斗料理加的状态还原
    CfUtils.SetUISwitchText(self.Text, 1)
    KTool.SetActive(self.Item_PathWayList, true)
    KTool.SetActive(self.Item_EdibleList, false)

    local goodType = GoodsUtils.GetIdType(data.goodsId)
    KTool.DestroyGameObjectChildren(self.ItemJumpAwayNodeRoot.gameObject)
    KTool.DestroyGameObjectChildren(self.EquipJumpAwayNodeRoot.gameObject)
    --KTool.SetActive(self.EmptyNode.gameObject, false)
    local dialog = UIModule.CurrentScreen:LastDialog()
    if dialog and dialog.Env then
        ---@type Backpack
        local env = dialog.Env
        if env and env.SetDescriptionEmptyState then
            env:SetDescriptionEmptyState(true)
        end
    end
    KTool.SetActive(self.Root_ShowInfo.gameObject, true)
    KTool.SetActive(self.ItemWholeInfoRoot.gameObject, false) -- 失活需要显示信息的节点
    KTool.SetActive(self.EquipIconRoot.gameObject, false) -- 组件装备图片展示节点
    KTool.SetActive(self.EquipUserInfoRoot.gameObject, false) -- 装备使用者展示节点
    KTool.SetActive(self.BtnLock.gameObject, goodType == Constants.IDType.Equipment) --装备锁
    KTool.SetActive(self.EquipPropertyRoot.gameObject, false) -- 装备属性节点
    KTool.SetActive(self.SuitDesRoot.gameObject, false) -- 套装描述节点
    KTool.SetActive(self.Txt_ItemNum.gameObject, not (goodType == Constants.IDType.Equipment)) -- 非装备物品需要显示数量
    KTool.SetActive(self.Img_GoodIcon.gameObject, not (goodType == Constants.IDType.Equipment)) -- 物品展示图片
    KTool.SetActive(self.SuitTitle.gameObject, not (goodType ~= Constants.IDType.Equipment)) --TEMP(跳转Title)
    KTool.SetActive(self.Spine_GoodIcon.gameObject, false) -- 动态表情节点
    KTool.SetActive(self.InforGroup1.gameObject, goodType == Constants.IDType.Equipment) -- 激活需要显示信息的节点
    ---@type GoodsVo
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(data.goodsId)
    if goodsVo then
        local fontStyle = KTool.GetComponent(self.FontStyleButton2.gameObject, typeof(CS.Game.Native.Common.FontStyleButton))
        local fontStyle1 = KTool.GetComponent(self.FontStyleButton1.gameObject, typeof(CS.Game.Native.Common.FontStyleButton))
        CfUtils.FillImage(self.bgRare, GoodsUtils.GetFishBgByQualityType(goodsVo.quality))
        --print('---->>>', goodsVo.effectType, goodsVo.sellitem, data.vo.playerId)
        if goodType == Constants.IDType.Equipment then
            local maxStar = EquipUtils.GetEquipmentStarMaxByDojo(data.vo)
            KTool.SetActive(self.FontStyleButton2.gameObject, true)
            fontStyle:ResetFontStyle("B7", localize("分解"))
            KTool.SetActive(self.FontStyleButton1.gameObject, checkNumber(data.vo.star) < maxStar)
            if checkNumber(data.vo.star) < maxStar then
                fontStyle1:ResetFontStyle("B7", localize("培养"))
            end
            --if checkNumber(data.vo.locked) == 0 and checkNumber(data.vo.playerCardId) == 0 then
            --    ----表示可使用道具
            --    KTool.SetActive(self.FontStyleButton2.gameObject, checkNumber(goodsVo.bagUsed) > 0)
            --    KTool.SetActive(self.FontStyleButton1.gameObject, checkNumber(goodsVo.sellitem) > 0)
            --else
            --    ----表示可使用道具
            --    KTool.SetActive(self.FontStyleButton2.gameObject, false)
            --    --KTool.SetActive(self.FontStyleButton1.gameObject, false)
            --end
        elseif goodType == Constants.IDType.GoodsSameCard then
            local cardId = goodsVo.cardId
            ---@type CardComponent
            local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
            KTool.SetActive(self.FontStyleButton1.gameObject, not cardComp:IsHasCard(cardId))
            KTool.SetActive(self.FontStyleButton2.gameObject, true)
            fontStyle1:ResetFontStyle("B7", localize("合成"))
            fontStyle:ResetFontStyle("B6", localize("转换"))

        else
            fontStyle:ResetFontStyle("B7", localize("使用"))
            fontStyle1:ResetFontStyle("B6", localize("出售"))
            ----表示可使用道具
            KTool.SetActive(self.FontStyleButton2.gameObject, checkNumber(goodsVo.bagUsed) > 0)
            KTool.SetActive(self.FontStyleButton1.gameObject, checkNumber(goodsVo.sellitem) > 0)
        end
    end

end

---ShowItemInfo
---展示玩家物品信息
---@param data GoodsVo
function BackpackItemInfoPanel:ShowItemInfo(data)
    local goodType = GoodsUtils.GetIdType(data.goodsId)
    if goodType == Constants.IDType.Equipment then
        self:ShowEquipInfo({ goodsId = data.goodsId, playerEquipId = data.vo.id })
        return
    end
    KTool.SetActive(self.ItemWholeInfoRoot.gameObject, true) -- 激活需要显示信息的节点
    local goodsVo = data.vo
    if isNull(goodsVo) then
        return
    end
    local goodsType = GoodsUtils.GetIdType(goodsVo.id)
    if goodsType == Constants.IDType.GoodsEmoji then
        KTool.SetActive(self.Img_GoodIcon.gameObject, false)
        KTool.SetActive(self.Spine_GoodIcon.gameObject, true)
        self:LoadSpine(self.Spine_GoodIcon, goodsVo.prefabPath)
    else
        self.Img_GoodIcon:LoadSprite(goodsVo.photoPath) -- goodsIcon
    end
    local amount = checkInt(data.num) -- goodsNum
    self.Txt_ItemNum.text = string.format("x%d", amount)
    --CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ItemNumsTxtRoot) -- 重新排列 Txt 节点
    self:SetTitleBGColor(goodsVo.quality)
    local goodName = goodsVo.name -- goodsName
    self.Txt_ItemName.text = goodName
    local goodDes = goodsVo.description
    local goodDescExtra = goodsVo.desc
    self.Txt_ItemDes.text = goodDes or "" -- goodDes
    self.Txt_ItemDes2.text = goodDescExtra or ""
    self:SetGoodsJumpAway(goodsVo, self.ItemJumpAwayNodeRoot) -- 获取途经
    --- 重新排列物品信息元素
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ItemWholeInfoElementRoot)
end

---ShowBattleFoodInfo
---展示战斗料理物品信息
---@param goodsId number
function BackpackItemInfoPanel:ShowBattleFoodInfo(goodsId)
    CfUtils.SetUISwitchText(self.Text, 2)
    KTool.SetActive(self.Item_PathWayList, false)
    KTool.SetActive(self.Item_EdibleList, true)

    KTool.SetActive(self.ItemWholeInfoRoot.gameObject, true) -- 激活需要显示信息的节点
    ---@type GoodsVo
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
    if isNull(goodsVo) then
        return
    end
    self.Img_GoodIcon:LoadSprite(goodsVo.photoPath) -- goodsIcon
    local amount = checkInt(GoodsUtils.GetThingNo(goodsId)) -- goodsNum
    self.Txt_ItemNum.text = string.format("x%d", amount)
    --CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ItemNumsTxtRoot) -- 重新排列 Txt 节点
    self:SetTitleBGColor(goodsVo.quality)
    local goodName = goodsVo.name -- goodsName
    self.Txt_ItemName.text = goodName
    local goodDes = goodsVo.description
    local goodDescExtra = goodsVo.desc
    self.Txt_ItemDes.text = goodDes or "" -- goodDes
    self.Txt_ItemDes2.text = goodDescExtra or ""
    --self:SetGoodsJumpAway(goodsVo, self.ItemJumpAwayNodeRoot) -- 获取途经
    --- 重新排列物品信息元素
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ItemWholeInfoElementRoot)

    local CookingUtils = import('Game.UI.Phone.Cooking.CookingUtils')
    local vo = CookingUtils.GetBattleCookingFoodVo(goodsId)
    if vo then
        local t = CfUtils.Split(vo.desc, ";")
        if t then
            for k, v in pairs(t) do
                local go = self.Item_EdibleList.transform:Find("go" .. k)
                if not go then
                    go = CfUtils.InstantiateGo(self.EdibleGroup, self.Item_EdibleList)
                    go.name = "go" .. k
                end
                KTool.SetActive(go, true)
                CfUtils.FillText(go.transform:Find("Text"), v)
            end

            if self.Item_EdibleList.childCount > #t then
                for i = #t + 1, self.Item_EdibleList.childCount do
                    local go = self.Item_EdibleList:GetChild(i - 1)
                    if go then
                        KTool.SetActive(go, false)
                    end
                end
            end
        end
    end
end

function BackpackItemInfoPanel:SetTitleBGColor(rare)
    --rare = checkInt(rare)
    --self.Img_PanelDesTitleBG:LoadSprite(string.format(ITEM_BG_PATH, rare))
    --self.SwitchQualityLine.Status = rare
    --for i, sp in ipairs(self.listSwitchPTC) do
    --    sp.Status = rare
    --end
end

---SetGoodsJumpAway
---游戏道具跳转
---@param goodsVo GoodsVo 物品配置表数据
---@param itemInfoPathRoot UnityEngine.GameObject 跳转节点预设
function BackpackItemInfoPanel:SetGoodsJumpAway(goodsVo, itemInfoPathRoot)
    local type = GoodsUtils.GetIdType(goodsVo.id)
    if type == Constants.IDType.GoodsBattleFood or type == Constants.IDType.GoodsFavorableFood then
        goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsVo.menu)
    end
    if isSet(goodsVo, "jumpAway") and table.count(goodsVo.jumpAway) > 0 then
        local questConfMgr = QuestConfMgr:GetInstance()
        for i, v in pairs(goodsVo.jumpAway) do
            if not IsNull(v) then
                local row = GoodsConfMgr:GetInstance():GetJumpModuleRow(v)
                local go = KTool.Instantiate(itemInfoPathRoot.gameObject, self.ItemPathNodeGo.gameObject)
                KTool.SetActive(go, true)
                local textTrans = go.transform:Find("Text")
                local buttonTrans = go.transform:Find("FontStyleButton")
                local functionName = parse_localizeText(row, "functionName", "")
                local moduleId = checkInt(row:Get("moduleID"))
                if moduleId <= 0 then
                    KTool.SetActive(buttonTrans.gameObject, false)
                else
                    KTool.SetActive(buttonTrans.gameObject, true)
                end
                if (not IsNull(goodsVo.jumpParameter)) and #goodsVo.jumpParameter > 0 then
                    local questId = goodsVo.jumpParameter[i]
                    if not isNull(questId) then
                        local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
                        if questType == Constants.IDType.QuestMain then
                            ---主线
                            ---@type QuestMainVo
                            local vo = questConfMgr:GetQuestVoById(questId)
                            if isTable(vo) then
                                functionName = string.format('%s(%s)', functionName, vo.label)
                            end
                        elseif questType == Constants.IDType.QuestDaily or questType == Constants.IDType.QuestCoinsCopy or questType == Constants.IDType.QuestExpCopy or questType == Constants.IDType.QuestUpStarCopy then
                            ---副本
                            ---@type QuestDailyVo
                            local vo = questConfMgr:GetQuestVoById(questId)
                            if isTable(vo) then
                                functionName = string.format('%s(%s)', functionName, vo.label)
                            end
                        end
                    end
                    --if moduleId == Constants.UITypeIds.UIFightMap then
                    --    ---存在跳转参数的情况时需要指定关卡信息
                    --    local chapterId = goodsVo.jumpParameter[i]
                    --    if not isNull(chapterId) then
                    --        local vo = QuestConfMgr:GetInstance():GetChapterVoByID(chapterId)
                    --        if isTable(vo) then
                    --            functionName = string.format('%s第%s章', functionName, vo.id)
                    --        end
                    --    end
                    --else
                    --    ---存在跳转参数的情况时需要指定关卡信息
                    --    local questId = goodsVo.jumpParameter[i]
                    --    if not isNull(questId) then
                    --        local vo = QuestConfMgr:GetInstance():GetQuestVoById(questId) -- 关卡配表数据
                    --        if isTable(vo) then
                    --            functionName = string.format('%s(%s)', functionName, vo.label)
                    --        end
                    --    end
                    --end
                end
                KTool.GetComponent(textTrans.gameObject, typeof(Text)).text = checkString(functionName)
                --- 跳转按钮
                local btnNode = go.transform:Find("FontStyleButton") -- 跳转按钮 Trans
                if btnNode then
                    local functionID = checkNumber(row:Get("functionID"))
                    KTool.SetActive(btnNode, moduleId > 0)
                    local isUnlock = GameUtils.IsUnlockedBySystemTogId(functionID)
                    local unlockDesc = GameUtils.GetUnlockDescrBySystemTogId(functionID)
                    --区域拿参数判断  特殊
                    if functionID == Constants.SystemToggleIds.Id2001 then
                        local t = checkTable(CfUtils.Split(checkString(row:Get("parameter"))))
                        local regionId = checkNumber(t[1])
                        if regionId > 0 then
                            isUnlock, unlockDesc = ActionUtils.IsUnlockRegionalSecondPoint(regionId)
                        end
                    -- 爬塔
                    elseif moduleId == Constants.UITypeIds.UIOverseaTowerEntryDialog then
                        isUnlock, unlockDesc = OverseaTowerUtils.IsFunctionUnlock(v)
                    end

                    if isUnlock then
                        local compBtn = btnNode.gameObject:GetComponent(typeof(Button))
                        if compBtn then
                            SetButtonAction(compBtn, function()
                                ---跳转按钮的事件的逻辑
                                GoodsConfMgr:GetInstance():ExecuteJump(row, goodsVo, i, false, { gainId = goodsVo.id, num = self.data.num })
                            end)
                        end
                    else
                        btnNode.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B14")
                        local compBtn = btnNode.gameObject:GetComponent(typeof(Button))
                        if compBtn then
                            SetButtonAction(compBtn, function()
                                GameUtils.Toast(unlockDesc)
                            end)
                        end
                    end
                end
            end
        end
    else
        ---不存在时
        local go = KTool.Instantiate(itemInfoPathRoot.gameObject, self.ItemPathNotWayGo.gameObject)
        KTool.SetActive(go, true)
    end
end

---ShowItemLimitInfo
---限时道具 信息
---@param param table
function BackpackItemInfoPanel:ShowItemLimitInfo(param)
    local goodsId = checkNumber(param.goodsId)
    local playerItemId = checkNumber(param.playerItemId)
    KTool.SetActive(self.ItemWholeInfoRoot.gameObject, true)
    ---@type GoodsVo
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
    self:SetTitleBGColor(goodsVo.quality)
    self.Img_GoodIcon:LoadSprite(goodsVo.photoPath) -- goodsIcon
    local amount = checkInt(GoodsUtils.GetThingNo(goodsId, playerItemId)) -- goodsNum
    self.Txt_ItemNum.text = string.format("x%d", amount)
    local goodName = goodsVo.name
    self.Txt_ItemName.text = goodName -- goodsName
    local goodDes = goodsVo.description
    local goodDescExtra = goodsVo.desc
    self.Txt_ItemDes.text = goodDes or "" -- goodDes
    self.Txt_ItemDes2.text = goodDescExtra or ""
    --- 可使用物品模块加载
    local usableGoodComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UsableGoodComponent)
    local goods = usableGoodComponent:GetUsableGoodsTab(goodsId) -- 可使用物品数据（类型）
    local goodsData = goods[checkString(playerItemId)] -- 可使用物品数据（通过 uid 获取物品）
    --- 赋值时限 Text
    CfUtils.FillText(self.Txt_RemainTime, CfUtils.GetTimeHMS(checkNumber(goodsData.remainTime)))
    --- 时限物品时间更新函数
    local OnUsableGoodsTimeCountDown = function()
        CfUtils.FillText(self.Txt_RemainTime, CfUtils.GetTimeHMS(checkNumber(goodsData.remainTime)))
    end
    --- 使用期限
    self.eventItemTimeCountDown = Events.AddListener(Constants.EventNames.UIEventUsableGoodsTimeCountDown, Bind(self, OnUsableGoodsTimeCountDown))
end

---SetEquipUserIcon
---设置装备使用者头像
---@param playerCardId number
function BackpackItemInfoPanel:SetEquipUserIcon(playerCardId)
    local isShowCardNode = playerCardId > 0
    KTool.SetActive(self.EquipUserInfoRoot.gameObject, isShowCardNode)
    if isShowCardNode then
        ---@type CardComponent
        local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        local cardDojo = cardComp:GetCardById(playerCardId)
        local mbEnv = self.CardNode.Env
        if mbEnv then
            mbEnv:Reload({ id = playerCardId, goodsId = cardDojo.cardId })
        end
    end
end

---ShowEquipInfo
---展示玩家装备信息
---@param goodsId number
---@param uid number
function BackpackItemInfoPanel:ShowEquipInfo(goodsData)
    local goodsId = goodsData.goodsId -- 装备的物品 Id
    local uid = goodsData.playerEquipId -- 玩家装备 id
    local idType = GoodsUtils.GetIdType(goodsId) -- 装备类型
    self.typeEquip = idType -- id 类型
    --KTool.SetActive(self.Txt_RemainTime.gameObject, false)
    KTool.SetActive(self.EquipPropertyRoot.gameObject, true)  -- 激活需要显示信息的节点
    KTool.SetActive(self.AttrMainNode.gameObject, idType == Constants.IDType.Equipment) -- 主属性节点
    KTool.SetActive(self.AttrOtherRoot.gameObject, idType == Constants.IDType.Equipment) -- 副属性节点
    KTool.SetActive(self.SuitDesRoot.gameObject, idType == Constants.IDType.EquipmentCore) -- 套装描述节点
    KTool.SetActive(self.EquipIconRoot.gameObject, false) -- 装备 Icon
    KTool.SetActive(self.Img_GoodIcon.gameObject, true) -- 物品图片
    KTool.SetActive(self.ItemWholeInfoRoot.gameObject, false) -- 激活需要显示信息的节点
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
    if isNull(goodsVo) then
        return
    end
    if idType == Constants.IDType.GoodsEmoji then
        KTool.SetActive(self.Img_GoodIcon.gameObject, false)
        KTool.SetActive(self.Spine_GoodIcon.gameObject, true)
        self:LoadSpine(self.Spine_GoodIcon, goodsVo.prefabPath)
    else
        self.Img_GoodIcon:LoadSprite(goodsVo.photoPath) -- goodsIcon
    end
    if idType == Constants.IDType.Equipment then
        --- 装备分支
        self.equipDoJo = self.equipComp:GetEquipById(uid) -- 装备分支
        ---@type EquipVo
        local equipVo = CardConfMgr:GetInstance():GetEquipVoById(self.equipDoJo.equipmentId)
        if isNull(equipVo) then
            return
        end
        KTool.SetActive(self.ImgStrengthen.gameObject, checkNumber(self.equipDoJo.level) > 0)
        if checkNumber(self.equipDoJo.level) > 0 then
            CfUtils.SetUISwitchImage(self.ImgStrengthen.gameObject, checkNumber(self.equipDoJo.level))
        end

        CfUtils.FillImage(self.ImgIcon.gameObject, EquipUtils.GetEquipmentSetIcon(equipVo.equipId))
        local count = self.StarGroup.transform.childCount
        local children = {}
        for i = 1, count do
            local child = self.StarGroup.transform:GetChild(i - 1)
            if child and child.name ~= "ImgStar" then
                table.insert(children, child)
            end
        end
        for i, v in pairs(children) do
            KTool.SafeDelete(v.gameObject, true)
        end
        children = nil
        KTool.SetActive(self.ImgStar.gameObject, false)
        ---构建星级
        for i = 1, checkNumber(self.equipDoJo.star) do
            local go = KTool.Instantiate(self.StarGroup.gameObject, self.ImgStar.gameObject, false)
            go.name = 'Start_' .. i
            KTool.SetActive(go, true)
        end
        --- 设置 TitleNameBG Color
        self:SetTitleBGColor(equipVo.rare)
        EquipUtils.SetEquipPartBgScale(self.Img_EquipPartIcon, equipVo.part)
        ---@type GoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        self.Txt_ItemName.text = goodsVo.name --设置装备name
        --self.Txt_EquipLVNum.text = localize("LV._num_", { _num_ = checkString(self.equipDoJo.level) }) --设置装备level
        self:RefreshLockState(checkNumber(self.equipDoJo.locked)) --设置装备锁定状态
        self:SetEquipUserIcon(checkNumber(self.equipDoJo.playerCardId)) --设置装备使用者
        self.Img_EquipIcon:LoadSprite(goodsVo.photoPath) --设置装备卡Icon
        self:SetEquipAttrNodeInfo(self.AttrMainNode.gameObject, self.equipDoJo.mainAttrId, self.equipDoJo.mainAttrNum) -- 设置主属性
        local transBGImg = self.AttrMainNode.transform:Find("Imgbg")
        if not IsNull(transBGImg) then
            local bgImage = KTool.GetComponent(transBGImg.gameObject, typeof(Image))
            if not IsNull(bgImage) then
                bgImage.enabled = true
            end
        end
        self:SetEquipSubAttrList(self.equipDoJo) -- 设置副属性

    elseif idType == Constants.IDType.EquipmentCore then
        --- 装备核心分支
        ---@type EquipmentCoreDojo
        self.equipCoreDojo = self.equipComp:GetEquipCoreById(uid)
        ---@type EquipCoreVo
        local equipCoreVo = CardConfMgr:GetInstance():GetEquipCoreVoById(self.equipCoreDojo.equipmentCoreId)
        self:SetTitleBGColor(equipCoreVo.quality)
        ---@type GoodsVo
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if goodsVo then
            self.Img_GoodIcon:LoadSprite(goodsVo.photoPath)
            self.Txt_ItemName.text = goodsVo.name --设置装备name
        end
        self:RefreshLockState(checkNumber(self.equipCoreDojo.locked)) --设置装备锁定状态
        self:SetEquipUserIcon(checkNumber(self.equipCoreDojo.playerCardId)) --设置装备使用者
        local equipmentCoreId = goodsId
        local equipIdList = { 0, 0, 0, 0, }
        local curEquipListSuitInfo = self.equipComp:GetEquipSuitInfoByEquipIdList(equipIdList) -- 当前装备套装信息
        local suitEffectList = EquipUtils.GetAllSuitEffectList(equipmentCoreId, curEquipListSuitInfo) -- 套装效果集合
        local count = table.count(suitEffectList) -- 套装效果数量
        --- 装备套装描述
        local suitDesSign = {}
        for i = 1, count do
            table.insert(suitDesSign, localize("[_num_件效果]", { _num_ = suitEffectList[i].effectNum }))
            table.insert(suitDesSign, string.format("<color=#cccccc>%s</color>", suitEffectList[i].desc))
            table.insert(suitDesSign, "\n")
            if i < count then
                table.insert(suitDesSign, "<size=8>\n</size>")
            end
        end
        if not IsNull(self.SuitDesRoot) then
            self.SuitDesRoot.text = table.concat(suitDesSign)
        end
    end
    --- 获取途经
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId) -- 获取 goodsVo
    if goodsVo then
        xTry(function()
            self:SetGoodsJumpAway(goodsVo, self.EquipJumpAwayNodeRoot)
        end)
    end
    --- 装备刻印
    if checkInt(self.equipDoJo.bindPlayerCardId) > 0 then
        CfUtils.SetActive(self.Engrave, true)
        local isActive = EquipUtils.IsEngraveActive(self.equipDoJo)
        CfUtils.SetActive(self.EngraveInvalid, not isActive)
        CfUtils.SetActive(self.EngraveEffective, isActive)
        local cardConfMgr = CardConfMgr:GetInstance()
        ---@type EquipVo
        local equipVo = cardConfMgr:GetEquipVoById(self.equipDoJo.equipmentId)
        local mainAttrAdditionId = self.equipDoJo.mainAttrId
        local attrAdditionVo = cardConfMgr:GetBasicAttrAdditionById(mainAttrAdditionId)
        local mainEquipAttrVo = cardConfMgr:GetEquipAttrVoById(equipVo.poolMain)
        local attrAddVo = cardConfMgr:GetBasicAttrAdditionById(mainEquipAttrVo.attrAdditionId)
        local attrVo = cardConfMgr:GetBasicAttr(attrAddVo.attrId)

        CfUtils.FillImage(self.EngraveImgAttributeIcon, attrVo.icon)
        CfUtils.FillText(self.EngraveTxtAttack, attrAdditionVo.attrAdditionName)
        local equipDojo = self.equipDoJo
        local equipVo = cardConfMgr:GetEquipVoById(equipDojo.equipmentId)
        local mainEquipAttrVo = cardConfMgr:GetEquipAttrVoById(equipVo.poolMain)
        local attrAddVo = cardConfMgr:GetBasicAttrAdditionById(mainEquipAttrVo.attrAdditionId)
        local addition = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.EquipmentEngraveAddiRate))
        local value = equipDojo.mainAttrNum * addition
        value = attribute_format(attrAddVo.isConversion, value)
        CfUtils.FillText(self.EngraveTxtNumberCurrent, math.floor(value + 0.5))
        CfUtils.SetUISwitchText(self.EngraveTxtAttack, isActive and 2 or 1)
        CfUtils.SetUISwitchText(self.EngraveTxtNumberCurrent, isActive and 2 or 1)
    else
        CfUtils.SetActive(self.Engrave, false)
    end
    --- 重新排列物品信息元素
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.EquipPropertyLayout)
end

---OnClickLockBtnAction
---装备锁定点击事件
function BackpackItemInfoPanel:OnClickLockBtnAction()
    local playerEquipmentId
    local playerEquipmentCoreId
    local status
    local requestData
    if self.typeEquip == Constants.IDType.Equipment then
        -- 装备分支
        playerEquipmentId = self.equipDoJo.id
        status = checkNumber(self.equipDoJo.locked) == 0 and 1 or 0
        requestData = { playerEquipmentId = playerEquipmentId, status = status }
    elseif self.typeEquip == Constants.IDType.EquipmentCore then
        -- 装备核心分支
        playerEquipmentCoreId = self.equipCoreDojo.id
        status = checkNumber(self.equipCoreDojo.locked) == 0 and 1 or 0
        requestData = { playerEquipmentCoreId = playerEquipmentCoreId, status = status }
    end
    GameUtils.Request(
            Interfaces.EquipmentLock,
            requestData,
            function(request, response)
                if checkInt(response.errCode) == 0 then
                    local dojo
                    if self.typeEquip == Constants.IDType.Equipment then
                        self.equipComp:SetLockStateById(playerEquipmentId, status)
                        dojo = self.equipComp:GetEquipById(playerEquipmentId)
                    elseif self.typeEquip == Constants.IDType.EquipmentCore then
                        self.equipComp:SetLockStateByCoreId(playerEquipmentCoreId, status)
                        dojo = self.equipComp:GetEquipCoreById(playerEquipmentCoreId)
                    end
                    self.data.vo.locked = checkNumber(dojo.locked)
                    self.equipDoJo.locked = checkNumber(dojo.locked)
                    self:RefreshLockState(checkNumber(dojo.locked))
                    if checkNumber(dojo.locked) > 0 then
                        GameUtils.Toast(localize("锁定成功"))
                    end
                end
            end)
end

---RefreshLockState
---刷新物品锁定状态
---@param lock number
function BackpackItemInfoPanel:RefreshLockState(lock)
    self.Root_EquipLock.Status = (lock <= 0) and 2 or 1
    if lock == 1 then
        ----表示可使用道具
        KTool.SetActive(self.FontStyleButton2.gameObject, false)
        --KTool.SetActive(self.FontStyleButton1.gameObject, false)
    end
end

---SetEquipAttrNodeInfo
---设置装备属性信息
---@param go UnityEngine.GameObject 节点 GO
---@param pAttrId number 属性 ID
---@param attrValue number 属性数值
---@param title string 属性数值
---@param attrQuality string 属性数值
function BackpackItemInfoPanel:SetEquipAttrNodeInfo(go, pAttrId, attrValue, title, attrQuality)
    local node_AttrLocked = go.transform:Find(AttrLockedNodePath)
    local node_AttrUnlocked = go.transform:Find(AttrNodePathTitle)
    if not IsNull(node_AttrUnlocked) then
        KTool.SetActive(node_AttrUnlocked.gameObject, true)
    end
    if not IsNull(node_AttrLocked) then
        KTool.SetActive(node_AttrLocked.gameObject, false)
    end
    local attrAdditionData = CardConfMgr:GetInstance():GetBasicAttrAdditionById(pAttrId)
    local attrId = attrAdditionData.attrId
    local attrData = CardConfMgr:GetInstance():GetBasicAttr(attrId)
    local txt_AttrName = go.transform:Find(title and string.format("%s%s%s", AttrNodePathTitle, "/", AttrNameNodePath) or AttrNameNodePath):GetComponent(typeof(Text))
    local txt_AttrValue = go.transform:Find(title and string.format("%s%s%s", AttrNodePathTitle, "/", AttrValueNodePath) or AttrValueNodePath):GetComponent(typeof(TextMeshProUGUI))
    KTool.SetActive(txt_AttrName.gameObject, true)
    KTool.SetActive(txt_AttrValue.gameObject, true)
    local iconAttr = go.transform:Find(title and string.format("%s%s%s", AttrNodePathTitle, "/", AttrRawImg) or AttrRawImg):GetComponent(typeof(ImageAlterable))
    if not IsNull(iconAttr) then
        KTool.SetActive(iconAttr.gameObject, (not IsNull(attrData.icon)) and attrData.icon ~= "")
        iconAttr:LoadSprite(attrData.icon)
    end
    txt_AttrName.text = attrData.name

    if attrQuality then
        txt_AttrValue.text = tostring(attrValue)
        CfUtils.SetUISwitchText(txt_AttrValue.gameObject, attrQuality)
    else
        local attrIsConversion = attrAdditionData.isConversion
        txt_AttrValue.text = tostring(attribute_format(attrIsConversion, attrValue))
    end
end

---SetEquipAttrNodeLocked
---设置锁定的 AttrNode
---@param go UnityEngine.GameObject
---@param star string
function BackpackItemInfoPanel:SetEquipAttrNodeLocked(go, star)
    local node_AttrLocked = go.transform:Find(AttrLockedNodePath)
    local node_AttrUnlocked = go.transform:Find(AttrNodePathTitle)
    KTool.SetActive(node_AttrUnlocked.gameObject, false)
    KTool.SetActive(node_AttrLocked.gameObject, true)
    local txt_UnLockLV = node_AttrLocked:Find(TxtSubAttrUnLockPath):GetComponent(typeof(Text))
    if not IsNull(txt_UnLockLV) then
        txt_UnLockLV.text = localize("_num_星", { _num_ = checkString(star) })
    end
end

---SetEquipSubAttrList
---设置装备副属性列表
---@param equipDJ EquipDojo
function BackpackItemInfoPanel:SetEquipSubAttrList(equipDJ)
    local count = self.AttrOtherRoot.transform.childCount
    local maxSubCount = EquipUtils.GetEquipmentSubAttrMaxCountByDojo(equipDJ)
    local forTimes = math.max(count, maxSubCount)
    for i = 1, forTimes do
        --- 需要实例化游戏物体
        if i <= count then
            local go = self.AttrOtherRoot:GetChild(i - 1).gameObject
            local isShow = i <= maxSubCount
            KTool.SetActive(go, isShow)
            if isShow then
                self:FreshAttrOtherNode(go, equipDJ, i)

            end
        end
    end
end

function BackpackItemInfoPanel:FreshAttrOtherNode(go, equipDJ, index)
    ---@type BackpackAttrOtherNode
    local env = CfUtils.GetLuaScr(go, "Game.UI.Backpack.BackpackAttrOtherNode")
    if isNull(env) then return end
    env:FreshUI(equipDJ, index)
end

--- 加载spine动画资源
---@param spineComp string spine组件
---@param resPath string 资源路径
function BackpackItemInfoPanel:LoadSpine(spineComp, resPath)
    cs_coroutine.start(function()
        self.spineEmojiPrefabCache = checkTable(self.spineEmojiPrefabCache)
        local outData = { skeletonDataAsset = nil }
        cs_coroutine.yield_return(GameUtils.GetSpineEmojiData(resPath, outData, true, self.spineEmojiPrefabCache))
        if IsNull(outData.skeletonDataAsset) then
            return
        end
        spineComp.skeletonDataAsset = outData.skeletonDataAsset
        spineComp:Initialize(true)
    end)
end

return BackpackItemInfoPanel