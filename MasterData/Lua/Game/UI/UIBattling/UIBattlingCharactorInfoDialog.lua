------------ import ------------

local CoWait = CS.Engine.Lib.CoWait
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local UIEventProxy = CS.Engine.UI.UIEventProxy
local ImageAlterable = CS.Engine.UI.ImageAlterable
local Image = CS.UnityEngine.UI.Image
local GameObject = CS.UnityEngine.GameObject
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour
local UISwitchImage = CS.Game.Native.Common.UISwitchImage
local Yielders = CS.Engine.Lib.Yielders
local UISwitchImageType = CS.Game.Native.Common.UISwitchImage
local ScrollRect = CS.UnityEngine.UI.ScrollRect
local RectTransform = CS.UnityEngine.RectTransform
local NonDrawingGraphic = CS.UnityEngine.UI.Extensions.NonDrawingGraphic
local UISwitchTextMeshPro = CS.Game.Native.Common.UISwitchTextMeshPro
local LoopType = CS.DG.Tweening.LoopType
local Ease = CS.DG.Tweening.Ease
local util = require "XLua.util"
local cs_coroutine = require("XLua.cs_coroutine")
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local CardConfMgr = CardConfMgr:GetInstance()
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
local ResourceModule           = CS.Engine.Modules.ResourceModule
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
------------ import ------------

------------ define ------------
local StarAwakenSpritePath = "uiatlas/common/common_ico_star_1" -- 人物星级觉醒图片路径
local StarDefautSpritePath = "uiatlas/common/common_ico_star_2" -- 人物星级默认图片路径
local BattlingEnemySkillDesc = "Game.UI.UIBattling.BattlingEnemySkillDesc"
local ORDER_IN_LAYER_TIPS = 11

local ROOT_HP_A_POS = {
    Player = Vector2.New(558, 344),
    Enemy = Vector2.New(370, 393)
}
local ROOT_BUFF_LIST_POSX = {
    Player = 1180,
    Enemy = 1015,
}
local BUFF_LIST_NODE = "Game.UI.UIBattling.UIBattlingBuffListNode"
local BUFF_LIST_NODE_SMALL = "Game.UI.UIBattling.UIBattlingCharactorBuffNode"
local CULTIVATE_ATTR_NODE = "Game.UI.Cultivate.UICultivateAttributeNode"
local CULTIVATE_STAR_UP_SKILL_DESC_NODE = "Game.CardProgression.Star.CardProgressionStarUpSkillDescNode"
local CharacterSkillDescNodeOffset = Vector2.New(550,0)
local CharacterSkillDescNodeOffsetPassive = Vector2.New(970,0)
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingCharactorInfoDialog.prefab > name: UIBattlingCharactorInfoDialog
---@class UIBattlingCharactorInfoDialog
---@field Env                           	UIBattlingCharactorInfoDialog           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field AttrLoopListView              	SuperScrollView.LoopListView2           	@ 0    
---@field RT_EnemyGiftSkillNode         	UnityEngine.RectTransform               	@ 1    
---@field RT_EnemyGiftSkillRoot         	UnityEngine.RectTransform               	@ 2    
---@field RT_SplitLine                  	UnityEngine.RectTransform               	@ 3    
---@field RT_CatBallDescGroup           	UnityEngine.RectTransform               	@ 4    
---@field TxtEnglishName                	TMPro.TextMeshProUGUI                   	@ 5    
---@field BattleRoleIInfoNode           	UnityEngine.RectTransform               	@ 6    
---@field BattleRoleIInfoGroup          	UnityEngine.RectTransform               	@ 7    
---@field TxtPlayerName                 	UnityEngine.UI.Text                     	@ 8    
---@field UIBattlingBuffDesNode         	Engine.Modules.LuaBehaviour             	@ 9    
---@field RootRoleBuffNode              	UnityEngine.RectTransform               	@ 10   
---@field Root_CharactorBuffInfoList    	UnityEngine.RectTransform               	@ 11   
---@field Root_HpAndSp                  	UnityEngine.RectTransform               	@ 12   
---@field ImgEnemyHead                  	Engine.UI.ImageAlterable                	@ 13   
---@field ImgCharactor                  	Engine.UI.ImageAlterable                	@ 14   
---@field EnemySkillDescNode            	Engine.Modules.LuaBehaviour             	@ 15   
---@field Root_SkillElement             	UnityEngine.RectTransform               	@ 16   
---@field Root_EnemySkillList           	UnityEngine.RectTransform               	@ 17   
---@field Btn_CloseDesc                 	UnityEngine.RectTransform               	@ 18   
---@field GiftCell                      	Engine.Modules.LuaBehaviour             	@ 19   
---@field SkillCardNode_3               	Engine.Modules.LuaBehaviour             	@ 20   
---@field SkillCardNode_2               	Engine.Modules.LuaBehaviour             	@ 21   
---@field SkillCardNode_1               	Engine.Modules.LuaBehaviour             	@ 22   
---@field Root_CharacterSkillList       	UnityEngine.RectTransform               	@ 23   
---@field Root_SkillDesc                	UnityEngine.RectTransform               	@ 24   
---@field Img_SpPoint                   	UnityEngine.RectTransform               	@ 25   
---@field CharactorSpBgRoot             	UnityEngine.RectTransform               	@ 26   
---@field Txt_ShiledValue               	TMPro.TextMeshProUGUI                   	@ 27   
---@field Txt_HpValue                   	TMPro.TextMeshProUGUI                   	@ 28   
---@field Txt_EnemyName                 	UnityEngine.UI.Text                     	@ 29   
---@field Txt_FriendName                	UnityEngine.UI.Text                     	@ 30   
---@field Txt_CharatorLvNum             	TMPro.TextMeshProUGUI                   	@ 31   
---@field Root_CharatorStarsState       	UnityEngine.RectTransform               	@ 32   
---@field Img_IconEnemyAttrType         	Engine.UI.ImageAlterable                	@ 33   
---@field Img_IconFriendAttrType        	Engine.UI.ImageAlterable                	@ 34   
---@field Img_IconCharactorBattleType   	Engine.UI.ImageAlterable                	@ 35   
---@field Root_TopEnemyTeam             	UnityEngine.RectTransform               	@ 36   
---@field Root_TopPlayerTeam            	UnityEngine.RectTransform               	@ 37   
---@field PanelCloseBtn                 	UnityEngine.RectTransform               	@ 38   
---@field Root_BuffListSmall            	UnityEngine.RectTransform               	@ 39   
---@field Content_BuffListSmall         	UnityEngine.RectTransform               	@ 40   
---@field Txt_AttackValue               	TMPro.TextMeshProUGUI                   	@ 41   
---@field Txt_DefenseValue              	TMPro.TextMeshProUGUI                   	@ 42   
---@field Root_Arrow                    	UnityEngine.RectTransform               	@ 43   
---@field Root_DescGroup                	UnityEngine.RectTransform               	@ 44   
---@field CultivateAttributeNode        	UnityEngine.RectTransform               	@ 45   
---@field Switch_RoleBg0                	Game.Native.Common.UISwitchImage        	@ 46   
---@field Switch_RoleBg1                	Game.Native.Common.UISwitchImage        	@ 47   
---@field Switch_EnemyBg                	Game.Native.Common.UISwitchImage        	@ 48   
---@field TrammelsDescGroup             	UnityEngine.RectTransform               	@ 49   
local UIBattlingCharactorInfoDialog = Class("UIBattlingCharactorInfoDialog")

------------------------------------------------LifeCycle
function UIBattlingCharactorInfoDialog:__init()
    self:CleanField()
    
end

function UIBattlingCharactorInfoDialog:__delete()
    self:CleanField()
    self.controller = nil
    self = nil
end

