module("formation.FormationSceneController", Class.impl(Controller))
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__initData()
end

-- 游戏开始的回调
function gameStartCallBack(self)
    super.gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    super.listNotification(self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {}
end

function __initData(self)
    self.playSnDic = {}
    self.m_zeorVector3 = gs.Vector3(0, 0, 0)

    -- 对应预制体的名字格式
    self.m_formationName = UrlManager:getUIPrefabPath("formation/FormationScene3.prefab")
    self.m_formationChooseName = "arts/fx/ui/effect/fx_ui_formation_choose.prefab"
    self.m_formationHandoffName = "arts/fx/ui/effect/fx_ui_formation_handoff.prefab"
    self.m_formationExitName = "arts/fx/ui/effect/fx_ui_formation_exit.prefab"
    self.m_node = "Node_{0}_{1}"
    self.m_deactiveTile = "Tile_Deactive_{0}_{1}"
    self.m_activeTile = "Tile_Active_{0}_{1}"
    self.m_tipTile = "Tile_Tip_{0}_{1}"
    self.m_tipActionSprite = "Tile_Tip_Action_{0}_{1}"
    self.m_tipActionItem = "Tile_Tip_Item_{0}_{1}"
    self.m_selectTile = "Tile_Select_{0}_{1}"
    self.m_targetTile = "Tile_Target_{0}_{1}"
    self.m_nodeModel = "Model_{0}_{1}"

    self.m_lock = "Tile_Lock_{0}_{1}"
    self.m_lockSprite = "Tile_Lock_Sprite_{0}_{1}"
    self.m_loopEff = {}
    self:reset()
end

-- 获取元素常驻预制路径 <=2
function getElePrefabLoopUrl(self, ele)
    local url = ""
    url = "buff_ys_" .. ele .. "_loop.prefab"
    return UrlManager:get3DBuffPath(url)
end

-- 获取元素常驻预制路径 >2
function getElePrefabMaxLoopUrl(self, ele)
    local url = ""
    url = "buff_yss_" .. ele .. "_loop.prefab"
    return UrlManager:get3DBuffPath(url)
end

-- 清理所有元素常驻特效
function closeEffLoopPrefab(self)
    for i = 1, #self.m_loopEff do
        gs.GOPoolMgr:Recover(self.m_loopEff[i].obj, self.m_loopEff[i].url)
    end
    self.m_loopEff = {}
end

-- 播放元素特效 元素类型 数量
function playEffLoopPrefab(self, col, row, ele, count)
    if self:getDeactiveTile(col,row) ~= nil then
        local url = count > 2 and self:getElePrefabMaxLoopUrl(ele) or self:getElePrefabLoopUrl(ele)
        local effPrefab = gs.GOPoolMgr:Get(url)
        local parentTrans = self:getDeactiveTile(col, row).transform
        effPrefab.transform:SetParent(parentTrans, false)
        local info = {
            obj = effPrefab,
            url = url
        }
        table.insert(self.m_loopEff, info)
    end
end

-- 获取元素预制路径
function getEleEffPrefabUrl(self, ele)
    local url = ""
    url = "buff_ys_" .. ele .. ".prefab"
    return UrlManager:get3DBuffPath(url)
end

-- 播放元素特效 元素类型 数量
function playEffPrefab(self, col, row, ele)
    local effPrefab = gs.GOPoolMgr:Get(self:getEleEffPrefabUrl(ele))
    local parentTrans = self:getDeactiveTile(col, row).transform
    effPrefab.transform:SetParent(parentTrans, false)

    local key = col .. "_" .. row .. "_" .. ele
    local function removeEff()
        local value = self.playSnDic[key]
        gs.GOPoolMgr:Recover(value.prefab, value.url)
        self.playSnDic[key] = nil
    end
    local sn = LoopManager:setTimeout(1, nil, removeEff)
    self.playSnDic[key] = {
        sn = sn,
        prefab = effPrefab,
        url = self:getEleEffPrefabUrl(ele)
    }
end

function clearEffPrefab(self)
    for k, v in pairs(self.playSnDic) do
        LoopManager:clearTimeout(v.sn)
        gs.GOPoolMgr:Recover(v.prefab, v.url)
    end
    self.playSnDic = {}
end

function setManager(self, manager)
    self.m_manager = manager
end

function getManager(self)
    return self.m_manager
end

function isLoadFinish(self)
    return self.m_formation ~= nil
end

-- 获取相关格子
function getDeactiveTile(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.deactiveTile) then
        return data.deactiveTile
    end
end
function getActiveTile(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.activeTile) then
        return data.activeTile
    end
end
function getTipTile(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.tipTile) then
        return data.tipTile
    end
end
function getTipActionSprite(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.tipActionSprite and data.tipActionItemGo) then
        return data.tipActionSprite, data.tipActionItemGo
    end
end
function getSelectTile(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.selectTile) then
        return data.selectTile
    end
end
function getTargetTile(self, colIndex, rowIndex)
    local key = self:__getCommonKey(colIndex, rowIndex)
    local data = self.m_tileDic[key]
    if (data and data.targetTile) then
        return data.targetTile
    end
end
-- 设置相关格子显示隐藏
function showActiveTile(self, colIndex, rowIndex)
    local tile = self:getActiveTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(true)
    end
end
function hideActiveTile(self, colIndex, rowIndex)
    local tile = self:getActiveTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(false)
    end
end
function showTipTile(self, colIndex, rowIndex)
    local tile = self:getTipTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(true)
        self:showTipActionSprite(colIndex, rowIndex)
    end
end
function hideTipTile(self, colIndex, rowIndex)
    local tile = self:getTipTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(false)
        self:hideTipActionSprite(colIndex, rowIndex)
    end
end
function showTipActionSprite(self, colIndex, rowIndex)
    local sprite, tipActionItemGo = self:getTipActionSprite(colIndex, rowIndex)
    if (sprite and tipActionItemGo) then
        sprite.gameObject:SetActive(true)
        tipActionItemGo:SetActive(true)
    end
end
function hideTipActionSprite(self, colIndex, rowIndex)
    local sprite, tipActionItemGo = self:getTipActionSprite(colIndex, rowIndex)
    if (sprite) then
        sprite.gameObject:SetActive(false)
        tipActionItemGo:SetActive(false)
    end
end
function showSelectTile(self, colIndex, rowIndex)
    local tile = self:getSelectTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(true)
    end
end
function hideSelectTile(self, colIndex, rowIndex)
    local tile = self:getSelectTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(false)
    end
end
function showTargetTile(self, colIndex, rowIndex)
    local tile = self:getTargetTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(true)
    end
end
function hideTargetTile(self, colIndex, rowIndex)
    local tile = self:getTargetTile(colIndex, rowIndex)
    if (tile) then
        tile.gameObject:SetActive(false)
    end
end

function showChooseVFX(self, colIndex, rowIndex)
    -- 不再显示这个特效 临时屏蔽内容
    self.m_formationChoose:SetActive(true)
    local parent = self:getDeactiveTile(colIndex, rowIndex)
    self.m_formationChoose.transform:SetParent(parent, false)
end

function hideChooseVFX(self)
    self.m_formationChoose:SetActive(false)
end

function showHandoffVFX(self, colIndex, rowIndex)
    -- 不再显示这个特效 临时屏蔽内容
    -- self.m_formationHandoff:SetActive(false)
    -- local parent = self:getDeactiveTile(colIndex, rowIndex)
    -- self.m_formationHandoff.transform:SetParent(parent, false)
    -- self.m_formationHandoff:SetActive(true)
end

function showExitVFX(self, colIndex, rowIndex)
    self.m_formationExit:SetActive(false)
    local parent = self:getDeactiveTile(colIndex, rowIndex)
    self.m_formationExit.transform:SetParent(parent, false)
    self.m_formationExit:SetActive(true)
end

-- 添加单个格子动画
function addTileAction(self, key, trans)
    -- self:removeTileAction(key)
    -- gs.TransQuick:LPos(trans, 0, 0.5, 0)
    -- self.m_tweenDic[key] = TweenFactory:move2LPosY(trans, 0.4, 1.2, nil, nil, true)
end

-- 移除单个格子动画
function removeTileAction(self, key)
    -- if(self.m_tweenDic)then
    -- 	if(self.m_tweenDic[key])then
    -- 		self.m_tweenDic[key]:Kill()
    -- 		self.m_tweenDic[key] = nil
    -- 	end
    -- else
    -- 	self.m_tweenDic = {}
    -- end
end

-- 添加整片格子动画
function addAction(self)
    if (not self.m_nodeAction) then
        local trans = self.m_formationTrans["Node_Action"]
        gs.TransQuick:LPos(trans, 0, 0, 0)
        self.m_nodeAction = TweenFactory:move2LPosY(trans, -0.1, 1.2, nil, nil, true)
    end
end

function activeNodeAction(self, isActive)
    self.m_formationTrans["Node_Action"].gameObject:SetActive(isActive)
end

-- 移除整片格子动画
function removeAction(self)
    if (self.m_nodeAction) then
        self.m_nodeAction:Kill()
        self.m_nodeAction = nil
    end
end

-- 设置是否显示提示格子
function setIsShowTipTile(self, isShow)
    self.m_isShowTipTile = isShow
end

-- 获取是否显示提示格子
function getIsShowTipTile(self)
    return self.m_isShowTipTile
end

-- 判断是否为没有英雄的空格子
function isEmpty(self, colIndex, rowIndex)
    if (self:getActiveTile(colIndex, rowIndex)) then
        return self.m_modelDic[self:__getCommonKey(colIndex, rowIndex)] == nil
    end
    return false
end

-- 判断是否含有未上阵英雄的空格子
function isHasEmpty(self)
    local isHas = false
    for _, key in pairs(self.m_canAddKeyList) do
        isHas = self.m_modelDic[key] == nil
        if (isHas) then
            break
        end
    end
    return isHas
end

-- 是否固定英雄
function isFixedHero(self, colIndex, rowIndex)
    local data = self.m_modelDic[self:__getCommonKey(colIndex, rowIndex)]
    if data then
        local vo = data.formationHeroVo
        if vo and vo.isFixedHero then
            return true
        end
    end
    return false
end

-- 获取格子的世界坐标
function getTileWorldPos(self, colIndex, rowIndex)
    local deactiveTile = self:getDeactiveTile(colIndex, rowIndex)
    if (deactiveTile) then
        return deactiveTile.position
    else
        return self.m_zeorVector3
    end
end

-- 根据格子HashCode
function getTileKeyData(self, hashCode)
    local data = self.m_hashTileKeyDic[hashCode]
    return data
end

-- 判断格子是否解锁
function getTileLock(self, col_x, row_y)
    local key = self:__getCommonKey(col_x, row_y)
    return self.m_tileDic[key].lock.gameObject.activeSelf
end

function enterMap(self, mapName, bgUrl, finshCall)
    self.m_finshCall = finshCall
    self.m_bgUrl = bgUrl
    if (self:isLoadFinish()) then
        self:parseMap()
        if (self.m_finshCall) then
            self.m_finshCall()
        end
    else
        if (self.m_sn ~= nil) then
            gs.GOPoolMgr:CancelAsyc(self.m_sn)
        end
        local loadFinish = function()
            self.m_sn = nil
            self:__onLoadAssetComplete()
        end
        self.m_sn = AssetLoader.PreLoadAsyn(self.m_formationName, loadFinish, self)
    end
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
    self.m_formationChoose = gs.GOPoolMgr:Get(self.m_formationChooseName)
    self.m_formationChoose:SetActive(false)
    self.m_formationHandoff = gs.GOPoolMgr:Get(self.m_formationHandoffName)
    self.m_formationHandoff:SetActive(false)
    self.m_formationExit = gs.GOPoolMgr:Get(self.m_formationExitName)
    self.m_formationExit:SetActive(false)
    -- Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formation.transform, nil, self.m_bgUrl)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formation.transform, nil, nil)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formationChoose.transform, nil, nil)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formationHandoff.transform, nil, nil)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, self.m_formationExit.transform, nil, nil)
    self.m_formationGos, self.m_formationTrans = GoUtil.GetChildHash(self.m_formation)
