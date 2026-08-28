-- UI中常用的脚本引用定义成全局的方便使用
local CS                   = CS
local KTool                = CS.Engine.Lib.KTool
local _GameObject          = CS.UnityEngine.GameObject
local GeometryUtility      = CS.UnityEngine.GeometryUtility
---@type Game.Native.URP.URPCameraController
local URPCameraController  = CS.Game.Native.URP.URPCameraController
local UIModule             = CS.Engine.UI.UIModule
local ResourceModule       = CS.Engine.Modules.ResourceModule
local DOTween              = CS.DG.Tweening.DOTween
local Yielders             = CS.Engine.Lib.Yielders

local cs_coroutine         = require "XLua.cs_coroutine"

---@class UICommonUtils
local UICommonUtils = {}

local CinemachineBrainType       = typeof(CS.Cinemachine.CinemachineBrain)
local FaceForwardType            = typeof(CS.FaceForward)

local CardHeadNodePath           = "Game.Behaviours.CardHeadNode"
local GoodsListEnvPath           = "Game.Behaviours.CommonGoodsList"
local GoodsListLightEnvPath      = "Game.Behaviours.CommonGoodsListLight"
local CommonBtnConsumePopEnvPath = "Game.UI.Common.CommonBtnConsumePop"
local CommonWebImagePath         = "Game.Behaviours.CommonWebImage"
local UITeamMembersNodeLuaPath    = "Game.UI.FightTeam.UITeamMembersNode.UITeamMembersNode"

local CardSkillAttackAttrColor = {
    [-1] = "#ffffff",
    [0] = "#949494",
    [Constants.CardAttrType.Fire] = "#ff1753",
    [Constants.CardAttrType.Wood] = "#38cd46",
    [Constants.CardAttrType.Water] = "#4573eb",
    [Constants.CardAttrType.Light] = "#fbbd2c",
    [Constants.CardAttrType.Dark] = "#d73bff",
}

local CardSkillAttackAttrName = {
    [Constants.SkillLabel.Buff] = "battle_icon_buff",
    [Constants.SkillLabel.Attack] = "battle_icon_attack",
    [Constants.SkillLabel.Debuff] = "battle_icon_debuff",
    [Constants.SkillLabel.Heal] = "battle_icon_treatment",
    [Constants.SkillLabel.AttackAndBuff] = "battle_icon_buff_attack",
    [Constants.SkillLabel.AttackAndDebuff] = "battle_icon_debuff_attack",
    [Constants.SkillLabel.Summoners] = "battle_icon_summon",
}

local SkillTypeAOEIconName = {
    [Constants.SkillLabel.Buff]   = "battle_icon_all_buff",
    [Constants.SkillLabel.Attack] = "battle_icon_all_attack",
    [Constants.SkillLabel.Debuff] = "battle_icon_all_debuff",
    [Constants.SkillLabel.Heal]   = "battle_icon_all_treatment",
    [Constants.SkillLabel.AttackAndBuff]   = "battle_icon_all_buffattack",
    [Constants.SkillLabel.AttackAndDebuff] = "battle_icon_all_debuffattack",
}


--清除
function UICommonUtils:ClearTb(tb)
    printInfo("--UICommonUtils:ClearTb--")
    if tb ~= nil then
        for i, v in pairs(tb) do
            if type(v) == "table" then
                self:ClearTb(tb)
            else
                if v ~= nil then
                    v = nil
                end
            end
        end
        --tb = nil
    end
end

--实例化Item
function UICommonUtils:InitTransform(t)
    if t == nil then
        printInfo(" ----t is nil----")
    end

    t.localPosition = Vector3.zero
    t.localRotation = Quaternion.identity
    t.localScale = Vector3.one
end

function UICommonUtils:CreateItem(prefab, parent, pool)
    if pool == nil then
        printInfo(" ----pool is nil----")
    end

    local go = _GameObject.Instantiate(prefab)
    KTool.SetActive(go, false)
    local t = go.transform
    t:SetParent(nil)
    t.localPosition = Vector3.zero
    t.localRotation = Quaternion.identity
    t.localScale = Vector3.one

    table.insert(pool, go)

    return go
end