function UIBattlingCharactorInfoDialog:CleanField()
    self.characterId = nil
    self.campType = nil
    self.characterUID = nil
    self.characterBuffList = nil
    self.characterSkillCardDataList = nil
    self.curMonsterTypeVo = nil
    self.arrIdsShowList = nil
    self.indexShow = nil
    self.__panelTabAction = nil
    self.__actionOnPanelClose = nil
    self.coRebuild = nil
    self.btnSkill_1 = nil
    self.btnSkill_2 = nil
    self.btnSkill_3 = nil
    self.btnCloseDesc = nil
    self.luaTableSkillDesc = nil
    self.luaTableSPSkillDesc = nil
    self.listBtnSkills = nil
    self.indexSkillSelectNow = nil
    self.listEnemySkills = nil -- 敌方技能列表
    self.listEnemySkillPrefabs = nil -- 技能描述Node缓存池
    self.listEnemySkillCardLB = nil -- 技能描述节点lua table的缓存池
    self.curRoleView = nil -- 当前角色的 RoleView 数据
    self.cardId = nil
    self.rootHP = nil
    self.listSPNode = nil -- 人物 sp 点预设 列表
    self.listBuffNode = nil
    self.scrollBuffList = nil
    self.scrollContent = nil
    self.coHandleScroll = nil
    self.bgInteractive = nil
    self.listSmallBuffNode = nil    -- 小buff节点的数组
    self.listAttrNode = nil         -- 属性节点的数组
    self.UISwitchTMP_attack = nil   -- 攻击力的颜色切换组件
    self.UISwitchTMP_defense = nil  -- 防御力的颜色切换组件
    self.UISwitchTMP_hp = nil       -- 血量的颜色切换组件
    self.playerSkillTipsBoard = nil -- 玩家技能描述的弹窗
end

function UIBattlingCharactorInfoDialog:Awake()
    self.characterUID = 0
    self.characterBuffList = {}
    self.characterSkillCardDataList = {}
    self.curMonsterTypeVo = {}
    self.listBtnSkills = {}
    self.listSPNode = {}
    self.listBuffNode = {}
    self.listSmallBuffNode = {}
    self.listAttrNode = {}
end

function UIBattlingCharactorInfoDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(
            util.cs_generator(
                    function()
                        KTool.GetOrAddComponent(self.PanelCloseBtn.gameObject, typeof(UIEventProxy)).onPointerClick = function()
                            UIModule.BackDialog()
                        end
                        UIBattlingTools.AddCanvasComponent(self.Root_CharacterSkillList.gameObject, ORDER_IN_LAYER_TIPS + 1)
                        coroutine.yield(Yielders.EndOfFrame)
                        local argument = self.controller.Argument
                        local roleId = argument.parameters.id
                        self:SetPanelInfo(roleId)
                        self:SetSkillCatPanelInfo(roleId)
                        self:SetEmotionBonusDesc(roleId)
                    end))
    return coWait
end

function UIBattlingCharactorInfoDialog:OnInitialize()
    xTry(function()
        ---@type Engine.UI.UIArgument
        local argument = self.controller.Argument
        self.campType = argument.parameters.camp
        self.__actionOnPanelClose = argument.parameters.callBack
        xTry(function() 
            self:InitComponent()
        end)
        --self:InitShowCharacterList(self.campType)
        self:SetRoleInfoSwitchList()
    end)
end

function UIBattlingCharactorInfoDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(
            util.cs_generator(
                    function()
                        if not isNull(self.playerSkillTipsBoard) then
                            KTool.SafeDelete(self.playerSkillTipsBoard)
                        end
                        if self.coHandleScroll then
                           cs_coroutine.stop(self.coHandleScroll) 
                        end
                        self:ClearBuffListSmallContent()
                        self:ClearAttrNodes()
                        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(true)
                        if not IsNull(self.__actionOnPanelClose) then
                            self.__actionOnPanelClose(self)
                            self.__actionOnPanelClose = nil
                        end
                        UIBattlingTools.CloseCommonTipsBoard()
                        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
                        self:Delete()
                        self = nil --lua层的gc需要
                    end
            )
    )
    return coWait
end

function UIBattlingCharactorInfoDialog:InitComponent()
    --self.SkillDesc:Init()
    --self.luaTableSkillDesc = self.SkillDesc.Env
    --self.SpSkillDesc:Init()
    --self.luaTableSPSkillDesc = self.SpSkillDesc.Env
    --self:SetActionSkillDescClick(self.Btn_CloseDesc, nil)
    
    self.SkillCardNode_1:Init()
    self.btnSkill_1 = self.SkillCardNode_1.Env
    self.btnSkill_1:SetSkillIndex("0")
    self:SetActionSkillDescClick(self.btnSkill_1.controller, self.btnSkill_1:GetSkillIndex())

    self.SkillCardNode_2:Init()
    self.btnSkill_2 = self.SkillCardNode_2.Env
    self.btnSkill_2:SetSkillIndex("1")
    self:SetActionSkillDescClick(self.btnSkill_2.controller, self.btnSkill_2:GetSkillIndex())

    self.SkillCardNode_3:Init()
    self.btnSkill_3 = self.SkillCardNode_3.Env
    self.btnSkill_3:SetSkillIndex("2") -- SP 卡
    self:SetActionSkillDescClick(self.btnSkill_3.controller, self.btnSkill_3:GetSkillIndex())
    
    self.GiftCell:Init()
    self.btnSkill_4 = self.GiftCell.Env
    self.btnSkill_4:SetSkillIndex("4") -- 天赋（SP被动）卡
    self:SetActionSkillDescClick(self.btnSkill_4.controller, self.btnSkill_4:GetSkillIndex())

    table.insert(self.listBtnSkills, self.btnSkill_1)
    table.insert(self.listBtnSkills, self.btnSkill_2)
    table.insert(self.listBtnSkills, self.btnSkill_3)
    table.insert(self.listBtnSkills, self.btnSkill_4)

    self.scrollBuffList = KTool.GetOrAddComponent(self.Root_CharactorBuffInfoList.gameObject, typeof(ScrollRect))
    local transScrollContent = self.Root_CharactorBuffInfoList:Find("Viewport/Content")
    if not isNull(transScrollContent) then
        self.scrollContent = KTool.GetComponent(transScrollContent.gameObject, typeof(RectTransform))
    end
    self.bgInteractive = KTool.GetOrAddComponent(self.Root_CharactorBuffInfoList.gameObject, typeof(NonDrawingGraphic))

    -- 关闭小buff，打开buff详情
    KTool.GetOrAddComponent(self.Content_BuffListSmall.gameObject, typeof(UIEventProxy)).onPointerClick = Bind(self, self.ShowBuffListDetail)

    -- 关闭所有二级窗口
    KTool.GetOrAddComponent(self.Btn_CloseDesc.gameObject, typeof(UIEventProxy)).onPointerClick = Bind(self, self.CloseAllSecondaryWindow)

    KTool.GetOrAddComponent(self.Root_Arrow.gameObject, typeof(CS.UnityEngine.CanvasRenderer))
    KTool.GetOrAddComponent(self.Root_Arrow.gameObject, typeof(NonDrawingGraphic))
    KTool.GetOrAddComponent(self.Root_Arrow.gameObject, typeof(UIEventProxy)).onPointerClick = Bind(self, self.ShowAttributeInfo)
    local startX = self.Root_Arrow.transform.localPosition.x
    self.Root_Arrow.transform:DOLocalMoveX(startX+10, 0.5):SetEase(Ease.InOutBack):SetLoops(-1, LoopType.Yoyo)

    self.UISwitchTMP_attack = KTool.GetComponent(self.Txt_AttackValue.gameObject, typeof(UISwitchTextMeshPro))
    self.UISwitchTMP_defense = KTool.GetComponent(self.Txt_DefenseValue.gameObject, typeof(UISwitchTextMeshPro))
    self.UISwitchTMP_hp = KTool.GetComponent(self.Txt_HpValue.gameObject, typeof(UISwitchTextMeshPro))
end

------------------------------------------------LifeCycle

function UIBattlingCharactorInfoDialog:SetRootHpAndSpPos(pos)
    if not IsNull(self.Root_HpAndSp) then
        self.Root_HpAndSp.anchoredPosition = pos
    end
end

