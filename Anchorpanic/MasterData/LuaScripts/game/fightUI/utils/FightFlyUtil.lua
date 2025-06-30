--[[****************************************************************************
Brief  :战斗飘字工具
Author :Zzz
Date   :2020-03-2
****************************************************************************
]]
-- local fcount = 0
module("fightUI.FightFlyUtil", Class.impl())

function ctor(self)
    self.m_flyLayer = SubLayerMgr:getLayer(gud.SLAYER_FLOAT)
    self.m_colorType = {}
    local c = gs.ColorUtil.GetColor(ColorDef.c4)
    self.m_colorType[fight.FightDef.BATTLE_TYPE_DAMAGE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_ELE_DAMAGE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_BURST] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_DIRECT_DAMAGE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_ANTI_INJURY] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_ELECTROCUTE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_BLEED] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_BURN] = c

    c = gs.ColorUtil.GetColor(ColorDef.c3)
    self.m_colorType[fight.FightDef.BATTLE_TYPE_EVADE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_CURE] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE] = c

    c = gs.ColorUtil.GetColor(ColorDef.c2)
    self.m_colorType[fight.FightDef.BATTLE_TYPE_CRIT] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_BLOCK] = c
    self.m_colorType[fight.FightDef.BATTLE_TYPE_DICE] = c

    -- 直击伤害
    self.m_norFont = gs.ResMgr:Load(UrlManager:getFntPath("nor_hit_num.fontsettings"))
    -- 直击暴击
    local critFont = gs.ResMgr:Load(UrlManager:getFntPath("crit_num.fontsettings"))
    -- 真实伤害
    local directFont = gs.ResMgr:Load(UrlManager:getFntPath("direct_num.fontsettings"))
    -- 真实伤害暴击
    local directCritFont = gs.ResMgr:Load(UrlManager:getFntPath("direct_crit_num.fontsettings"))
    -- 治疗
    local cureFont = gs.ResMgr:Load(UrlManager:getFntPath("cure_num.fontsettings"))
    -- 盾量
    local shieldAddFont = gs.ResMgr:Load(UrlManager:getFntPath("shield_add_num.fontsettings"))
    local shieldCutFont = gs.ResMgr:Load(UrlManager:getFntPath("shield_cut_num.fontsettings"))

    -- 场景盾量
    local shieldAddFont2 = gs.ResMgr:Load(UrlManager:getFntPath("shield_add_num2.fontsettings"))
    local shieldCutFont2 = gs.ResMgr:Load(UrlManager:getFntPath("shield_cut_num2.fontsettings"))

    -- 反伤
    local antiFont = gs.ResMgr:Load(UrlManager:getFntPath("anti_num.fontsettings"))
    -- 留血
    local bleedFont = gs.ResMgr:Load(UrlManager:getFntPath("bleed_num.fontsettings"))

    -- 灼烧
    local burnFont = gs.ResMgr:Load(UrlManager:getFntPath("burn_num.fontsettings"))
    local burnCritFont = gs.ResMgr:Load(UrlManager:getFntPath("burn_crit_num.fontsettings"))
    -- 感电
    local electrocuteFont = gs.ResMgr:Load(UrlManager:getFntPath("electrocute_num.fontsettings"))
    local electrocuteCritFont = gs.ResMgr:Load(UrlManager:getFntPath("electrocute_crit_num.fontsettings"))
    -- 冰冻
    local iceFont = gs.ResMgr:Load(UrlManager:getFntPath("ice_num.fontsettings"))
    local iceCritFont = gs.ResMgr:Load(UrlManager:getFntPath("ice_crit_num.fontsettings"))

    -- 光
    local lightFont = gs.ResMgr:Load(UrlManager:getFntPath("light_num.fontsettings"))
    local lightCritFont = gs.ResMgr:Load(UrlManager:getFntPath("light_crit_num.fontsettings"))
    -- 自然
    local natureFont = gs.ResMgr:Load(UrlManager:getFntPath("nature_num.fontsettings"))
    local natureCritFont = gs.ResMgr:Load(UrlManager:getFntPath("nature_crit_num.fontsettings"))


    self.m_fontType = {}
    self.m_fontType[fight.FightDef.BATTLE_TYPE_DAMAGE] = self.m_norFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_BURST] = self.m_norFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_DIRECT_DAMAGE] = directFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_ANTI_INJURY] = antiFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_ELECTROCUTE] = electrocuteFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_BLEED] = bleedFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_BURN] = burnFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_CRIT] = critFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_BLOCK] = critFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_DICE] = critFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_EVADE] = cureFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_CURE] = cureFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_CLEAR_ELECTROCUTE] = cureFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_SHIELD_ADD] = shieldAddFont
    self.m_fontType[fight.FightDef.BATTLE_TYPE_HURT_ON_SHIELD] = shieldCutFont

    self.m_fontType[fight.FightDef.BATTLE_TYPE_ADD_SCENE_SHIELD] = shieldAddFont2
    self.m_fontType[fight.FightDef.BATTLE_TYPE_HURT_ON_SCENE_SHIELD] = shieldCutFont2

    -- 元素伤害
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_THUNDER] = electrocuteFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_FIRE] = burnFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_ICE] = iceFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_LIGHT] = lightFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_NATURE] = natureFont

    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_THUNDER .. "crit"] = electrocuteCritFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_FIRE .. "crit"] = burnCritFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_ICE .. "crit"] = iceCritFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_LIGHT .. "crit"] = lightCritFont
    self.m_fontType[fight.FightDef.ATTR_ELE_HURT_NATURE .. "crit"] = natureCritFont

    self.fly3DtextFinish = {}

    self.m_fly3D03Pool = {}