function UICommonUtils:AddItem(prefab, parent, pool, usetb)
    if pool == nil then
        printInfo(" ----pool is nil----")
    else
        local len = table.length(pool)
        printInfo(" ----pool is ----" .. len)
    end

    if usetb == nil then
        printInfo(" ----usetb is nil----")
    end

    local item = nil
    local count = table.count(pool)
    if count > 0 then
        item = pool[1]
        table.remove(pool, 1)
        table.insert(usetb, item)
    else
        item = self:CreateItem(prefab, parent, usetb)
    end

    if item == nil then
        printInfo(" ----item is nil----")
    end

    item:SetParent(parent)
    self:InitTransform(item.transform)
    KTool.SetActive(item, true)

    return item
end

function UICommonUtils:RemoveItem(index, item, pool, usetb)
    local t = item.transform
    KTool.SetActive(t, false)
    t:SetParent(nil)
    table.remove(usetb, index)
    table.insert(pool, item)
end

function UICommonUtils:ClearItem(pool, usetb)
    self:ClearTb(pool)
    self:ClearTb(usetb)
end

function UICommonUtils:GetSkillLabelNameByType(labelType)
    labelType = checkNumber(labelType)
    local name = ""
    if labelType == Constants.SkillLabel.Buff then
        name = localize("祝福")
    elseif labelType == Constants.SkillLabel.Debuff then
        name = localize("诅咒")
    elseif labelType == Constants.SkillLabel.Attack then
        name = localize("进攻")
    elseif labelType == Constants.SkillLabel.Heal then
        name = localize("治疗")
    else
        name = localize("sp技能")
    end
    return name
end

function UICommonUtils:GetCardSkillAttrIcon(showLabel, attributeId, isSmall, isAoe)
    local color = CardSkillAttackAttrColor[-1]

    local condition = showLabel >= Constants.SkillLabel.Buff and showLabel <= Constants.SkillLabel.AttackAndDebuff and checkNumber(isAoe) > 0
    local name = condition and SkillTypeAOEIconName[showLabel] or CardSkillAttackAttrName[showLabel]
    name = checkString(name)

    if showLabel == Constants.SkillLabel.Attack then
        color = self:GetCardSkillAttackAttrIconColor(attributeId)
    end

    if string.isEmpty(name) then return "", color end
    local path = isSmall and string.format("UIAtlas/Cultivate/AttributeIcon/%s_2.png", name) or string.format("UIAtlas/Cultivate/AttributeIcon/%s.png", name)
    return path, color
end

--- 根据技能星级获取技能的showLable
---@param showLable any
---@param star any
function UICommonUtils:GetSkillShowLabelWithStar(showLable, star)
    if isTable(showLable) and #showLable > 0 then
        for i = checkInt(star), 1, -1 do
            local label = showLable[i]
            if not isNull(label) then
                return checkInt(label)
            end
        end
    end
    return 2
end

function UICommonUtils:GetCardSkillAttrBg(skillStar)
    return string.format("UIAtlas/Cultivate/AttributeIcon/battle_img_skill_buff_bg_%s.png", skillStar or 1)
end

--- GetNormalSkillIcon
---@param skillType integer 技能类型（1普攻2高级技能3大招4通用的第三方技能，比如合卡技）
---@param skillStar integer 技能星级
function UICommonUtils:GetNormalSkillIcon(skillType, skillStar)
    local name = skillType == Constants.CardSkillType.GeneralSkill and "a" or "b"
    return string.format("UIAtlas/Cultivate/AttributeIcon/skill_img_%s_%s.png", name, skillStar or 1)
end


function UICommonUtils:GetCardSkillAttackAttrIconColor(attributeId)
    return CardSkillAttackAttrColor[checkNumber(attributeId)] or CardSkillAttackAttrColor[-1]
end

function UICommonUtils.GetMonsterAttributeIcon(attribute)
    return string.format("Arts/icons/levelgain/common_ico_element_l_%d.png", checkInt(attribute))
end

function UICommonUtils.GetIsShowLevelGuide(data)
    local newbieGuideTaskCurrentId = checkNumber(data.newbieGuideTaskCurrentId)
    if newbieGuideTaskCurrentId <= 0 then
        return false
    end
    ---@type LevelGuideVo
    local levelGuideVo = CfUtils.GetCfVo(AutoIds.IdSetting122, "LevelGuideVo", newbieGuideTaskCurrentId)
    local isUnlock = GameUtils.IsUnlockedSingle(levelGuideVo.unlockType, levelGuideVo.unlockNum, levelGuideVo.unlockId)
    if isUnlock == false then
        return isUnlock
    end

    local newbieGuideTaskReceived = data.newbieGuideTaskReceived
    local isReceive = false
    for i, v in pairs(newbieGuideTaskReceived) do
        if checkNumber(v) == newbieGuideTaskCurrentId then
            isReceive = true
            break
        end
    end

    return not isReceive