function UIBattlingCharactorInfoDialog:SetActionSkillDescClick(go, index)
    KTool.GetOrAddComponent(go.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        self.indexSkillSelectNow = index
        self:SetSkillDesc()
        self:SetSkillCardSelectState()
    end
end

---SetSkillDesc
---设置技能描述
function UIBattlingCharactorInfoDialog:SetSkillDesc()
    if not IsNull(self.indexSkillSelectNow) then
        local characterBattleData = UIBattlingDataMgr:GetCharactorDataById(self.roleId)
        local awakeningLevel = characterBattleData.awakeningLevel
        local finalSkillLevel = characterBattleData.skillList["0"].skillLv

        local cardVo = CardConfMgr:GetCardByRefId(self.cardId)
        local skillsData = CardProgressionSkillUtils.InitSkills(cardVo, awakeningLevel, finalSkillLevel)

        local booleanIsGift = self.indexSkillSelectNow == "4"
        local index = booleanIsGift and checkNumber(self.indexSkillSelectNow) or (checkNumber(self.indexSkillSelectNow) + 1)

        -- 把大招的逻辑等级改为显示等级
        for i, skill in ipairs(skillsData) do
            if checkNumber(skill[3]) == CardProgressionConstants.SkillGroupType.Final then
                local realLv = checkNumber(skill[2])
                local showLv = CardConfMgr:GetFinalSkillDisplayLevel(realLv)
                skill[2] = showLv
            end
        end
        
        local skillData = skillsData[index]
        local params = {
            skillData = skillData,
            cardVo = cardVo,
            isSpecify = false,
        }

        self:ShowSkillDescBoard(params, booleanIsGift)
    end
end

function UIBattlingCharactorInfoDialog:ShowSkillDescBoard(params, isGift)    
    -- local params = {
    --     skillData = {
    --         skillId = 1,
    --         skillLv = 1,
    --         skillGroupType = 1,
    --     },
    --     cardVo = cardVo,
    --     isSpecify = false,
    -- }
    local targetNode = self.Root_CharacterSkillList.gameObject
    ResourceModule.LoadGameObjectAsync(CardProgressionConstants.PrefabPath.CommonCardSkillDesc, function(go)
        if not isNull(go) and not isNull(targetNode) then
            go.name = "CardProgressionSkillDesc"
            ---@type CardProgressionSkillDesc
            local env = CfUtils.GetLuaScr(go, CardProgressionConstants.EnvPath.CardProgressionSkillDesc)
            if isNull(env) then
                return
            end
            -- env:SetSmallTipsDirection(smallTipsDirection or 1)
            env:FreshUI(params)
            env:SetBgPivot(Vector2.New(0, 0.5))
            env:FixBoardPosition3(targetNode, isGift and CharacterSkillDescNodeOffsetPassive or CharacterSkillDescNodeOffset, true)

            self.playerSkillTipsBoard = go
            UIBattlingTools.AddCanvasComponent(go, ORDER_IN_LAYER_TIPS)
        end
    end, true, UIModule.RootCanvas.transform)
end

---SetSkillCardSelectState
---设置 技能卡 选择状态
function UIBattlingCharactorInfoDialog:SetSkillCardSelectState()
    for i = 1, #self.listBtnSkills do
        local cardIndex = self.listBtnSkills[i]:GetSkillIndex()
        self.listBtnSkills[i]:SetSelectedState(cardIndex == self.indexSkillSelectNow)
    end
end

function UIBattlingCharactorInfoDialog:EnemyListRefresh()
    if IsNull(self.listEnemySkillPrefabs) then self.listEnemySkillPrefabs = {} end
    if IsNull(self.listEnemySkillCardLB) then self.listEnemySkillCardLB = {} end
    if #self.listEnemySkills > #self.listEnemySkillPrefabs then
        for i = 1, #self.listEnemySkills - #self.listEnemySkillPrefabs do
            local go = KTool.Instantiate(self.Root_SkillElement.gameObject, self.EnemySkillDescNode.gameObject)
            table.insert(self.listEnemySkillPrefabs, go)
            KTool.SetActive(self.listEnemySkillPrefabs[i], true)
            local cellLB = GetLuaBehaviour(self.listEnemySkillPrefabs[i], BattlingEnemySkillDesc)
            cellLB:Init()
            local cellMB = cellLB.Env
            table.insert(self.listEnemySkillCardLB, cellMB)
            cellMB:ReloadNodeInfo(self.listEnemySkills[i], self.characterId)
            KTool.GetOrAddComponent(go, typeof(UIEventProxy)).onPointerClick = function() 
                cellMB:SetSkillDescriptionShow()
                -- self:ClearEnemySkillCardSelectState()
                -- cellMB:SetSelectedState(true)
            end
        end
    end
    -- 如果超过6个技能，就需要打开scroll view
    local scrollRect = self.Root_SkillElement.parent:GetComponent(typeof(ScrollRect))
    if not IsNull(scrollRect) then
        scrollRect.enabled = #self.listEnemySkills > 6
    end

    -- 如果是人型怪还会有被动技能按钮
    local hasGiftSkill = isNotNull(self.enemyInfo)
    if hasGiftSkill then
        local cardId = self.enemyInfo.cardId
        local monsterId = self.enemyInfo.monsterId
        local roleId = self.enemyInfo.roleId
        self.enemyInfo = nil

        local questId = UIBattlingDataMgr:GetQuestId()
        -- 人型怪有两种，一种是关卡卡牌怪，一种是PVP玩家的角色
        local passiveLevel, finalSkillLevel
        if UIBattleSettingMgr.UIType == UIBattleSettingMgr.EnumUIType.PVP
        or BattleInfo.BattleWithPlayerTeam(questId) then
            local characterBattleData = UIBattlingDataMgr:GetCharactorDataById(roleId)
            passiveLevel = characterBattleData.awakeningLevel
            finalSkillLevel = characterBattleData.skillList["0"].skillLv
        else
            local cardMonsterVo = CardConfMgr:GetCardMonsterVoById(monsterId)
            passiveLevel = cardMonsterVo.passiveLevel
            finalSkillLevel = cardMonsterVo.skillLevel
        end
        -- 获取卡牌怪的vo
        local cardVo = CardConfMgr:GetCardByRefId(cardId)
        local giftVo = CardProgressionSkillUtils.GetTalentVo(cardId, passiveLevel)
        -- 显示被动技能按钮
        local lt = GetLuaBehaviour(self.RT_EnemyGiftSkillNode.gameObject, "Game.UI.UIBattling.UIBattlingSkillCardSkillInfoNode").Env
        lt:SetGiftSkillInfo(nil, nil, nil, giftVo)
        -- 设置按钮回调
        KTool.GetOrAddComponent(self.RT_EnemyGiftSkillNode.gameObject, typeof(UIEventProxy)).onPointerClick = function()
            local skillsData = CardProgressionSkillUtils.InitSkills(cardVo, passiveLevel, finalSkillLevel)
            local skillData = skillsData[4]
            local params = {
                skillData = skillData,
                cardVo = cardVo,
                isSpecify = false,
            }
            self:ShowSkillDescBoard(params, true)
        end
    end
    KTool.SetActive(self.RT_EnemyGiftSkillRoot, hasGiftSkill)
end

function UIBattlingCharactorInfoDialog:ClearEnemySkillCardSelectState()
    for i = 1, #self.listEnemySkillCardLB do
        self.listEnemySkillCardLB[i]:SetSelectedState(false)
    end
end

---SetRootHpAndSp
---设置人物 Hp & Sp & Shield
---@param id integer @ 人物 UID
function UIBattlingCharactorInfoDialog:SetRootHpAndSp(id)
    --- 人物 Hp
    local characterAttrData = self.curRoleView.attr
    local characterHpNow = characterAttrData:GetValue(Constants.AttrTypeId.NowHp) -- 当前血量
    local characterHpMax = characterAttrData:GetValue(Constants.AttrTypeId.Hp) -- 当前血量上限
    local characterHpOriginMax = characterAttrData:GetOriginValue(Constants.AttrTypeId.Hp) -- 角色入场血量上限
    self.Txt_HpValue.text = string.format("<color=#4a4a4a>%d/</color>%d", math.floor(characterHpNow), math.floor(characterHpMax))
    local deltaHpMax = checkNumber(characterHpMax - characterHpOriginMax)
    if deltaHpMax == 0 then
        self.UISwitchTMP_hp.Status = 1
    elseif deltaHpMax > 0 then
        self.UISwitchTMP_hp.Status = 2
    elseif deltaHpMax < 0 then
        self.UISwitchTMP_hp.Status = 3 
    end
    --- 人物 Sp
    self:SetCharacterSpNode()
    --- 人物护盾
    local shield = UIBattlingCtrlMgr:GetInstance():GetCharacterShieldValue(id)
    self.Txt_ShiledValue.text = tostring(checkInt(shield[1]))
    --- 人物攻击力
    local baseAttack = checkNumber(characterAttrData:GetOriginValue(Constants.AttrTypeId.Attack))
    local nowAttack = checkNumber(characterAttrData:GetValue(Constants.AttrTypeId.Attack))
    -- local baseAttack = characterAttrData:GetValue(Constants.AttrTypeId.Attack)
    self.Txt_AttackValue.text = tostring(math.floor(checkNumber(nowAttack)))
    local deltaAttack = checkNumber(nowAttack - baseAttack)
    if deltaAttack == 0 then
        self.UISwitchTMP_attack.Status = 1
    elseif deltaAttack > 0 then
        self.UISwitchTMP_attack.Status = 2
    elseif deltaAttack < 0 then
        self.UISwitchTMP_attack.Status = 3
    end
    --- 人物防御力
    local baseDefense = characterAttrData:GetOriginValue(Constants.AttrTypeId.Defense)
    local nowDefense = characterAttrData:GetValue(Constants.AttrTypeId.Defense)
    -- local baseDefense = characterAttrData:GetValue(Constants.AttrTypeId.Defense)
    self.Txt_DefenseValue.text = tostring(math.floor(checkNumber(nowDefense)))
    local deltaDefense = checkNumber(nowDefense - baseDefense)
    if deltaDefense == 0 then
        self.UISwitchTMP_defense.Status = 1
    elseif deltaDefense > 0 then
        self.UISwitchTMP_defense.Status = 2
    elseif deltaDefense < 0 then
        self.UISwitchTMP_defense.Status = 3
    end
end

---SetCharacterSpNode
---设置人物 Sp 信息
---@param spNow number 人物当前 Sp 点
---@param spMax number 人物 Sp 上限
function UIBattlingCharactorInfoDialog:SetCharacterSpNode()
    self:CleanSPNode()
    local spMax = self.curRoleView.maxUltraPoint -- 获取人物 Sp 数上限
    local spReal, spTemp = UIBattlingCtrlMgr:GetInstance():GetBattlingInfoDialog():GetCharacterSpInfo(self.characterId)
    local spRealAddTemp = spReal + spTemp
    -- self.Txt_SpValue.text = string.format("%d / %d", spNow, spMax)
    for i = 1, spMax do
        local spNode = GameObject.Instantiate(self.Img_SpPoint.gameObject, self.CharactorSpBgRoot)
        KTool.SetActive(spNode,true)
        local spSwitch = spNode.transform:Find("Img_SpPoint1"):GetComponent(typeof(UISwitchImage))
        if i <= spReal then
            spSwitch.Status = 1
        elseif i > spReal and i <= spRealAddTemp then
            spSwitch.Status = 1
            local img = spNode.transform:Find("Img_SpPoint1"):GetComponent(typeof(Image))
            img:DOFade(0, 0.85):SetEase(Ease.InQuart):SetLoops(-1, LoopType.Yoyo)
        else
            spSwitch.Status = 2
        end
        -- sp图片的底框
        local SImg_Frame = spNode.transform:Find("Img_SpFrame1"):GetComponent(typeof(UISwitchImage))
        SImg_Frame.Status = 2
        table.insert(self.listSPNode, spNode)
    end
end

function UIBattlingCharactorInfoDialog:CleanSPNode()
    if self.listSPNode then
        for i = #self.listSPNode, 1, -1 do
            KTool.SafeDelete(self.listSPNode[i].gameObject)
            self.listSPNode[i] = nil
        end
    end
    self.listSPNode = {}
end

function UIBattlingCharactorInfoDialog:SetRoleInfoSwitchList()
    self.arrIdsShowList = {}
    ---@type RoleView[]
    local roleViews = BattleViewMgr.roleViews -- 角色表现数据类
    for i, roleView in ipairs(roleViews) do
        local roleId = roleView.id
        local roleCamp = roleView.camp
        local conditions = BattleInfo:IsUserCamp(roleCamp) and (not roleView:IsDead()) and roleView.isPlayer
        if  conditions then
            table.insert(self.arrIdsShowList, roleView) -- 填充展示角色 id 列表
            if roleId == self.characterId then
                self.indexShow = table.getKey(self.arrIdsShowList, roleView.id) -- 设置初始展示角色Id
            end
        end
    end
    table.sort(self.arrIdsShowList,function(a, b) return a.id < b.id end) -- id 排序
    self.listRoleInfoNode = {}
    -- for i, roleData in ipairs(self.arrIdsShowList) do
    --     local goRoleInfo = KTool.Instantiate(self.BattleRoleIInfoGroup.gameObject, self.BattleRoleIInfoNode.gameObject)
    --     KTool.SetActive(goRoleInfo, true)
    --     local lbRoleInfo = KTool.GetComponent(goRoleInfo, typeof(LuaBehaviour))
    --     lbRoleInfo:Init()
    --     local ltRoleInfo = lbRoleInfo.Env
    --     ltRoleInfo:SetRoleInfoCharacterInfoDialog(roleData)
    --     ltRoleInfo:SetEventSwitchRoleInfo(function(roleId) 
    --         self:CloseAllSecondaryWindow()
    --         self:SetPanelInfo(roleId)
    --     end)
    --     table.insert(self.listRoleInfoNode, ltRoleInfo)
    -- end
end

function UIBattlingCharactorInfoDialog:SwitchRoleShow(id)
    local showIdEx = self.indexShow
    local showIdNow = id
    if isNull(self.listRoleInfoNode) then return end
    for i, roleNode in ipairs(self.listRoleInfoNode) do
        local roleId = roleNode.roleId
        if roleId == checkNumber(showIdEx) then
            roleNode:CancelRoleInfo()
        elseif roleId == checkNumber(showIdNow) then
            roleNode:SelectRoleInfo()
        else
            roleNode:AnimationDefault()
        end
    end
    self.indexShow = id
end

---SetPanelInfo
---设置 Panel 信息
---@param id integer @ RoleId
function UIBattlingCharactorInfoDialog:SetPanelInfo(id)
    UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_attribute)
    id = checkNumber(id)
    if id == checkNumber(self.characterId) then return end
    
    --BattleViewMgr:StartCharacterCamera(id, 0)
    self.characterId = id
    self.curRoleView = BattleViewMgr:FindRoleView(id)
    local isPlayer = self.curRoleView.isPlayer
    local v2RootHP
    local posXRootBuffList
    local isShowBG

    local isFriendCamp = BattleInfo:IsUserCamp(self.campType)
    local isSummonCreep = self.curRoleView.isSummonCreep

    KTool.SetActive(self.Root_EnemySkillList.gameObject, not isFriendCamp)
    KTool.SetActive(self.Root_CharacterSkillList.gameObject, isFriendCamp and isPlayer)
    -- KTool.SetActive(self.BattleRoleIInfoGroup.gameObject, isFriendCamp and isPlayer)
    KTool.SetActive(self.Root_Arrow.gameObject, isFriendCamp and not isSummonCreep)
    
    if isFriendCamp then
        if isPlayer then
            self:SetCharactorInfo(id) --- 设置 人物信息
            v2RootHP = ROOT_HP_A_POS.Player
            posXRootBuffList = ROOT_BUFF_LIST_POSX.Player
            isShowBG = true
        else
            self:SetSummonInfo(id)
            v2RootHP = ROOT_HP_A_POS.Enemy
            posXRootBuffList = ROOT_BUFF_LIST_POSX.Enemy
            isShowBG = false
        end
    else
        self:SetEnemyInfo(id) --- 设置 怪物信息
        v2RootHP = ROOT_HP_A_POS.Enemy
        posXRootBuffList = ROOT_BUFF_LIST_POSX.Enemy
        isShowBG = false
    end
    xTry(function()
        KTool.SetActive(self.TxtEnglishName.gameObject, isFriendCamp and isPlayer)
    end)
    --- 人物 Hp & Sp
    self:SetRootHpAndSp(id)
    -- self:SetRootHpAndSpPos(v2RootHP)
    self:SetRootBuffList(posXRootBuffList)
    self:SwitchRoleShow(id)

    -- 切换角色背景图花纹的颜色
    local elementType = self.curRoleView.roleData.attribute
    elementType = checkInt(elementType)
    if isPlayer then
        self.Switch_RoleBg0.Status = elementType
        self.Switch_RoleBg1.Status = elementType
    else
        self.Switch_EnemyBg.Status = elementType
    end