end

function parseMap(self)
    -- 初始化阵型格子字典
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
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
            local lockSprite = self.m_formationTrans[string.substitute(self.m_lockSprite, col_x, row_y)]
            self.m_hashTileKeyDic[deactiveTile.name] = {
                col_x = col_x,
                row_y = row_y,
                lock = lock
            }
            self.m_tileDic[key] = {
                deactiveTile = deactiveTile,
                activeTile = activeTile,
                tipTile = tipTile,
                tipActionSprite = tipActionSprite,
                tipActionItemGo = tipActionItemGo,
                selectTile = selectTile,
                targetTile = targetTile,
                lock = lock,
                lockSprite = lockSprite
            }

            local trigger = deactiveTile.gameObject:GetComponent(ty.LongPressOrClickEventTrigger)
            -- 点击
            local function _onClickHandler()
                self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_SELECT, {
                    col = col_x,
                    row = row_y
                })
            end
            trigger.onClick:AddListener(_onClickHandler)

            -- 派发拖拽线相关事件
            -- 按下
            local function _onPointDownHandler()
                if (self.m_modelDic[key]) then
                    self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_POINTER_DOWN, {
                        col = col_x,
                        row = row_y,
                        worldPos = activeTile.position
                    })
                end
            end
            trigger.onPointerDown:AddListener(_onPointDownHandler)
            -- 抬起
            local function _onPointUpHandler()
                self:getManager():dispatchEvent(self:getManager().HERO_FORMATION_TILE_POINTER_UP, {
                    col = col_x,
                    row = row_y,
                    worldPos = activeTile.position
                })
            end
            trigger.onPointerUp:AddListener(_onPointUpHandler)
        end
    end

    self.m_arrowSelf = self.m_formationGos["friendly_arrowhead"]
    self.m_arrowEnemy = self.m_formationGos["enemy_arrowhead"]
    self.m_arrowSelf:SetActive(false)
    self.m_arrowEnemy:SetActive(false)