end

--- PlayButtonAnimByName
---@param transform UnityEngine.Transform
---@param name string 动画名称 可选  默认: "UI_Common_ButtonPressed"
function UICommonUtils.PlayButtonAnimByName(transform, name)
    name = name or "UI_Common_ButtonPressed"
    UICommonUtils.PlayAnimation(transform, name)
end

--- PlayAnimation
---@param transform UnityEngine.Transform
---@param name string 动画名称 可选 没有动画名称 则播第一个动画
function UICommonUtils.PlayAnimation(transform, name)
    local animation = transform:GetComponent(typeof(CS.UnityEngine.Animation))
    if not isNull(animation) then
        for _, animationState in pairs(animation) do
            if name then
                if animationState.name == name then
                    animation:Play(name)
                    break
                end
            else
                animation:Play(animationState.name)
                break
            end
        end

    end
end

--- FillCommonGoodsList
---@param goodsListNode UnityEngine.RectTransform      CommonGoodsList          
---@param rewards table
---@param canGet boolean 可领取特效
---@param isGet boolean 已领取蒙版
---@param isShowNum boolean 显示奖励数量，不传默认显示
function UICommonUtils.FillCommonGoodsList(goodsListNode, rewards, canGet, isGet, isShowNum, isCheckNum, isShowGoodsTips)
    if rewards == nil then return end
    ---@type CommonGoodsList
    local rewardEnv = CfUtils.GetLuaScr(goodsListNode, GoodsListEnvPath)
    if not isNull(rewardEnv) then
        rewardEnv:FreshBaseUI(rewards, canGet, isGet, isShowNum, isCheckNum, isShowGoodsTips)
    end

end

--- FillCommonGoodsListLight
---@param goodsListNode UnityEngine.RectTransform      CommonGoodsListLight          
function UICommonUtils.FillCommonGoodsListLight(goodsListNode, ...)
    ---@type CommonGoodsListLight
    local rewardEnv = CfUtils.GetLuaScr(goodsListNode, GoodsListLightEnvPath)
    if not isNull(rewardEnv) then
        rewardEnv:FreshBaseUI(...)
    end

end

--- FillQuestCommonGoodsList
---@param goodsListNode UnityEngine.RectTransform      CommonGoodsList          
---@param canGet boolean 可领取特效
---@param isGet boolean 已领取蒙版
---@param isShowNum boolean 显示奖励数量，不传默认显示
function UICommonUtils.FillQuestCommonGoodsList(goodsListNode, questId, canGet, isGet, isShowNum)
    local rewards = RewardConfMgr:GetInstance():GetTeamShowRewardDataAndHandleSpecialType(questId)
    UICommonUtils.FillCommonGoodsList(goodsListNode, rewards, canGet, isGet, isShowNum)

end

--- FillCommonBtnConsumePop
---@param node UnityEngine.RectTransform      CommonBtnConsumePop   
---@param goodsId number           道具id
---@param consumeNum number        道具消耗
---@param isNotChangeColor boolean 是否不改变颜色
---@param defaultMode number 1:white 2:black
function UICommonUtils.FillCommonBtnConsumePop(node, goodsId, consumeNum, isNotChangeColor, defaultMode)
    ---@type CommonBtnConsumePop
    local consumeEnv = CfUtils.GetLuaScr(node, CommonBtnConsumePopEnvPath)
    if not isNull(consumeEnv) then
        consumeEnv:RefreshUI(goodsId, consumeNum, isNotChangeColor, defaultMode)
    end
end

--- FillCommonBtnConsumePopByConsumes
---@param node UnityEngine.RectTransform      CommonBtnConsumePop   
---@param consumeList {goodsId:number, num?:number, consumeNum?:number, goodsNum?:number}[]       道具消耗列表
---@param isNotChangeColor boolean 是否不改变颜色
---@param defaultMode number 1:white 2:black
function UICommonUtils.FillCommonBtnConsumePopByConsumes(node, consumeList, isNotChangeColor, defaultMode)
    ---@type CommonBtnConsumePop
    local consumeEnv = CfUtils.GetLuaScr(node, CommonBtnConsumePopEnvPath)
    if not isNull(consumeEnv) then
        consumeEnv:RefreshUIByConsumeList(consumeList, isNotChangeColor, defaultMode)
    end
