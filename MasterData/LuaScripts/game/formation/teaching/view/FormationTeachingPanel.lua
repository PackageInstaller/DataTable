--[[ 
-----------------------------------------------------
@filename       : FormationTeachingPanel
@Description    : 上阵教学
@date           : 2021-08-31 14:46:09
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('formation.FormationTeachingPanel', Class.impl(formation.FormationPanel))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationTeachingPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

-- 阵型选择改变
function __onFormationSelectHandler(self, args)
    gs.Message.Show(_TT(1289))
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        -- gs.Message.Show("不可出战空队列")
        gs.Message.Show(_TT(29119))
        return
    end
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local formationConfigVo = self:getManager():getFormationConfigVo(self.m_formationId)
    local formationConfigList = formationConfigVo:getFormationList()
    if #formationConfigList > #formationHeroList then
        gs.Message.Show(_TT(1290))
        return
    end

    local function run()
        -- 可能会有援助的怪物，必要同步
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
        -- 设置出战队列
        self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {teamId = self.m_teamId})
        -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
        self:forceClose()
        -- 回调外部
        self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
        -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
        self:rsyncFormationList(true)
    end
    run()
end

-- 更新阵型格子图显示
function __updateMapView(self)
    -- 分配阵容
    local storyEffectParam = self:getManager():getData():getEffectParam()
    local firstTeamConfigData = storyEffectParam[1]
    local formationId = firstTeamConfigData[1]
    local formationConfigList = self:getManager():getFormationConfigVo(formationId):getFormationList()
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)

    local paramList = {}
    for i = 2, #storyEffectParam do
        table.insert(paramList, storyEffectParam[i])
    end

    for i, v in ipairs(paramList) do
        local type = v[1]
        if type == 1 then
            -- storyTalk.Effect.TYPE_11 1为固定位置固定英雄
            local isHas = false
            for _, heroVo in pairs(formationHeroList) do
                if heroVo.heroId == v[3] then
                    isHas = true
                    break
                end
            end

            if isHas then
                break
            end

            local monsterTidVo = monster.MonsterManager:getMonsterVo(v[3])
            local pos = formationConfigList[v[2]][1]

            local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
            vo.heroPos = pos
            vo.heroId = monsterTidVo.uniqueTid
            vo.sourceType = formation.HERO_SOURCE_TYPE.TEACHING

            vo.m_heroTid = monsterTidVo.tid
            vo.m_heroLvl = monsterTidVo.lvl
            vo.m_evolutionLvl = monsterTidVo.evolutionLvl
            vo.isFixedHero = true
            table.insert(formationHeroList, vo)
        end
    end

    self.m_sceneController:setIsShowTipTile(true)
    self.m_sceneController:setModelList(formationConfigList, formationHeroList)
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if (self:isLoadFinish() and args) then
        local colIndex = args.col
        local rowIndex = args.row

        if self.m_sceneController:isFixedHero(colIndex, rowIndex) then
            gs.Message.Show2(_TT(1291))
            return
        end

        -- 获取配置里的可以上阵的格子次序位置
        local heroPos = self:getManager():getFormationTilePos(self.m_formationId, colIndex, rowIndex)
        -- 是否可以上阵的格子
        if (heroPos > 0) then
            self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_HERO_SELECT_PANEL, { teamId = self.m_teamId, formationId = self.m_formationId, rowIndex = rowIndex, colIndex = colIndex })
        end
    end
end