end

function __getCommonKey(self, col_x, row_y)
    return col_x .. "_" .. row_y
end

function setActiveTileColor(self, obj, vo)
    obj:GetComponent(ty.MeshRenderer).material:SetColor("_Color", gs.ColorUtil.GetColor("ffffff34"))
end

function setModelList(self, formationConfigList, formationHeroList, formationId, allLoadCall)
    local tempModelDic = {}
    if (self.m_modelDic) then
        for key, modelData in pairs(self.m_modelDic) do
            if (modelData) then
                local heroId = modelData.formationHeroVo.heroId
                local heroTid = modelData.formationHeroVo:getHeroTid()
                tempModelDic[heroId .. "_" .. heroTid] = modelData
            end
        end
        self.m_modelDic = {}
    end

    for key, data in pairs(self.m_tileDic) do
        -- data.deactiveTile.gameObject:SetActive(true)
        data.activeTile.gameObject:SetActive(false)
        self:setActiveTileColor(data.activeTile.gameObject, nil)

        data.tipTile.gameObject:SetActive(false)
        data.tipActionSprite.gameObject:SetActive(false)
        data.tipActionItemGo:SetActive(false)
        data.selectTile.gameObject:SetActive(false)
        data.targetTile.gameObject:SetActive(false)

        data.lock.gameObject:SetActive(false)
        data.lockSprite.gameObject:SetActive(false)
    end

    self.m_canAddKeyList = {}
    self.needCount = 0
    self.currentCount = 0
    ---------------------------------------------------
    for i = 1, #formationConfigList do

        local pos = formationConfigList[i][1]
        local col_x = formationConfigList[i][2][1]
        local row_y = formationConfigList[i][2][2]
        local key = self:__getCommonKey(col_x, row_y)
        table.insert(self.m_canAddKeyList, key)

        -- 判断对应站位的格子上是否已有对应的英雄
        for j = 1, #formationHeroList do
            local formationHeroVo = formationHeroList[j]
            if (formationHeroVo.heroPos == pos) then
                local _key = formationHeroVo.heroId .. "_" .. formationHeroVo:getHeroTid()
                local model = nil
                if (tempModelDic[_key]) then
                    model = tempModelDic[_key].model
                    tempModelDic[_key] = nil
                end
                self.needCount = self.needCount + 1
                model = self:getModel(model, formationHeroVo, col_x, row_y, allLoadCall)
                local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
                vo:copy(formationHeroVo)
                self.m_modelDic[key] = {
                    formationHeroVo = vo,
                    model = model
                }
            end
        end
        self:setTileActive(col_x, row_y, formationId, nil)
    end

    for _, modelData in pairs(tempModelDic) do
        LuaPoolMgr:poolRecover(modelData.formationHeroVo)
        modelData.model:destroy()
    end
    tempModelDic = {}
    self.m_arrowSelf:SetActive(true)
    self:addAction()
