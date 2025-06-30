module("formation.FromtionPreviewController", Class.impl(formation.FormationSceneController))

function getManager(self)
    return formation.FormationPreviewManager
end

function setManager(self, manager)
    self.m_manager = manager
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)

    -- 打开阵型预览
    GameDispatcher:addEventListener(EventName.OPEN_FORMATION_PREVIEW, self.__onOpenFormationPreviewPanelHandler, self)
    -- 打开阵型详情
    -- GameDispatcher:addEventListener(EventName.OPEN_FORMATION_DETAIL, self.__onOpenFormationDetailPanelHandler, self)
end


--注册server发来的数据
function registerMsgHandler(self)
    return {
    --- *s2c* 英雄阵型列表 13041
    -- SC_HERO_FORMATION = self.__onResFormationListHandler,
    -- --- *s2c* 改变阵型 13043
    -- SC_CHANGE_FORMATION = self.__onResFormationChangeHandler,
    -- --- *s2c* 设置出战 13045
    -- SC_SET_READY = self.__onResSetFightTeamHandler,
    -- --- *s2c* 返回更新阵型英雄列表 13047
    -- SC_CHANGE_HERO = self.__onResFormationHeroListHandler,
    -- --- *s2c* 编队改名 13049
    -- SC_RENAME_FORMATION = self.__onResModifyTeamNameHandler,
    }
end

function __onOpenFormationPreviewPanelHandler(self, args)
    if self.mFormationPreviewPanel == nil then
        self.mFormationPreviewPanel = formation.FormationPreviewPanel.new()
        self.mFormationPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationPreviewPanelHandler, self)
    end
    self.mFormationPreviewPanel:open({
        manager = self:getManager(),
        data = args,
        closeCallBack = args.closeCallBackFromtionPreviewController
    })
end

function onDestroyFormationPreviewPanelHandler(self)
    self.mFormationPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationPreviewPanelHandler, self)
    self.mFormationPreviewPanel = nil
end

function setActiveTileColor(self,obj,monsterTid)
    local color = gs.ColorUtil.GetColor("ffffff34")
    if monsterTid then
        local monsterVo = monster.MonsterManager:getMonsterVo(monsterTid):getBaseConfig()
        if monsterVo:getIsBoss() then
            color = gs.ColorUtil.GetColor("933131ff")
        elseif monsterVo:getIsElite() then
            color = gs.ColorUtil.GetColor("86368eff")
        end
    end 
    obj:GetComponent(ty.MeshRenderer).material:SetColor("_Color",color)
end

function setModelList(self, formationConfigList, formationHeroList,formationId, allLoadCall)
    formation.FormationSceneController:clearEffPrefab()
    formation.FormationSceneController:closeEffLoopPrefab()
    local tempModelDic = {}
    if (self.m_modelDic) then
        for key, modelData in pairs(self.m_modelDic) do
            if (modelData) then
                -- local heroId = modelData.formationHeroVo.heroId
                local monsterTid = modelData.formationHeroVo
                tempModelDic[monsterTid] = modelData
            end
        end
        self.m_modelDic = {}
    end

    for key, data in pairs(self.m_tileDic) do
        data.deactiveTile.gameObject:SetActive(true)
        data.activeTile.gameObject:SetActive(false)
        self:setActiveTileColor(data.activeTile.gameObject,nil)
        data.tipTile.gameObject:SetActive(false)
        data.tipActionSprite.gameObject:SetActive(false)
        data.tipActionItemGo:SetActive(false)
        data.selectTile.gameObject:SetActive(false)
        data.targetTile.gameObject:SetActive(false)
        data.lock.gameObject:SetActive(false)
        data.lockSprite.gameObject:SetActive(false)
    end
    self.m_canAddKeyList = {}
    local j = 1
    for i = 1, #formationConfigList do
        local pos = formationConfigList[i][1]
        local col_x = formationConfigList[i][2][1]
        local row_y = formationConfigList[i][2][2]
        local key = self:__getCommonKey(col_x, row_y)
        table.insert(self.m_canAddKeyList, key)
        -- 判断对应站位的格子上是否已有对应的英雄
        for k = j, #formationHeroList do
            local monsterTid = formationHeroList[k]
            if (self.m_modelDic[key] == nil) then
                local _key = monsterTid
                local model = nil
                if (tempModelDic[_key]) then
                    model = tempModelDic[_key].model
                    tempModelDic[_key] = nil
                end
                local key = self:__getCommonKey(col_x, row_y)
                self:setActiveTileColor(self.m_tileDic[key].activeTile.gameObject,monsterTid)
                model = self:getModel(model, monsterTid, col_x, row_y, pos)
                self.m_modelDic[key] = { formationHeroVo = monsterTid, model = model}

                j = j + 1
            end
        end
        self:setTileActive(col_x, row_y, nil)
    end

    for _, modelData in pairs(tempModelDic) do
        LuaPoolMgr:poolRecover(modelData.formationHeroVo)
        modelData.model:destroy()
    end
    tempModelDic = {}
    self.m_arrowEnemy:SetActive(true)
    self:addAction()