end

--- FillCardHeadNode
---@param node UnityEngine.RectTransform
---@param viewType number 1: FreshNode 2: FreshNodeByCardVo 3: FreshCardHelperInfo 4: FreshBaseUI 5: FreshMonsterUI
function UICommonUtils.FillCardHeadNode(node, viewType, cb, ...)
    ---@type CardHeadNode
    local env = CfUtils.GetLuaScr(node, CardHeadNodePath)
    if isNull(env) then return end
    if viewType == 1 then
        env:FreshNode(...)
    elseif viewType == 2 then
        env:FreshNodeByCardVo(...)
    elseif viewType == 3 then
        env:FreshCardHelperInfo(...)
    elseif viewType == 4 then
        env:FreshBaseUI(...)
    elseif viewType == 5 then
        env:FreshMonsterUI(...)
    end

    if cb then
        env:SetCallBack(cb)
    end
end

function UICommonUtils.FillUITeamMemberNode(node, isCustom, ...)
    ---@type UITeamMembersNode
    local env = CfUtils.GetLuaScr(node, UITeamMembersNodeLuaPath)
    if isNull(env) then return end
    if isCustom then
        env:RefreshCardCustom(...)
    else
        env:Refresh(...)
    end
end

--- GetFaceForward
---@param roleGo UnityEngine.GameObject | UnityEngine.Transform
function UICommonUtils.GetFaceForward(roleNode)
    local faceForwards = roleNode.gameObject:GetComponentsInChildren(FaceForwardType)
    for i = 1, faceForwards.Length do
        local faceForward = faceForwards[i - 1]
        if not isNull(faceForward.TargetTransform) then
            return faceForward
        end
    end
    return nil
end

--- IsObjectVisible
--- 相机能否看到该对象
---@param camera UnityEngine.Camera 相机
---@param bounds UnityEngine.Bounds 对象边界
function UICommonUtils.IsObjectVisible(camera, bounds)
    local planes = GeometryUtility.CalculateFrustumPlanes(camera)
    return GeometryUtility.TestPlanesAABB(planes, bounds)
end

--- WaitBrainBlendingComplete
--- 等待虚拟相机Brain 混合完成
function UICommonUtils.WaitBrainBlendingComplete()
    cs_coroutine.yield_return()
    local mainCamera = URPCameraController.Instance.mainCamera
    local brain = mainCamera.gameObject:GetComponent(CinemachineBrainType)
    while brain.IsBlending do
        cs_coroutine.yield_return()
    end
end

--- 获取虚拟相机大脑 默认混合设置
---@param go UnityEngine.GameObject
function UICommonUtils.GetBrainSettingByGo(go)
    ---@type Cinemachine.CinemachineBrain
    local brain = go:GetComponent(CinemachineBrainType)
    if not isNull(brain) then
        return brain.m_DefaultBlend
    end
    return go
end