end

function UIBattlingCharactorInfoDialog:GetRoleBuffList()
    local characterBuffsPassive = {}
    local characterBuffOther = {}
    self.characterBuffList = {}
    self.curRoleView = clone(BattleViewMgr:FindRoleView(self.characterId))
    if isNull(self.curRoleView) then return end
    local characterBuffs = self.curRoleView.buffViewMgr.buffs
    for i = 1, #characterBuffs do
        local effectData = Core:GetBuffData(characterBuffs[i].data.id, characterBuffs[i].data.star, characterBuffs[i].data.lv) -- buff 数据
        if not IsNull(effectData) then
            local _showId = effectData.showIds[1] -- 子楠兄 Said ~~
            if Tools.isNullKey(_showId) then goto continue end
            local showEffectVo = UIBattlingTools.GetBuffDataPath(_showId)
            if isNull(showEffectVo) then goto continue end
            local showText = showEffectVo.showText
            if checkInt(showText) > 0 then goto continue end -- 配表规则 showText > 0 战中不显示
            local data = characterBuffs[i].data -- buff 配置表数据
            local buffIndexId = data.id  --- buffId
            local buffRow = CfUtils.GetCfLine(AutoIds.IdSetting573, buffIndexId) --- buff表 行数据
            if buffRow then
                local showDesc = parse_number(buffRow, "showDesc") --- 获取描述id
                if not IsNull(showDesc) and showDesc ~= 0 and showDesc ~= "0" then
                    local buffData = {
                        buffId = buffIndexId, -- buffId
                        showId = _showId, -- 效果表现Id iconPath
                        buffRemainNum = characterBuffs[i].remainRound,
                        effectStars = effectData.star,
                        effectLv = effectData.lv,
                        buffLayer = characterBuffs[i].layNum,
                        isClear = data.isClear, --是否能被清除
                        isUnique = data.isUnique, --是否唯一
                        isPassive = showEffectVo.passiveShow, --是否是被动技能
                        type = data.buffType,    -- buff的增减益类型
                        owner = characterBuffs[i].owner,    -- buff的拥有者
                        attacker = characterBuffs[i].attacker,    -- buff的施加者
                    }
                    local conditionPassive = showEffectVo.passiveShow and checkInt(showEffectVo.passiveShow) > 0
                    table.insert(conditionPassive and characterBuffsPassive or characterBuffOther, buffData)
                end
            end
            :: continue ::
        end
    end
    self.characterBuffList = table.link(characterBuffsPassive, characterBuffOther)

    -- 对buff按照中立，增益，减益的顺序进行排序
    table.sort(self.characterBuffList, function(a,b)
        return checkNumber(a.type) < checkNumber(b.type)
    end)