end

function setTileActive(self, col_x, row_y, formationId, isShowTipTile)
    local key = self:__getCommonKey(col_x, row_y)
    local data = self.m_tileDic[key]
    if (data) then
        local isLock, id = self:getManager():getFormationTileLock(formationId, col_x, row_y)
        if isLock == true and id > 0 then
            local spriteRenderer = self.m_tileDic[key].lockSprite:GetComponent(ty.SpriteRenderer)
            local url = UrlManager:getPackPath("formation/formation_" .. id .. ".png")
            local sprite = gs.ResMgr:Load(url)
            -- 没有指定资源类型且同步加载的图片资源返回是texture2d格式
            if sprite then
                if sprite.texture then
                    spriteRenderer.sprite = sprite
                else
                    gs.GoUtil.SetSpriteRendererByTexture(spriteRenderer, sprite)
                end
            end
            data.lock.gameObject:SetActive(true)
            data.lockSprite.gameObject:SetActive(true)
        end

        isShowTipTile = isShowTipTile == nil and (self:getIsShowTipTile() and self:isEmpty(col_x, row_y)) or
                            isShowTipTile
        data.deactiveTile.gameObject:SetActive(true)
        data.activeTile.gameObject:SetActive(not isShowTipTile and isLock == false)
        data.tipTile.gameObject:SetActive(isShowTipTile and isLock == false)
        data.tipActionSprite.gameObject:SetActive(isShowTipTile and isLock == false)
        data.tipActionItemGo:SetActive(isShowTipTile and isLock == false)
        data.selectTile.gameObject:SetActive(false)
        data.targetTile.gameObject:SetActive(false)
        if (isShowTipTile) then
            self:addTileAction(key, data.tipActionSprite)
        else
            self:removeTileAction(key)
        end
    end