end

function __onLoadAssetComplete(self)
    self:initMap()
    self:parseMap()
    if (self.m_finshCall) then
        self.m_finshCall()
    end
end

function initMap(self)
    self.m_formation = gs.GOPoolMgr:Get(self.m_formationName)
    -- Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formation.transform, nil, self.m_bgUrl)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formation.transform, nil, nil)
    self.m_formationGos, self.m_formationTrans = GoUtil.GetChildHash(self.m_formation)
end

function parseMap(self)
    -- 初始化阵型格子字典

    local formationTileCount, row, col = self:getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local key = self:__getCommonKey(col_x, row_y)
            local deactiveTile = self.m_formationTrans[string.substitute(self.m_deactiveTile, col_x, row_y)]
            local activeTile = self.m_formationTrans[string.substitute(self.m_activeTile, col_x, row_y)]
            local tipTile = self.m_formationTrans[string.substitute(self.m_tipTile, col_x, row_y)]
            local tipActionSprite = self.m_formationTrans[string.substitute(self.m_tipActionSprite, col_x, row_y)]
            local tipActionItemGo = self.m_formationGos[string.substitute(self.m_tipActionItem, col_x, row_y)]
            local selectTile = self.m_formationTrans[string.substitute(self.m_selectTile, col_x, row_y)]
            local targetTile = self.m_formationTrans[string.substitute(self.m_targetTile, col_x, row_y)]
            local lock = self.m_formationTrans[string.substitute(self.m_lock, col_x, row_y)]
            local lockSprite =  self.m_formationTrans[string.substitute(self.m_lockSprite, col_x, row_y)]
            self.m_hashTileKeyDic[deactiveTile.name] = { col_x = col_x, row_y = row_y,  lock = lock }
            self.m_tileDic[key] = { deactiveTile = deactiveTile, activeTile = activeTile, tipTile = tipTile, tipActionSprite = tipActionSprite, tipActionItemGo = tipActionItemGo, selectTile = selectTile, targetTile = targetTile ,lock = lock,
            lockSprite = lockSprite}
        end
    end
    self.m_arrowSelf = self.m_formationGos["friendly_arrowhead"]
    self.m_arrowEnemy = self.m_formationGos["enemy_arrowhead"]
    self.m_arrowSelf:SetActive(false)
    self.m_arrowEnemy:SetActive(false)
end

function getFormationTileCount(self)
    return 3 * 4, 3, 4
end

function __getCommonKey(self, col_x, row_y)
    return col_x .. "_" .. row_y
end