end

--- 刷新小buff界面
function UIBattlingCharactorInfoDialog:RefreshBuffListSmallNode()
    self:SetBuffListSmallState(checkBool(#self.characterBuffList > 0))
    -- KTool.SetActive(self.Root_BuffListSmall.gameObject, checkBool(#self.characterBuffList > 0))
    self:ClearBuffListSmallContent()
    self.listSmallBuffNode = {}
    local nodePath = Constants.UIBattlingObjPoolPrefabs.PATH_BUFFNODE_GO
    for i = 1, #self.characterBuffList do
        local buff = self.characterBuffList[i]
        local buffData = Core:GetBuffData(buff.buffId, buff.effectStars, buff.effectLv)
        local buffEffectId = buffData.showIds[1] -- 子楠兄 Said ~~ 
        local buffVo = UIBattlingTools.GetBuffDataPath(buffEffectId)
        --- 如 效果表现表 无法找到相应 buff 则不实例化数据
        if not IsNull(buffVo) then
            --- buffIconPath
            local buffIconPath = buffVo.icon --- 获取 buffIcon 资源路径
            if string.isEmpty(buffIconPath) then return end
            local buffRemainNum = buff.buffRemainNum -- Buff剩余回合数
            local buffLayer = buff.buffLayer -- buff 层数
            local buffTypeId = buff.buffId -- BuffTypeId

            local buffNode = UIBattlingTools.ReloadPoolObjGO(nodePath, self.Content_BuffListSmall)
            buffNode.transform.localScale = Vector3.New(2.5,2.5,1)
            table.insert(self.listSmallBuffNode, buffNode)
            local lbNode = GetLuaBehaviour(buffNode, BUFF_LIST_NODE_SMALL)
            if lbNode then
                lbNode:Init()
                local node = lbNode.Env
                node:SetShowNodeActiveState(true)
                node:InitBuffNode(buffTypeId, buffData.round, buffIconPath)
                node:SetNodeTxt(buffRemainNum, buffLayer) -- 设置 BuffNode 的 TXT
            end
        end
    end
end

function UIBattlingCharactorInfoDialog:ClearBuffListSmallContent()
    if self.listSmallBuffNode then
        for i = 1, #self.listSmallBuffNode do
            local buffNode = self.listSmallBuffNode[i]
            buffNode.transform.localScale = Vector3.New(1,1,1)
            -- UIBattlingTools.RecyclePoolObj(buffNode)
            local lbNode = GetLuaBehaviour(buffNode, BUFF_LIST_NODE_SMALL)
            if lbNode then
                local node = lbNode.Env
                node:RecycleBuffNode()
            end
        end
    end
end

--- 关闭小buff，打开buff详情
function UIBattlingCharactorInfoDialog:ShowBuffListDetail()
    self:SetBuffListSmallState(false)
    self:RefreshBuffListNode()
    self:SetActiveSecondaryWindowCloseBtn(true)
end

--- 关闭buff详情，打开小buff
function UIBattlingCharactorInfoDialog:ShowBuffListSmall()
    self:SetBuffListDetailState(false)
    self:RefreshBuffListSmallNode()
end

-- 暂时不要大小buff的切换了，直接常显大buff
function UIBattlingCharactorInfoDialog:ShowBuffList()
    self:RefreshBuffListNode()
end

--- 设置小buff列表的显示状态
---@param state boolean
function UIBattlingCharactorInfoDialog:SetBuffListSmallState(state)
    local cg = self.Root_BuffListSmall:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    cg.alpha = state and 1 or 0
    cg.blocksRaycasts = state
    cg.interactable = state
end

--- 设置详细buff列表的显示状态
---@param state boolean
function UIBattlingCharactorInfoDialog:SetBuffListDetailState(state)
    local cg = self.Root_CharactorBuffInfoList:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    cg.alpha = state and 1 or 0
    cg.blocksRaycasts = state
    cg.interactable = state
end

--- 刷新buff详情界面
function UIBattlingCharactorInfoDialog:RefreshBuffListNode()
    self:SetBuffListDetailState(checkBool(#self.characterBuffList > 0))
    -- KTool.SetActive(self.Root_CharactorBuffInfoList.gameObject, checkBool(#self.characterBuffList > 0))
    self:CleanBuffList()
    local isBuffTypeSplitShowed = {false, false, false}
    for i = 1, #self.characterBuffList do
        local buffData = self.characterBuffList[i]
        -- 显示buff类型的分割线
        if not isBuffTypeSplitShowed[buffData.type] then
            isBuffTypeSplitShowed[buffData.type] = true
            local splitLine = KTool.Instantiate(self.RootRoleBuffNode.gameObject, self.RT_SplitLine.gameObject)
            local SImg = splitLine.transform:GetChild(0):GetComponent(typeof(UISwitchImage))
            if isNotNull(SImg) then
                SImg.Status = buffData.type + 1
                KTool.SetActive(splitLine, true)
            end
        end
        -- 实例化buff节点
        local goDescriptionNode = KTool.Instantiate(self.RootRoleBuffNode.gameObject, self.UIBattlingBuffDesNode.gameObject)
        local lbNode = GetLuaBehaviour(goDescriptionNode, BUFF_LIST_NODE)
        if lbNode then
            lbNode:Init()
            local node = lbNode.Env
            node:SetNodeInfo(buffData)
        end
        KTool.SetActive(goDescriptionNode, true)
        table.insert(self.listBuffNode, goDescriptionNode)
    end

    self.coHandleScroll = cs_coroutine.start(function()
        for i = 1, 4 do cs_coroutine.yield_return() end
        if not IsNull(self.scrollContent) then
            if not IsNull(self.scrollContent.rect) then
                local valueSign = 835
                local contentHeight = checkNumber(self.scrollContent.rect.height)
                local isInteractive = checkBool(contentHeight >= valueSign)
                if not isNull(self.bgInteractive) then
                    self.bgInteractive.enabled = isInteractive
                end
                if not isNull(self.scrollBuffList) then
                    self.scrollBuffList.vertical = isInteractive
                end
            end
        end
    end)
    
end

function UIBattlingCharactorInfoDialog:CleanBuffList()
    if self.listBuffNode then
        for i = #self.listBuffNode, 1, -1 do
            KTool.SafeDelete(self.listBuffNode[i].gameObject)
            self.listBuffNode[i] = nil
        end
    end
    self.listBuffNode = {}
end

function UIBattlingCharactorInfoDialog:SetRootBuffList(posX)
    -- self.Root_CharactorBuffInfoList.anchoredPosition = Vector2.New(posX, self.Root_CharactorBuffInfoList.anchoredPosition.y)
    self:GetRoleBuffList()
    -- self:RefreshBuffListSmallNode()
    self:ShowBuffList()
end

function UIBattlingCharactorInfoDialog:SetSummonInfo(id)
    KTool.SetActive(self.Root_TopEnemyTeam.gameObject, true)
    KTool.SetActive(self.Root_EnemySkillList.gameObject, true)
    KTool.SetActive(self.Root_CharacterSkillList.gameObject, false)
    local skinId = self.curRoleView.roleData.skinId
    local skinVo = CardConfMgr:GetCardSkinBySkinId(skinId)
    local imgPath = skinVo.cardDrawing
    self.ImgEnemyHead:LoadSprite(imgPath)  -- 角色立绘 
    self.Txt_EnemyName.text = checkString(skinVo.name) -- 角色名
    local elementType = self.curRoleView.roleData.attribute
    self.Img_IconEnemyAttrType:LoadSprite(UIBattlingTools.GetElementTypeRawIcon(elementType))  -- 角色属性
    --- 怪物技能
    local roleData = UIBattlingDataMgr:GetCharactorDataById(id)
    self.listEnemySkills = nil
    self.listEnemySkills = {}
    local skillFinal = roleData.skillList["0"]
    for i = 1, table.count(roleData.skillList) do
        local index = i - 1
        if index > 0 then
            local skillData = roleData.skillList[checkString(index)]
            if skillData and skillData.skillId > 0 then
                table.insert(self.listEnemySkills, {id = skillData.skillId, star = skillData.star})
            end
        end
    end
    table.insert(self.listEnemySkills, 1, {id = skillFinal.skillId, star = skillFinal.star})
    self:EnemyListRefresh()
end

---SetEnemyInfo
---设置敌方角色 信息
---@param id number 敌方角色战场 Id
function UIBattlingCharactorInfoDialog:SetEnemyInfo(id)
    KTool.SetActive(self.Root_TopEnemyTeam.gameObject, true)
    local monsterData = UIBattlingDataMgr:GetRoleDataByRoleId(id)
    local monsterId = UIBattlingDataMgr:GetCharacterRefIdById(BattleInfo.otherCamp, id)
    local skinId = monsterData.skinId
    local skinVo = CardConfMgr:GetCardSkinBySkinId(skinId)
    local imgPath = skinVo.cardDrawing
    self.ImgEnemyHead:LoadSprite(imgPath) -- 角色头像
    --- 设置卡牌人物的详情信息
    local _setCardRoleInfo = function(cardId)
        local cardVo = CardConfMgr:GetCardByRefId(cardId)
        self.Img_IconEnemyAttrType:LoadSprite(UIBattlingTools.GetElementTypeRawIcon(cardVo.attributeType)) -- 角色属性
        self.listEnemySkills = nil
        self.listEnemySkills = {}
        local skillFinal = monsterData.skillList["0"]
        for i = 1, table.count(monsterData.skillList) do
            local index = i - 1
            if index > 0 then
                local skillData = monsterData.skillList[checkString(index)]
                if skillData and skillData.skillId > 0 then
                    table.insert(self.listEnemySkills, {id = skillData.skillId, star = skillData.star})
                end
            end
        end
        table.insert(self.listEnemySkills, 1, {id = skillFinal.skillId, star = skillFinal.star})
        -- 保存人型怪的信息，点击时生成提示面板
        self.enemyInfo = {
            roleId = id,
            cardId = cardId,
            monsterId = monsterId,
        }
    end
    local questId = UIBattlingDataMgr:GetQuestId()
    if UIBattleSettingMgr.UIType == UIBattleSettingMgr.EnumUIType.PVP
    or BattleInfo.BattleWithPlayerTeam(questId) then
        _setCardRoleInfo(monsterId)
    else
        self.curMonsterTypeVo = UIBattlingTools.GetMonsterVoById(monsterId)
        local roleType = self.curMonsterTypeVo.role -- 角色类型
        if roleType > 0 then -- 角色卡牌怪
            _setCardRoleInfo(self.curMonsterTypeVo.mode)
        else 
            --- 通常怪
            local enemyAttrType = UIBattlingDataMgr:GetCharacterAttriById(id) -- 角色属性
            self.Img_IconEnemyAttrType:LoadSprite(UIBattlingTools.GetElementTypeRawIcon(enemyAttrType))
            --local enemyName = self.curMonsterTypeVo.name -- 怪物名字
            --self.Txt_EnemyName.text = checkString(enemyName)
            --- 怪物技能
            self.listEnemySkills = nil
            self.listEnemySkills = {}
            local skill_1 = self.curMonsterTypeVo.atkSkill
            local skill_hit = self.curMonsterTypeVo.hitSkill
            if skill_1 > 0 then
                table.insert(self.listEnemySkills, {id = self.curMonsterTypeVo.atkSkill, star = 1})
            end
            for i = 2, 6 do
                local valueName = string.format("atkSkill%d", i)
                local skillId = self.curMonsterTypeVo[valueName]
                if skillId > 0 then
                    table.insert(self.listEnemySkills, {id = skillId, star = 1})
                end
            end
            if skill_hit > 0 then
                table.insert(self.listEnemySkills, 1,{id = skill_hit, star = 1})
            end
        end
    end
    xTry(function()
        local skinId = self.curRoleView.roleData.skinId
        local skinVo = CardConfMgr:GetCardSkinBySkinId(skinId)
        self.Txt_EnemyName.text = checkString(skinVo.name) -- 角色名
    end)
    self:EnemyListRefresh()
end

---SetCharactorInfo
---人物战场 id
---@param id number 人物战场 id
function UIBattlingCharactorInfoDialog:SetCharactorInfo(id)
    self.roleId = id
    local characterBattleData = UIBattlingDataMgr:GetCharactorDataById(id) -- 人物技能信息
    local cardId = characterBattleData.cardId -- 角色卡牌Id
    local playerCardId = characterBattleData.playerCardId
    self.cardId = cardId
    local questId = UIBattlingDataMgr:GetQuestId() -- 关卡id
    local levelVo = QuestConfMgr:GetInstance():GetQuestVoById(questId) -- 关卡Vo
    --- 关卡机器人信息
    local robVo
    if levelVo then
        robVo = BattleHelperConfMgr:GetInstance():GetMainLevelHelper(levelVo.petLineup, cardId)
    end
    KTool.SetActive(self.Root_TopPlayerTeam.gameObject, true)
    --- 人物星级
    KTool.SetActive(self.Root_CharatorStarsState.gameObject, true)
    self.characterUID = characterBattleData.playerCardId
    --- 人物星级
    local stars = checkNumber(characterBattleData.star)
    self:SetCharactorStarsState(stars or 0) -- 设置人物星级
    KTool.SetActive(self.Txt_CharatorLvNum.gameObject, true) -- 人物等级
    if not IsNull(stars) then
        local starVo = CardConfMgr:GetCardStarInfo(cardId, stars)
        local maxLevel = starVo.maxLevel
        local characterLv = characterBattleData.level
        --self.Txt_CharatorLvNum.fontSize = (checkNumber(characterLv) >= maxLevel and stars >= 6) and 30 or 60
        if maxLevel then
            self.Txt_CharatorLvNum.text = (checkNumber(characterLv) >= maxLevel and stars >= 6) and "MAX" or checkString(characterLv)
        else
            -- 最大等级咋还能没了，是要突破天际了吗
            self.Txt_CharatorLvNum.text = checkString(characterLv)
        end
    end
    --- 人物立绘
    local skinId = characterBattleData.skinId
    local skinVo = CardConfMgr:GetCardSkinBySkinId(skinId)
    local imgPath = skinVo.cardDrawing
    self.ImgCharactor:LoadSprite(imgPath)
    --- 人物职业信息
    local cardVo = CardConfMgr:GetCardByRefId(cardId)
    self.TxtPlayerName.text = checkString(cardVo.descr)
    self.Img_IconCharactorBattleType:LoadSprite(UIBattlingTools.GetCareerIconCommon(cardVo.career, true))
    --- 人物属性信息
    local roleElementType = UIBattlingDataMgr:GetCharacterAttriById(id) -- 人物属性信息
    --self.Img_IconFriendAttrType:LoadSprite(CardUtils.GetGoodsCardAttrIconByCardAttrType(roleElementType))
    self.Img_IconFriendAttrType:LoadSprite(UIBattlingTools.GetAttriTypeIcon(roleElementType, true))
    --- 人物角色姓名
    local charactorName = cardVo.name
    self.Txt_FriendName.text = checkString(charactorName)
    xTry(function()
        local characterId = cardVo.characterId
        local roleVo = checkTable(CfUtils.GetCfVo(AutoIds.IdSetting19, "RolesVo", checkString(characterId)))
        local roleEnglishName = checkString(roleVo.englishName)
        if not IsNull(self.TxtEnglishName) then
            self.TxtEnglishName.text = roleEnglishName
        end
    end)
    if IsNull(characterBattleData.skillList) then return end
    self.characterSkillCardDataList = characterBattleData.skillList
    self.btnSkill_1:ReloadCardInfo(self.characterSkillCardDataList["0"].skillId, self.characterSkillCardDataList["0"].skillLv, id, 0)
    self.btnSkill_2:ReloadCardInfo(self.characterSkillCardDataList["1"].skillId, self.characterSkillCardDataList["1"].skillLv, id, 1)
    self.btnSkill_3:ReloadCardInfo(self.characterSkillCardDataList["2"].skillId, self.characterSkillCardDataList["2"].skillLv, id, 2)
    --- GiftSkill ---
    -- local _GetCardAwakenVo = function (pCardId, finalSkillLevel)
    --     -- local cardAwakenVo
    --     -- finalSkillLevel = checkNumber(finalSkillLevel)
    --     -- local talents = CardConfMgr:GetCardAwakenVosByCardId(pCardId)
    --     -- for i, awakenVo in ipairs(talents) do
    --     --     local openLevel = checkNumber(awakenVo.openLevel)
    --     --     if openLevel == finalSkillLevel then
    --     --         cardAwakenVo = awakenVo
    --     --         break
    --     --     end
    --     -- end
    --     -- return cardAwakenVo
    --     CardConfMgr
    -- end
    local skillId = self.characterSkillCardDataList["0"].skillId --TODO 后面名字要用 talentVo 里的
    local skillLv = characterBattleData.awakeningLevel
    -- local awakenVo = _GetCardAwakenVo(cardId, 1) --获取 CardAwakenVo lv为1
    ---@type CardProgressionSkillUtils
    local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
    local talentVo = CardProgressionSkillUtils.GetTalentVo(cardId, characterBattleData.awakeningLevel or 1)
    self.btnSkill_4:SetGiftSkillInfo(skillId, skillLv, id, talentVo)
end

---SetCharactorStarsState
---设置人物星级显示
---@param value number 人物星级数据
function UIBattlingCharactorInfoDialog:SetCharactorStarsState(value, cardDojo)
    local characterStarsList = {}
    for i = 1, checkNumber(self.Root_CharatorStarsState.childCount), 1 do
        local uiSwitch = self.Root_CharatorStarsState:GetChild(i - 1).gameObject:GetComponent(typeof(UISwitchImage))
        table.insert(characterStarsList, uiSwitch)
    end
    local count = isNull(cardDojo) and -1 or 0
    local star  = checkNumber(value)
    for i = 1, Constants.CardMaxStar, 1 do
        local status = 1
        if i <= count then
            status = 3
        elseif i <= star then
            status = 2
        end
        characterStarsList[i].Status = status
    end
end

function UIBattlingCharactorInfoDialog:InitShowCharacterList(camp)
    self.arrIdsShowList = {} -- 展示 id 集合
    self.indexShow = nil -- 展示人物的 index
    local roleViews = BattleViewMgr.roleViews -- 角色表现数据类
    for i, roleView in ipairs(roleViews) do
        local roleId = roleView.id
        local roleCamp = roleView.camp
        if roleCamp == camp and (not roleView:IsDead()) then
            table.insert(self.arrIdsShowList, roleView.id) -- 填充展示角色 id 列表
            if roleId == self.characterId then
                self.indexShow = table.getKey(self.arrIdsShowList, roleView.id) -- 设置初始展示角色Id
            end
        end
    end
    table.sort(self.arrIdsShowList,function(a, b) return a < b end) -- id 排序
end

---SwitchIndexShow
---切换显示人物
---@param forward integer @ 方向 -1: 左 ； 1: 右
function UIBattlingCharactorInfoDialog:SwitchIndexShow(forward)
    self.characterBuffList = nil
    self.characterBuffList = {}
    if #self.arrIdsShowList <= 1 then return end
    if forward == 1 then
        self.indexShow = (self.indexShow == #self.arrIdsShowList) and 1 or self.indexShow + 1
    elseif forward == -1 then
        self.indexShow = (self.indexShow == 1) and #self.arrIdsShowList or self.indexShow - 1
    end
    self:SetPanelInfo(self.arrIdsShowList[self.indexShow])
end

function UIBattlingCharactorInfoDialog:GetPlayerRoleSkillDataVo(index)
    for i, skillCard in pairs(self.listBtnSkills) do
        if index == skillCard:GetSkillIndex() then
            return skillCard.dataVo
        end
    end
end

--- 激活关闭刺激窗口的按钮
function UIBattlingCharactorInfoDialog:SetActiveSecondaryWindowCloseBtn(state)
    KTool.SetActive(self.Btn_CloseDesc.gameObject, state)
end

--- 关闭所有二级窗口
function UIBattlingCharactorInfoDialog:CloseAllSecondaryWindow()
    -- self:ShowBuffListSmall()    -- 隐藏buff详情，显示小buff
    self:HideAttributeInfo()    -- 隐藏属性详情
    self:SetActiveSecondaryWindowCloseBtn(false)
end

--- 显示属性详情
function UIBattlingCharactorInfoDialog:ShowAttributeInfo()
    self:SetActiveSecondaryWindowCloseBtn(true)
    KTool.SetActive(self.Root_DescGroup, true)  -- TODO 改成canvasGroup控制显示和隐藏
    self:RefreshAttributeInfo()
end

--- 隐藏属性详情
function UIBattlingCharactorInfoDialog:HideAttributeInfo()
    KTool.SetActive(self.Root_DescGroup, false) -- TODO 改成canvasGroup控制显示和隐藏
end

--- 刷新属性详情
function UIBattlingCharactorInfoDialog:RefreshAttributeInfo()
    self.attrInfoList = {}
    -- 添加属性节点
    local attr = self.curRoleView.attr
    local basicAttrs  = CardConfMgr:GetBasicAttrs()
    for i, basicVo in ipairs(basicAttrs) do
        local attrId = basicVo.id
        local baseValue = attr:GetOriginValue(attrId)
        local addValue = attr:GetValue(attrId) - baseValue
        local attrInfo = {
            nodeType = 1,
            attrId = attrId,
            baseValue = baseValue,
            addValue = addValue,
            basicVo = basicVo,
        }
        table.insert(self.attrInfoList, attrInfo)
    end
    -- 添加星级解锁的被动节点
    local roleView = BattleViewMgr:FindRoleView(self.roleId)
    local star = roleView.roleData.star
    CardConfMgr:WalkAllStarEffect(self.cardId, function(vo, index)
        if star >= vo.star then
            local giftId = vo.initOpenAbility
            local desc, name, talentVo = CardProgressionSkillUtils.GetCardTalentDescById(giftId)
            local giftInfo = {
                nodeType = 2,
                giftId = giftId,
                name = localize("_num_星觉醒效果", {_num_ = vo.star}),
                desc = desc,
                talentVo = talentVo,
            }
            table.insert(self.attrInfoList, giftInfo)
        end
    end)
    -- 添加一个空节点，占位用
    table.insert(self.attrInfoList, {nodeType = 3})
    -- print("[角色]", table.dump(self.attrInfoList, nil, 2))
    self:RefreshAttributeLoopListView(#self.attrInfoList)
end

function UIBattlingCharactorInfoDialog:ClearAttrNodes()
    if self.listAttrNode then
        for i = #self.listAttrNode, 1, -1 do
            KTool.SafeDelete(self.listAttrNode[i].gameObject)
            self.listAttrNode[i] = nil
        end
    end
    self.listAttrNode = {}
end

---刷新属性列表
function UIBattlingCharactorInfoDialog:RefreshAttributeLoopListView(maxNum)
    if not self.AttrLoopListView.IsListViewInit then
        self.AttrLoopListView:InitListView(maxNum, Bind(self, self.OnAttrGetItemByIndex))
    else
        GameUtils.ReloadData(self.AttrLoopListView, maxNum)
    end
end

function UIBattlingCharactorInfoDialog:OnAttrGetItemByIndex(loopListView, index)
    if index < 0 then
        return nil
    end

    local luaIndex = index + 1
    local attrInfo = self.attrInfoList[luaIndex]
    local cell
    if attrInfo.nodeType == 1 then
        -- 属性节点
        cell = loopListView:NewListViewItem("Cell1")
        local LB_cell = GetLuaBehaviour(cell.transform:GetChild(0).gameObject, CULTIVATE_ATTR_NODE)
        if not cell.IsInitHandlerCalled then
            cell.IsInitHandlerCalled = true
            LB_cell:Init()
        end
        if not IsNull(LB_cell) then
            local ltAttrNode = LB_cell.Env
            ltAttrNode:RefreshUI(attrInfo.basicVo, attrInfo.baseValue, attrInfo.addValue, attrInfo.basicVo.isConversion)
            ltAttrNode:AddAttrClickEvent()
        end
    elseif attrInfo.nodeType == 2 then
        -- 升星被动节点
        cell = loopListView:NewListViewItem("Cell2")
        local LB_cell = GetLuaBehaviour(cell.gameObject, CULTIVATE_STAR_UP_SKILL_DESC_NODE)
        if not cell.IsInitHandlerCalled then
            cell.IsInitHandlerCalled = true
            LB_cell:Init()
        end
        if not IsNull(LB_cell) then
            local LT_Node = LB_cell.Env
            LT_Node.TextDesc.text = attrInfo.desc

            if LT_Node.TxtName then
                LT_Node.TxtName.text = attrInfo.name
            end
        
            local iconPath = attrInfo.talentVo.iconPath
            if LT_Node.ImgIcon then
                LT_Node.ImgIcon:LoadSprite(iconPath)
            end
        end
        -- 升星节点有动态尺寸，需要立即重算尺寸，不然会导致layout计算出错
        local rt = cell.gameObject:GetComponent(typeof(RectTransform))
        CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rt)
    elseif attrInfo.nodeType == 3 then
        cell = loopListView:NewListViewItem("Cell3")
        if not cell.IsInitHandlerCalled then
            cell.IsInitHandlerCalled = true
        end
    end

    return cell
end

--- 猫球说明界面
function UIBattlingCharactorInfoDialog:SetSkillCatPanelInfo(roleId)
    local roleView = BattleViewMgr:FindRoleView(roleId)
    local skillCatView = BattleViewMgr:GetSkillCat(roleView.camp, 2)
    if isNull(skillCatView) then
        KTool.SetActive(self.RT_CatBallDescGroup, false)
        return
    end
    KTool.SetActive(self.RT_CatBallDescGroup, true)
    local LB_Desc = GetLuaBehaviour(self.RT_CatBallDescGroup.gameObject, "Game.UI.UIBattling.UIBattlingSkillCatDescGroup")
    LB_Desc.Env:SetPanelInfo(skillCatView)
end

--- 设置情绪共鸣描述
function UIBattlingCharactorInfoDialog:SetEmotionBonusDesc(roleId)
    local roleView = BattleViewMgr:FindRoleView(roleId)
    local playerId = roleView.playerId
    if isNull(playerId) then return end

    local echos = BattleViewMgr.initData.teamEchos
    if isNull(echos) then return end

    local bonusIds = echos[tostring(playerId)]
    if isNull(bonusIds) then return end
    if table.count(bonusIds) == 0 then return end

    local skillCatView = BattleViewMgr:GetSkillCat(roleView.camp, 2)
    if isNull(skillCatView) then
        local localPos = self.TrammelsDescGroup.localPosition
        self.TrammelsDescGroup.localPosition = Vector3.New(localPos.x, localPos.y + 200, localPos.z)
    end

    table.sort(bonusIds, function(a,b)
        return a < b
    end)

    -- 拼接共鸣的描述
    local count = table.count(bonusIds)
    local desc = ""
    for i, id in ipairs(bonusIds) do
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting6221, "LineupBonusVo", id)
        desc = desc .. vo.name
        if i < count then
            desc = desc .. "\n"
        end
    end

    -- 换算switchId
    local switchId = self:GetIconSwitchId(bonusIds)
    local iconPath = Constants.LineupBonusIconPath[switchId]
    
    KTool.SetActive(self.TrammelsDescGroup, true)

    local lt = GetLuaBehaviour(self.TrammelsDescGroup.gameObject, "Game.UI.UIBattling.UIBattlingLineupBonusDescGroup").Env
    lt:Refresh(desc, iconPath)

end

--- 换算switchId
---@param bonusIds any
function UIBattlingCharactorInfoDialog:GetIconSwitchId(bonusIds)
    local switchId = 1

    local total = 0
    for i, id in ipairs(bonusIds) do
        total = total + id
    end
    if table.isContain(bonusIds, 4) then
        local n = total - 4
        switchId = n + 1
    else
        local n = total
        switchId = n + 4
    end
    return switchId
end

return UIBattlingCharactorInfoDialog