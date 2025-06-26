--[[ 
-----------------------------------------------------
@filename       : FormationRogueLikePanel
@Description    : 肉鸽阵型
@Author         : SXT
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationRogueLikePanel', Class.impl(formation.FormationPanel))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("formation/FormationRogueLikePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function configUI(self)
    super.configUI(self)
end

function active(self, args)
    super.active(self, args)
end

function deActive(self)
    self.mRecommandFight:SetActive(false)
    super.deActive(self)
    LoopManager:removeFrame(self, self.updateHeroHp)
end

function __updateView(self, cusInit)
    if (self:isLoadFinish()) then
        self.m_teamId = self.m_teamId and self.m_teamId or self:getManager():getFightTeamId()
        if (not self.m_teamId) then
            Debug:log_error("FormationPanel", "出战队列id错误")
            return
        end
        self.m_formationId = self.m_formationId and self.m_formationId or self:getManager():getFightFormationId()
        if (not self.m_formationId) then
            Debug:log_error("FormationPanel", "出战阵型id错误")
            return
        end

        local nowNum = self:getManager():getAssistUnlockNum()
        local nowAssist = #self:getManager():getSelectTeamAssistHeroList(self.m_teamId)

        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST, false) == true and nowNum > 0) then
            self.mBtnAssist:SetActive(true)
            self:setBtnLabel(self.mBtnAssist, 1240, "助战 (" .. nowAssist .. "/" .. nowNum .. ")", nowAssist, nowNum)
        else
            self.mBtnAssist:SetActive(false)
        end

        local data = self:getManager():getData()

        self.id = data.id
        self.isFirst = data.isFirst

        cusInit = cusInit == nil and true or cusInit
        self:__updateTeamList(cusInit)
        self:__updateFightPowerView(cusInit)
        self:__updateCaptain(cusInit)
        self:__updateMiniFormation(cusInit)
        self:__updateMapView()

        self.mBtnAssist:SetActive(false)
        if self.isFirst == nil then
            formation.FormationSceneController:activeNodeAction(false)
            self.mBtnControl:SetActive(true)
        elseif self.isFirst == true then
            formation.FormationSceneController:activeNodeAction(true)
            self.mBtnControl:SetActive(true)
        else
            formation.FormationSceneController:activeNodeAction(false)
            self.mBtnControl:SetActive(false)
        end
        gs.CameraMgr:SetUICameraProjetion(true, 1)

        LoopManager:addFrame(5, 1, self, self.updateHeroHp)
    end
end