--- 动画经验升级
function UICommonUtils.AnimateUpgrade(expInfo, func_getNextLvExpData, skipAnimationTime, defaultAnimationTime, delayTime, txt_lv, lvFormat, txt_expNum, sliderPro_exp, out_coGroup)
    local animationTime = defaultAnimationTime
    local fromLv = checkInt(expInfo.oldLv)
    local toLv = checkInt(expInfo.newLv)
    local fromExp = checkInt(expInfo.oldExp)
    local toExp = 16
    out_coGroup.co = cs_coroutine.start(function()
        if (not isNull(delayTime)) and delayTime > 0 then
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(delayTime))
        end
        while fromLv <= toLv do
            animationTime = fromLv == toLv and defaultAnimationTime or skipAnimationTime
            if not isNull(txt_lv) then
                if type(lvFormat) == "function" then
                    txt_lv.text = string.format(lvFormat(fromLv), fromLv)
                else
                    txt_lv.text = string.format(lvFormat or "Lv.%d", fromLv)
                end
            end
            
            local expData = func_getNextLvExpData(fromLv)
            toExp = fromLv < toLv and expData.totalExp or checkInt(expInfo.newExp)
    
            local lastTotal = expData.totalExp - expData.exp
            local showFromExp = fromExp - lastTotal
            local showToExp = toExp - lastTotal
            
            if not isNull(txt_expNum) then
                out_coGroup.tweener = DOTween.To(function(value)
                    txt_expNum.text = string.format("<color=#f953b1>%d</color>/%d", Mathf.Floor(value), expData.exp)
                end, showFromExp, showToExp, animationTime)
            end
            
            if not isNull(sliderPro_exp) then
                local fromProgress = showFromExp / expData.exp
                local toProgress = showToExp / expData.exp
                sliderPro_exp:SetProgress(fromProgress)
                sliderPro_exp:LerpProgress(toProgress, animationTime)
            end
            -- print("animate upgrade " .. tostring(fromLv) .. " " .. tostring(showFromExp) .. " " .. tostring(showToExp) .. "  " .. tostring(fromProgress) .. " " .. tostring(toProgress))
    
            fromLv = fromLv + 1
            fromExp = toExp

            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(animationTime))
        end
        out_coGroup.co = nil
    end)
end

function UICommonUtils.ShowAttributeTips(targetNode, ...)
    UICommonUtils.ShowTips("Prefabs/Common/CommonTipsBoardAttribute.prefab", "Game.UI.Common.CommonTipsBoardAttribute", targetNode, false, false, ...)
end
--
function UICommonUtils.ShowTips(prefabPath, envPath, targetNode, isUpDown, isInTheCenter, ...)
    local data = {...}
    local isShowName = false
    local t = SafeUnpack(data)
    if isSet(t, "nightCat") then
        isShowName = true
    end
    local callback = function (go)
        local isNotNull = isNotNull
        if isNotNull(go) and isNotNull(targetNode) then
            ---@type CommonTipsBoardAttribute
            local env = CfUtils.GetLuaScr(go, envPath)
            if isNotNull(env) then
                -- 刷新提示板内容
                if isShowName then
                    env:FreshBoardByNameWithDescription(t.name, t.descr)
                else
                    env:FreshUI(SafeUnpack(data))
                end
                --- 修正一次坐标位置
                env:FixBoardPosition(targetNode, isUpDown, isInTheCenter)
            end
        end
    end
    
    ResourceModule.LoadGameObjectAsync(prefabPath, callback, true, UIModule.RootCanvas.transform)
end

function UICommonUtils.LoadGameObject(prefabPath, callback, parent)
    ResourceModule.LoadGameObjectAsync(prefabPath, callback, true, parent or UIModule.RootCanvas.transform)
end


function UICommonUtils.ShowCommonSkipButton(subEnvPath, ...)
    local prefabPath = "Prefabs/Common/CommonSkipButton.prefab"
    local envPath    = "Game.Behaviours.CommonSkipButton"
    CfUtils.ConditionAppend("ShowCommonSkipButton")
    local data = {...}
    return CoStart(function() 
        CfUtils.ConditionRemove("ShowCommonSkipButton")
        local go = GameUtils.LoadBundleAsync(prefabPath, UIModule.RootCanvas.gameObject)
        go.name = "ShowCommonSkipButton"
        ---@type CommonSkipButton
        local env = CfUtils.GetLuaScr(go, envPath)
        if isNotNull(env) then
            local co = env:Init(subEnvPath, SafeUnpack(data))
            if co then
                cs_coroutine.yield_return(co)
            end
            ---@type Engine.Lib.KTool
            local KTool            = CS.Engine.Lib.KTool
            KTool.SafeDelete(go)
        end
    end)
end

---获取显示的弹窗参数
---@return UIArgs[]
function UICommonUtils.GetShowDialogArguments()
    ---@type UIArgs[]
    local uiArgsList = {}
    ---@param dialog Engine.UI.UIDialog
    for _, dialog in pairs(UIModule.CurrentScreen.dialogs) do
        table.insert(uiArgsList, dialog.Argument)
    end
    return uiArgsList
end


function UICommonUtils.LoadWebTexture(go, pool, ...)
    ---@type CommonWebImage
    local env = CfUtils.GetLuaScr(go, CommonWebImagePath)
    if isNull(env) then return end
    if pool then
        env:SetPool(pool)
    end
    env:LoadTexture(...)
end