end

function getModel(self, model, formationHeroVo, col_x, row_y, allLoadCall)
    local parent = self.m_formationTrans[string.substitute(self.m_nodeModel, col_x, row_y)]
    local function _finishCall()
        model:setToParent(parent, false)
        local offsetVo = fight.RoleShowManager:getOffsetData2(formationHeroVo:getHeroTid(),
            MainCityConst.ROLE_MODE_FORMATION)
        if not table.empty(offsetVo) then
            gs.TransQuick:LPos(model:getTrans(), offsetVo[1], offsetVo[2], offsetVo[3])
        end

        self.currentCount = self.currentCount + 1
        if self.currentCount == self.needCount then
            if allLoadCall then
                allLoadCall()
                allLoadCall = nil
            end
        end
    end
    if (model and model:getTrans() and model.m_modeID == formationHeroVo:getModel()) then
        model:setLoadFinishCall(nil)
        _finishCall()
    else
        if (not model) then
            model = fight.LiveView.new()
            model:setModeType(MainCityConst.ROLE_MODE_FORMATION, formationHeroVo:getIsMonster())
            model:playStartAction()
        end
        -- 有LiveView决定是否带武器

        local type = formationHeroVo:getIsMonster() and 1 or 0
        if formationHeroVo:getIsMonster() then
            local mVo = monster.MonsterManager:getMonsterVo01(formationHeroVo:getHeroTid())
            if mVo.type == 3 then
                type = 0
            end
        end

        model:setModelID(type, formationHeroVo:getModel(), true, 1, _finishCall)
    end
    return model
end

function resetModel(self, key)
    if (self.m_modelDic) then
        local modelData = self.m_modelDic[key]
        if (modelData) then
            modelData.model:destroy()
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

function reset(self)
    self:removeAction()
    if (self.m_tileDic) then
        for key, data in pairs(self.m_tileDic) do
            local deactiveTile = data.deactiveTile
            local trigger = deactiveTile.gameObject:GetComponent(ty.LongPressOrClickEventTrigger)
            trigger.onClick:RemoveAllListeners()
            trigger.onPointerDown:RemoveAllListeners()
            trigger.onPointerUp:RemoveAllListeners()
            deactiveTile.gameObject:SetActive(true)

            data.activeTile.gameObject:SetActive(false)
            data.tipTile.gameObject:SetActive(false)
            self:removeTileAction(key)
            data.tipActionSprite.gameObject:SetActive(false)
            data.tipActionItemGo:SetActive(false)
            data.selectTile.gameObject:SetActive(false)
            data.targetTile.gameObject:SetActive(false)
            data.lock.gameObject:SetActive(false)
            data.lockSprite.gameObject:SetActive(false)
        end
    end
    self.m_tileDic = {}
    self.m_hashTileKeyDic = {}

    self:resetModelList()
    -- 能上阵英雄的key
    self.m_canAddKeyList = {}

    if (self.m_sn ~= nil) then
        gs.GOPoolMgr:CancelAsyc(self.m_sn)
        self.m_sn = nil
    end
    if (self.m_formation ~= nil) then
        gs.GOPoolMgr:Recover(self.m_formation, self.m_formationName)
        self.m_formation = nil
        self.m_formationGos = nil
        self.m_formationTrans = nil
        gs.GOPoolMgr:Recover(self.m_formationChoose, self.m_formationChooseName)
        gs.GOPoolMgr:Recover(self.m_formationHandoff, self.m_formationHandoffName)
        gs.GOPoolMgr:Recover(self.m_formationExit, self.m_formationExitName)
        self.m_formationChoose = nil
        self.m_formationHandoff = nil
        self.m_formationExit = nil
    end

    self:setIsShowTipTile(false)
end

-- 关闭当前地图
function clearMap(self)
    self:reset()
    Perset3dHandler:toNormalShowData()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