-- 获取阵型战力
function getFormationFight(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local fight = 0
    for _, formationHeroVo in pairs(formationHeroList) do
        if (not formationHeroVo:getIsMonster()) then
            local heroVo = hero.HeroManager:getHeroVo(formationHeroVo.heroId)
            fight = fight + heroVo.power
        end
    end
    fight = self:getExtraBuffPower(fight)
    return fight
end

-- 提供给之类重写额外BUFF提升的
function getExtraBuffPower(self, def)
    local heroVoList = formation.FormationRogueLikeManager:getSelectFormationHeroList(self.m_teamId)
    return rogueLike.RogueLikeManager:getBuffPowerUp(def, heroVoList)
end

-- 更新战力
function __updateFightPowerView(self, cusInit)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local fight = self:getFormationFight()
    self.m_textFight.text = fight
   
    local recommandFight = rogueLike.RogueLikeManager:getLastMapPowerFight()
    if (recommandFight == nil or recommandFight <= 0 or self.isFirst) then
        self.mRecommandFight:SetActive(false)
    else
        self.mRecommandFight:SetActive(true)
        self.mTxtRecommandFight.text = recommandFight
        self.mRecommandEnableBg:SetActive(fight < recommandFight)

        local color = fight < recommandFight and gs.ColorUtil.GetColor("E36C77ff") or gs.ColorUtil.GetColor("489E4Eff")
        self.mRecommandBg.color = color
        self.mTxtRecommandFight.color = color
    end
end

-- 更新阵型格子图显示
function __updateMapView(self)
    super.__updateMapView(self)
    self:__updateHeroHp()
end

function updateHeroHp(self)
    self:__updateHeroHp()
end

function __updateHeroHp(self)
    self:recoverHeroHp()
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    local tileFormationHeroVo = nil

    if gs.CameraMgr:GetDefSceneCamera() ~= nil then

        for col_x = 1, col do
            for row_y = 1, row do
                local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
                tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
                if tileFormationHeroVo then
                    local mazeHeroVo = self:getRogueLikeHeroVo(tileFormationHeroVo)

                    local worldPos = self.m_sceneController:getTileWorldPos(col_x, row_y)

                    local pos = gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos, self:getChildTrans("mGroupHeroInfo"), nil)
                    local item = SimpleInsItem:create(self:getChildGO("GroupHeroHpItem"), self:getChildTrans("mGroupHeroInfo"), "FormationRogueLikePanelGroupHeroHpItem")
                    if mazeHeroVo.nowHp > 0 then
                        item:setText("mTxtCont", 1259, string.format("血量：%s", math.ceil(mazeHeroVo.nowHp / mazeHeroVo.maxHp * 100)) .. "%", math.ceil(mazeHeroVo.nowHp / mazeHeroVo.maxHp * 100))
                        item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("26D5D3FF")
                    else
                        item:setText("mTxtCont", 1260, string.format("血量：<color='#ed1941'>%s</color>", math.ceil(mazeHeroVo.nowHp / mazeHeroVo.maxHp * 100)) .. "%", math.ceil(mazeHeroVo.nowHp / mazeHeroVo.maxHp * 100))
                        item:getChildGO("mImgProBar"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor("d52628FF")
                    end
                    gs.TransQuick:ScaleX(item:getChildTrans("mImgProBar"), mazeHeroVo.nowHp / mazeHeroVo.maxHp)
                    gs.TransQuick:UIPos(item:getTrans(), pos.x - 78, pos.y + 139)
                    table.insert(self.mHeroHpList, item)
                end
            end
        end
    end
end

function getRogueLikeHeroVo(self, formationHeroVo)
    local t_mazeHeroVo = {}
    return rogueLike.RogueLikeManager:getHeroInfo(formationHeroVo.heroId)
end

function recoverHeroHp(self)
    if (self.mHeroHpList) then
        for i, v in ipairs(self.mHeroHpList) do
            v:poolRecover()
        end
    end
    self.mHeroHpList = {}
end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local hasZeroHp = false
    local tileFormationHeroVo = nil
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local tilePos = self:getManager():getFormationTilePos(self.m_formationId, col_x, row_y)
            tileFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId, tilePos)
            if tileFormationHeroVo then
                local mazeHeroVo = self:getRogueLikeHeroVo(tileFormationHeroVo)
                if (mazeHeroVo.nowHp <= 0) then
                    hasZeroHp = true
                    break
                end
            end
        end
    end

    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        -- gs.Message.Show("不可出战空队列")
        gs.Message.Show(_TT(29119))
    else
        local function run()
            if self.isFirst then
                UIFactory:alertMessge(_TT(1287), true, function()
                    -- 这里会出现战员全死光的情况，先请求服务器保存新的战员列表，再设置出战id
                    self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
                    self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, { teamId = self.m_teamId })
    
                    self:getManager():clearAllTeamOtherHero()
                    -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
                    self:forceClose()
                    --self:close()
                
                    self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    
                    GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_START, { level = self.id })
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil)
            else
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
        end
        
        local recommandFight = rogueLike.RogueLikeManager:getLastMapPowerFight()
        if (recommandFight == nil or recommandFight <= 0) then
            run()
        else
            local fight = self:getFormationFight()
            if(fight >= recommandFight)then
                run()
            else
                UIFactory:alertMessge(_TT(1366),
                true, function() run() end, _TT(1), nil,
                true, function() end, _TT(2),
                _TT(5), nil, RemindConst.FORMATION_FIGHT)
            end
        end
    end
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if self.isFirst then
        if (self:isLoadFinish()) then
            local colIndex = args.col
            local rowIndex = args.row
            -- 获取配置里的可以上阵的格子次序位置
            local heroPos = self:getManager():getFormationTilePos(self.m_formationId, colIndex, rowIndex)
            -- 是否可以上阵的格子
            if (heroPos > 0) then
                self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_HERO_SELECT_PANEL, { teamId = self.m_teamId, formationId = self.m_formationId, rowIndex = rowIndex, colIndex = colIndex })
            end
        end
    else
        gs.Message.Show(_TT(1288))
    end