function getModel(self, model, monsterTid, col_x, row_y, pos)
    local parent = self.m_formationTrans[string.substitute(self.m_nodeModel, col_x, row_y)]
    local mVo = monster.MonsterManager:getMonsterVo(monsterTid):getBaseConfig()
    local function _finishCall()
        model:setToParent(parent, false)
        local offsetVo = fight.RoleShowManager:getOffsetData2(monsterTid, MainCityConst.ROLE_MODE_FORMATION)
        -- if monsterTid == 60003 then
        --     model:setModelScale(0.4)
        -- end
        if not table.empty(offsetVo) then
            gs.TransQuick:LPos(model:getTrans(), offsetVo[1], offsetVo[2], offsetVo[3])
           
        end
        -- local modelRange = model:getModelGO().transform:GetChild(1)
        -- local collider = gs.GoUtil.AddComponent(modelRange.gameObject, ty.BoxCollider)
        -- local trigger = modelRange:GetComponent(ty.LongPressOrClickEventTrigger)
        -- if not trigger then
        --     trigger = gs.GoUtil.AddComponent(modelRange.gameObject, ty.LongPressOrClickEventTrigger)
        -- end
        -- trigger.onClick:AddListener(function()
        --     formation.FormationPreviewManager:setSelectMonster(monsterTid)
        --     formation.FormationPreviewManager:dispatchEvent(formation.FormationPreviewManager.CHANGE_SELECT)
        -- end)
        -- model.trigger = trigger
    end

    if (model and model:getTrans() and model.m_modeID == mVo:getModel()) then
        _finishCall()
    else
        if (not model) then
            model = fight.LiveView.new()
            if (mVo.type == 3) then
                model:setModeType(MainCityConst.ROLE_MODE_FORMATION)
            else
                model:setModeType(MainCityConst.ROLE_MODE_FORMATION, true)
            end
            model:playStartAction()
        end
        -- 有LiveView决定是否带武器

        local type = 1
        -- if formationHeroVo:getIsMonster()  then 
        if mVo.type == 3 then
            type = 0
        end
        -- end

        model:setModelID(type, mVo:getModel(), false, 1, _finishCall)
    end

    return model
end

function reset(self)
    self:removeAction()
    if (self.m_tileDic) then
        for key, data in pairs(self.m_tileDic) do
            local deactiveTile = data.deactiveTile
            deactiveTile.gameObject:SetActive(true)

            data.activeTile.gameObject:SetActive(false)
            data.tipTile.gameObject:SetActive(false)
            -- self:removeTileAction(key)
            data.tipActionSprite.gameObject:SetActive(false)
            data.tipActionItemGo:SetActive(false)
            data.selectTile.gameObject:SetActive(false)
            data.targetTile.gameObject:SetActive(false)
        end
    end
    self.m_tileDic = {}
    self.m_hashTileKeyDic = {}

    self:resetModelList()
    -- 能上阵英雄的key
    self.m_canAddKeyList = {}

    if (self.m_snModel ~= nil) then
        gs.GOPoolMgr:CancelAsyc(self.m_snModel)
        self.m_snModel = nil
    end
    if (self.m_formation ~= nil) then
        gs.GOPoolMgr:Recover(self.m_formation, self.m_formationName)
        self.m_formation = nil
        self.m_formationGos = nil
        self.m_formationTrans = nil
    end

    -- self:setIsShowTipTile(false)
end

function addAction(self)
    if (not self.m_nodeAction) then
        local trans = self.m_formationTrans["Node_Action"]
        gs.TransQuick:LPos(trans, 0, 0, 0)
        self.m_nodeAction = TweenFactory:move2LPosY(trans, -0.1, 1.2, nil, nil, true)
    end
end

function removeAction(self)
    if (self.m_nodeAction) then
        self.m_nodeAction:Kill()
        self.m_nodeAction = nil
    end
end

function resetModel(self, key)
    if (self.m_modelDic) then
        local modelData = self.m_modelDic[key]
        if (modelData) then
            modelData.model:destroy()
            if modelData.model.trigger then 
                modelData.model.trigger.onClick:RemoveAllListeners()
            end
            self.m_modelDic[key] = nil
        end
    end
end

function resetModelList(self)
    if (self.m_modelDic) then
        for key, modelData in pairs(self.m_modelDic) do
            if (modelData) then
                modelData.model:destroy()
                self.m_modelDic[key] = nil
            end
        end
    end
    self.m_modelDic = {}
end

-- 关闭当前地图
function clearMap(self)
    self:reset()
    Perset3dHandler:toNormalShowData()
end

return _M