-- 阵型瓦片按住事件
function __onPointerDownFormationTileHandler(self, args)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    self:revertTargetTile()
    local worldPos = args.worldPos
    self.m_isDel = false
    self.m_selectMousePos = gs.Input.mousePosition
    self.m_selectColIndex = args.col
    self.m_selectRowIndex = args.row

    if self.m_sceneController:isFixedHero(self.m_selectColIndex, self.m_selectRowIndex) then
        return
    end

    self.m_selectHeroPos = self:getManager():getFormationTilePos(self.m_formationId, self.m_selectColIndex, self.m_selectRowIndex)
    if (self.m_selectHeroPos > 0) then
        gs.CameraMgr:World2UI(worldPos, self.UITrans, self.m_transLine)
        gs.TransQuick:SizeDelta01(self.m_transLine, 0)
        gs.TransQuick:SetLRotation(self.m_transLine, 0, 0, 0)

        -- print("按住：", self.m_selectColIndex, self.m_selectRowIndex, self.m_selectHeroPos)
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFramdUpdateHandler)
        -- self.m_sceneController:hideActiveTile(self.m_selectColIndex, self.m_selectRowIndex)
        self.m_sceneController:showSelectTile(self.m_selectColIndex, self.m_selectRowIndex)
    end
end

-- 阵型瓦片抬起事件
function __onPointerUpFormationTileHandler(self, args)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    -- 选择的数据
    -- self.m_selectColIndex = args.col
    -- self.m_selectRowIndex = args.row
    -- local worldPos = args.worldPos
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
        self.m_goLine:SetActive(false)
    end

    local function _checkResult()
        if (self.m_selectHeroPos) then
            if (self.m_selectHeroPos ~= self.m_targetHeroPos) then
                local selectFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, self.m_selectHeroPos)
                local selectHeroId = selectFormationHeroVo.heroId
                local selectHeroTid = selectFormationHeroVo:getHeroTid()
                local selectHeroSourceType = selectFormationHeroVo.sourceType
                if (self.m_targetHeroPos) then
                    self:getManager():setSelectFormationHeroList(self.m_teamId, self.m_formationId, selectHeroId, selectHeroTid, selectHeroSourceType, self.m_targetHeroPos, false)
                else
                    if (self.m_isDel) then
                        self:getManager():setSelectFormationHeroList(self.m_teamId, self.m_formationId, selectHeroId, selectHeroTid, selectHeroSourceType, self.m_selectHeroPos, false)
                    end
                end
            end
        end
    end

    local sceneCamera = gs.CameraMgr:GetSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Ground", 100)
    if (hitInfo and hitInfo.collider) then
        local item = hitInfo.collider.gameObject
        local keyData = self.m_sceneController:getTileKeyData(item.name)
        if (keyData) then

            if self.m_sceneController:isFixedHero(keyData.col_x, keyData.row_y) then
                gs.Message.Show2(_TT(1291))
                return
            end

            local heroPos = self:getManager():getFormationTilePos(self.m_formationId, keyData.col_x, keyData.row_y)
            if (heroPos > 0) then
                -- print("抬起：", keyData.col_x, keyData.row_y, heroPos)
                _checkResult()
            else
                -- gs.Message.Show("禁止站位")
            end
        end
    else
        _checkResult()
    end

    if (self.m_selectColIndex and self.m_selectRowIndex and self.m_selectHeroPos) then
        -- self.m_sceneController:showActiveTile(self.m_selectColIndex, self.m_selectRowIndex)
        self.m_sceneController:hideSelectTile(self.m_selectColIndex, self.m_selectRowIndex)
    end
    self.m_isDel = nil
    self.m_selectMousePos = nil
    self.m_selectColIndex = nil
    self.m_selectRowIndex = nil
    self.m_selectHeroPos = nil

    if (self.m_targetColIndex and self.m_targetRowIndex and self.m_targetHeroPos) then
        -- self.m_sceneController:showActiveTile(self.m_targetColIndex, self.m_targetRowIndex)
        self.m_sceneController:hideTargetTile(self.m_targetColIndex, self.m_targetRowIndex)
    end
    self.m_targetColIndex = nil
    self.m_targetRowIndex = nil
    self.m_targetHeroPos = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1291):	"该位置为固定英雄"
	语言包: _TT(1291):	"该位置为固定英雄"
	语言包: _TT(1290):	"还有位置没有布置战员"
	语言包: _TT(1289):	"当前为教学关卡，不能更换阵容"
]]