--- BlockerAndStartCo
---@param blockerName string 
---@param cb function
function UICommonUtils.BlockerAndStartCo(blockerName, cb, customRemove)
    ---@type Engine.UI.UIRaycastBlocker
    local UIRaycastBlocker         = CS.Engine.UI.UIRaycastBlocker.Instance
    UIRaycastBlocker:AddCondition(blockerName)
    return cs_coroutine.start(function ()
        if not customRemove then
            UIRaycastBlocker:RemoveCondition(blockerName)
        end
        if cb then
            cb()
        end
        if customRemove then
            UIRaycastBlocker:RemoveCondition(blockerName)
        end
    end)
end

function UICommonUtils.ShowSkin(go, ...)
    ---@type DrawingNode
    local env = CfUtils.GetLuaScr(go, "Game.Behaviours.DrawingNode")
    if isNull(env) then return end
    env:SetParams(...)
end

function UICommonUtils.SetActionRecommendTipsId(go, ...)
    ---@type ActionRecommendEnter
    local env = CfUtils.GetLuaScr(go, "Game.UI.ActionRecommend.ActionRecommendEnter")
    if isNull(env) then return end
    env:SetParams(...)
end

function UICommonUtils.CheckIsExistsBlackOverLay()
    local uiRootTrans      = UIModule.RootCanvas.transform.parent.transform
    local goName           = "UIBlackOverlay"
    local uiBlackOverlayGo = uiRootTrans:Find(goName)
    -- if isNotNull(uiBlackOverlayGo) then
    --     ---@type BlackOverlayMB
    --     local blackOverlayMB = CfUtils.GetLuaScr(uiBlackOverlayGo.gameObject, "Game.Behaviours.BlackOverlayMB") 
    --     return not blackOverlayMB:IsClose()
    -- end
    -- local blackOverlayMB = AddLuaBehaviour(uiBlackOverlayGo.gameObject, BlackOverlayPath)
    return isNotNull(uiBlackOverlayGo)
end

---@type SettingMgr
local SettingMgr = SettingMgr
---@type SettingMgr
local settingMgr = SettingMgr:GetInstance()
local KCookie = CS.Engine.Lib.KCookie

function UICommonUtils.GetLoadingPicUrl(isOp)
    isOp = checkBool(isOp)
    ---@type TableML.TableFile
    local tableFile = settingMgr:Get(AutoIds.IdSetting53)
    local length = tableFile:GetRowCount()
    local data = {}
    local keys = {}
    for _, row in pairs(tableFile) do
        local itemId = parse_number(row, "itemId", 0)
        if itemId > 0 then
            if GoodsUtils.GetThingNo(itemId) > 0 then
                local pk = checkString(row:GetPrimaryKey())
                table.insert(keys, checkNumber(pk))
                data[pk] = pk
            end
        else
            local pk = checkString(row:GetPrimaryKey())
            table.insert(keys, checkNumber(pk))
            data[pk] = pk
        end
    end
    local id = 1
    local isFirst = KCookie.Get("isFirst")
    if not isFirst then
        math.newrandomseed()
        id = math.random(1, length)
        id = keys[id] or 1
        if isOp then
            if id == 8 or id == 9 then  -- 8、9是专门给序章op用的，跳过
                id = 7
            end
        end
    end
    if isOp then
        local loadingImgId = KCookie.Get(Constants.UICacheDataKeys.OP_LOADING_IMG_ID)
        -- print("[loading] get", loadingImgId)
        if checkInt(loadingImgId) > 0 then
            id = loadingImgId
            KCookie.Set(Constants.UICacheDataKeys.OP_LOADING_IMG_ID, -1)
            -- print("[loading] set", -1)
        end
    end
    if not data[tostring(id)] then
        id = checkNumber(data[tostring(keys[1])])
    end
    ---@type TableML.TableFileRow
    local row = tableFile:GetByPrimaryKey(tostring(id))
    local path = CS.ParseUtils.ParsePathName(row, "photoResources")
    return path
end

function UICommonUtils.RefreshCommonUpGroup(go, data, isDown,excludeDialogs)
    local env = CfUtils.GetLuaScr(go,"Game.Behaviours.CommRoleBonusLayoutGroup")
    if isNotNull(env) then
        env:RefreshShow(data, isDown, excludeDialogs)
    end
end

return UICommonUtils