end

function getAllFlyAnimations(self)
    return {
        UrlManager:getUIAniPath("piaozi_anmi_new_02.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_03.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_01_01.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_01_02.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_01_03.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_01_04.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_new_01_05.anim"),
        UrlManager:getUIAniPath("piaozi_pg_l.anim"),
        UrlManager:getUIAniPath("piaozi_pg_r.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_img_04.anim"),
        UrlManager:getUIAniPath("piaozi_anmi_img_05.anim")
    }
end

function preloadItem(self, count)
    for i = 1, count do
        local item = LuaPoolMgr:poolGet(fightUI.FlyHUDItem)
        for k, v in ipairs(self:getAllFlyAnimations()) do
            item:preloadAnim(v)
        end
        LuaPoolMgr:poolRecover(item);
    end
    for i = 1, count do
        local item = LuaPoolMgr:poolGet(fightUI.FlyHUDImg)
        for k, v in ipairs(self:getAllFlyAnimations()) do
            item:preloadAnim(v)
        end
        LuaPoolMgr:poolRecover(item);
    end
end

-- 正在使用的飘字方法
function fly3D03(self, id, type, val, pos)
    if not pos or not self.m_flyLayer then
        logWarn("fly3D03 pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyHUDItem)
    local font = self.m_fontType[type]
    if not font then
        font = self.m_norFont
    end
    item:setFont(font)

    if type == fight.FightDef.BATTLE_TYPE_CURE or type == fight.FightDef.BATTLE_TYPE_REVIVE then
        item:setParent(self.m_flyLayer, pos, 20)
    elseif type == fight.FightDef.BATTLE_TYPE_CRIT then
        item:setParent(self.m_flyLayer, pos, 20)
    else
        item:setParent(self.m_flyLayer, pos, 0)
    end

    if type == fight.FightDef.BATTLE_TYPE_CRIT then
        item:setVal(val)
        item:setCrit("$")
    else
        item:setVal("$" .. val)
        item:setCrit("")
    end

    local flyLst = self.m_fly3D03Pool[id]
    if flyLst then
        local ty = 10
        for _, flyItem in ipairs(flyLst) do
            flyItem:addPosY(ty)
        end
    else
        flyLst = {}
        self.m_fly3D03Pool[id] = flyLst
    end

    table.insert(flyLst, item)
    local function _finishCall()
        table.removebyvalue(flyLst, item)
        LuaPoolMgr:poolRecover(item)
        if table.empty(flyLst) then
            self.m_fly3D03Pool[id] = nil
        end
    end
    if type == fight.FightDef.BATTLE_TYPE_CRIT then
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_02.anim"), _finishCall)
    elseif type == fight.FightDef.BATTLE_TYPE_CURE or type == fight.FightDef.BATTLE_TYPE_REVIVE then
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_03.anim"), _finishCall)
    else
        local r = math.random(1, 5)
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_01_0" .. math.ceil(r) .. ".anim"), _finishCall)
    end
end

-- 元素伤害飘字
function flyElement(self, id, type, val, pos, effectList)
    if not pos or not self.m_flyLayer then
        logWarn("flyElement pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyHUDItem)

    local type = effectList[1]
    local crit = effectList[2]
    if crit == 1 then
        type = type .. "crit"
    end

    local font = self.m_fontType[type]
    if not font then
        font = self.m_norFont
    end
    item:setFont(font)

    if crit == 1 then
        item:setParent(self.m_flyLayer, pos, 20)
    else
        item:setParent(self.m_flyLayer, pos, 0)
    end

    if crit == 1 then
        item:setVal(val)
        item:setCrit("$")
    else
        item:setVal("$" .. val)
        item:setCrit("")
    end

    local flyLst = self.m_fly3D03Pool[id]
    if flyLst then
        local ty = 10
        for _, flyItem in ipairs(flyLst) do
            flyItem:addPosY(ty)
        end
    else
        flyLst = {}
        self.m_fly3D03Pool[id] = flyLst
    end

    table.insert(flyLst, item)
    local function _finishCall()
        table.removebyvalue(flyLst, item)
        LuaPoolMgr:poolRecover(item)
        if table.empty(flyLst) then
            self.m_fly3D03Pool[id] = nil
        end
    end
    if crit == 1 then
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_02.anim"), _finishCall)
    elseif type == fight.FightDef.BATTLE_TYPE_CURE or type == fight.FightDef.BATTLE_TYPE_REVIVE then
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_03.anim"), _finishCall)
    else
        local r = math.random(1, 5)
        -- item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_01_01.anim"), _finishCall)

        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_new_01_0" .. math.ceil(r) .. ".anim"), _finishCall)
    end
end

function fly3DImg(self, imgPath, pos, isLeft)
    if not pos or not self.m_flyLayer then
        logWarn("fly3D03 pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyHUDImg)
    item:setParent(self.m_flyLayer, pos, 120)
    item:setImgVal(imgPath)

    local function _finishCall()
        LuaPoolMgr:poolRecover(item)
    end
    if isLeft == true then
        item:playAnim(UrlManager:getUIAniPath("piaozi_pg_l.anim"), _finishCall)
    else
        item:playAnim(UrlManager:getUIAniPath("piaozi_pg_r.anim"), _finishCall)
    end
end

-- buff效果飘字（废弃）
function fly3DImg2(self, id, imgPath, pos, isBuff)
    if not pos or not self.m_flyLayer then
        logWarn("fly3D03 pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyHUDImg)
    item:setParent(self.m_flyLayer, pos, -30)
    item:setImgVal(imgPath)

    local function _finishCall()
        LuaPoolMgr:poolRecover(item)
    end
    if isBuff then
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_img_04.anim"), _finishCall)
    else
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_img_05.anim"), _finishCall)
    end
end

-- buff效果飘字(新)
function fly3DText(self, liveId, val, pos, isBuff)
    if not pos or not self.m_flyLayer then
        logWarn("fly3D03 pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyBuffText)
    item:setParent(self.m_flyLayer, pos, -30)
    item:setVal(val)
    local function _finishCall(id)
        self.fly3DtextFinish[id] = true
        LuaPoolMgr:poolRecover(item)
    end
    if isBuff then
        if self.fly3DtextFinish[liveId] == nil or self.fly3DtextFinish[liveId] == true then
            item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_img_04.anim"), _finishCall, liveId)
        else
            item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_img_04_01.anim"), _finishCall, liveId)
        end
    else
        item:playAnim(UrlManager:getUIAniPath("piaozi_anmi_img_05.anim"), _finishCall, liveId)
    end
    self.fly3DtextFinish[liveId] = false
end

function fly3DImg3(self, id, imgPath, pos, isLeft)
    if not pos or not self.m_flyLayer then
        logWarn("fly3D03 pos is nil")
        return
    end
    local item = LuaPoolMgr:poolGet(fightUI.FlyHUDImg)
    item:setParent(self.m_flyLayer, pos, 20)
    item:setImgVal(imgPath)

    local flyLst = self.m_fly3D03Pool[id]
    if flyLst then
        -- local lastItem = flyLst[#flyLst]
        local ty = 30
        for _, flyItem in ipairs(flyLst) do
            flyItem:addPosY(ty)
        end
    else
        flyLst = {}
        self.m_fly3D03Pool[id] = flyLst
    end

    table.insert(flyLst, item)
    local function _finishCall()
        table.removebyvalue(flyLst, item)
        LuaPoolMgr:poolRecover(item)
        if table.empty(flyLst) then
            self.m_fly3D03Pool[id] = nil
        end
    end
    if isLeft == true then
        item:playAnim(UrlManager:getUIAniPath("piaozi_pg_l.anim"), _finishCall)
    else
        item:playAnim(UrlManager:getUIAniPath("piaozi_pg_r.anim"), _finishCall)
    end
end

function fly3D(cusUiContainer, cusPrefabName, cusStartPos, cusContent, cusDeltaY, cusDefaultCameraDist, cusIsShowInScene)
    if cusUiContainer == nil then
        return
    end

    local gameObj = gs.GOPoolMgr:Get(cusPrefabName)
    if gameObj == nil then
        return
    end

    -- y轴缓动值
    if cusDeltaY == nil then
        cusDeltaY = 60
    end
    -- 默认相机距离
    if cusDefaultCameraDist == nil then
        cusDefaultCameraDist = 10
    end
    -- 是否在scene显示
    if cusIsShowInScene == nil then
        cusIsShowInScene = false
    end

    if cusIsShowInScene == true then
        -- 通过SceneCamera显示，需要canvas的渲染相机为非UICamera
        gameObj.layer = gs.LayerMask.NameToLayer("Default")
        gs.GoUtil.AddComponent(gameObj, ty.Canvas)

        local transform = gameObj:GetComponent(ty.Transform)
        local prefabRectTrans = gameObj:GetComponent(ty.RectTransform)
        gs.TransQuick:LPos(prefabRectTrans, cusStartPos.x, cusStartPos.y + 1, cusStartPos.z - 1)
        local scale = gs.VEC3_ONE * 0.03
        gs.TransQuick:Scale(transform, scale.x, scale.y, scale.z)
        local text = gameObj:GetComponent(ty.Text)
        text.text = cusContent
        -- 先随便一个临时显示的父节点
        local tempParent = gs.GameObject.Find("[EDITOR_GO]").transform
        transform:SetParent(tempParent, false)
        local sceneCamera = gs.CameraMgr:GetSceneCamera()
        prefabRectTrans.rotation = sceneCamera.transform.rotation
        return __startFly(cusPrefabName, gameObj, prefabRectTrans, text, 1, 3)
    else
        -- 通过UICamera显示，需要canvas的渲染相机为非UICamera
        gameObj.layer = gs.LayerMask.NameToLayer("UI")
        gs.GoUtil.RemoveComponent(gameObj, ty.Canvas)

        local transform = gameObj:GetComponent(ty.Transform)
        local prefabRectTrans = gameObj:GetComponent(ty.RectTransform)
        local containerRectTrans = cusUiContainer:GetComponent(ty.RectTransform)
        gs.CameraMgr:World2UI(cusStartPos, containerRectTrans, prefabRectTrans)
        local newDistance = gs.CameraMgr:DistCameraByPos(cusStartPos)
        local scaleFactor = cusDefaultCameraDist / newDistance
        local scale = gs.VEC3_ONE * scaleFactor
        gs.TransQuick:Scale(transform, scale.x, scale.y, scale.z)
        local text = gameObj:GetComponent(ty.Text)
        text.text = cusContent
        transform:SetParent(containerRectTrans, false)
        return __startFly(cusPrefabName, gameObj, prefabRectTrans, text, scaleFactor, cusDeltaY)
    end
end

function fly2D(self, cusUiContainer, cusPrefabName, cusStartPos, cusContent, cusDeltaY, font)
    if cusUiContainer == nil then
        return
    end

    local gameObj = gs.GOPoolMgr:Get(cusPrefabName)
    if gameObj == nil then
        return
    end
    -- y轴缓动值
    if cusDeltaY == nil then
        cusDeltaY = 60
    end

    local prefabRectTrans = gameObj:GetComponent(ty.RectTransform)
    gameObj:GetComponent(ty.RectTransform).anchoredPosition = cusStartPos
    gameObj.transform:SetParent(cusUiContainer, false)
    local text = gameObj:GetComponent(ty.Text)
    if font then
        text.font = font
    end
    text.text = cusContent

    return __startFly(cusPrefabName, gameObj, prefabRectTrans, text, 1, cusDeltaY)
end

function __startFly(cusName, cusGameObj, cusRectTrans, cusText, cusScaleFactor, deltaY)
    local _color = cusText.color
    _color.a = 1
    cusText.color = _color

    local sequence = gs.DT.DOTween.Sequence()
    local move = cusRectTrans:DOLocalMoveY(cusRectTrans.anchoredPosition.y + deltaY * cusScaleFactor, 0.5)
    sequence:Append(move)
    sequence:AppendInterval(0.5)
    local _alpha = cusText:DOColor(gs.Color(_color.r, _color.g, _color.b, 0), 0.5)
    sequence:Join(_alpha)

    local function _tempCall()
        __flyComplete(cusName, cusGameObj, sequence)
    end
    sequence:OnComplete(_tempCall)

    -- 设置为true：该Tween忽视Unity的 timeScale 影响
    -- sequence.SetUpdate(UpdateType.Normal, true)
    -- 设置为true：全部的Tween忽视Unity的 timeScale 影响
    -- gs.DT.DOTween.defaultTimeScaleIndependent = true
    fight.TweenManager:addTweener(sequence)
    return sequence
end

function __flyComplete(cusName, cusGameObj, cusSequence)
    gs.GOPoolMgr:Recover(cusGameObj, cusName)
end

function destroyAll(cusName, cusGameObj, cusSequence)
    gs.GOPoolMgr:RemoveObjs(cusName)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]