end

function __onFramdUpdateHandler(self)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end

    local mousePos = gs.Input.mousePosition
    if (self.m_selectMousePos) then
        local deltaX = self.m_selectMousePos.x - mousePos.x
        local deltaY = self.m_selectMousePos.y - mousePos.y
        if (math.abs(deltaX) <= self:__deltaValue() and math.abs(deltaY) <= self:__deltaValue()) then
            return
        end
        self.m_selectMousePos = nil
        self.m_goLine:SetActive(true)
    end
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(mousePos)
    local parentMousePos = self.UITrans:InverseTransformPoint(mouseWorldPos)
    local screenMousePos = gs.Vector2(parentMousePos.x, parentMousePos.y)
    local localPos = self.m_transLine.localPosition
    gs.TransQuick:SizeDelta01(self.m_transLine, gs.Mathf.Sqrt((screenMousePos.x - localPos.x) * (screenMousePos.x - localPos.x) + (screenMousePos.y - localPos.y) * (screenMousePos.y - localPos.y)))
    gs.TransQuick:SetLRotation(self.m_transLine, 0, 0, self:pointToAngle(localPos, screenMousePos))

    -- 射线检测
    local sceneCamera = gs.CameraMgr:GetDefSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Ground", 100)
    if (hitInfo and hitInfo.collider) then
        local item = hitInfo.collider.gameObject
        local keyData = self.m_sceneController:getTileKeyData(item.name)
        if (keyData) then
            local tile = self.m_sceneController:getDeactiveTile(keyData.col_x, keyData.row_y)
            -- 是否点击了对应的格子
            if (tile) then
                local targetHeroPos = self:getManager():getFormationTilePos(self.m_formationId, keyData.col_x, keyData.row_y)
                if (targetHeroPos > 0) then
                    if (targetHeroPos ~= self.m_targetHeroPos) then
                        if (targetHeroPos ~= self.m_selectHeroPos) then
                            self:revertTargetTile()
                            -- self.m_sceneController:hideActiveTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:showActiveTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:hideTipTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:showTargetTile(keyData.col_x, keyData.row_y)
                        end
                        self.m_targetColIndex = keyData.col_x
                        self.m_targetRowIndex = keyData.row_y
                        self.m_targetHeroPos = targetHeroPos
                        -- print("进入允许站位：", item.name)
                    end
                else
                    self:revertTargetTile()
                    -- print("进入禁止站位：", item.name)
                end
            else
                self:revertTargetTile()
                Debug:log_error("FormationPanel", string.format("数据异常：FormationSceneController:getDeactiveTile()方法找不到对应格子对象%s", item.name))
            end
        else
            self:revertTargetTile()
            -- print("进入和阵型无关的区域", item.name)
            if self.isFirst then
                self.m_isDel = true
            end
        end
    else
        self:revertTargetTile()
        if self.isFirst then
            self.m_isDel = true
        end
        -- print("进入空白区域")

    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1288):	"肉鸽内不允许修改战员"
	语言包: _TT(1287):	"是否使用当前阵容开始挑战,挑战期间将无法替换战员"
]]