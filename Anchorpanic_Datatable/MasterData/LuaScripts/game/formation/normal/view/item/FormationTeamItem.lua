module('formation.FormationTeamItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mGroupSelect = self:getChildGO("GroupSelect")
    self.mTxtSelect = self:getChildGO("mTxtSelect"):GetComponent(ty.Text)
    self.mButtonModify = self:getChildGO("mButtonModify")
    self:addOnClick(self.mButtonModify, self.onClickModifyTeamNameHandler)

    self.mGroupUnSelect = self:getChildGO("GroupUnSelect")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mTxtUnSelect = self:getChildGO("mTxtUnSelect"):GetComponent(ty.Text)

    self.mGuideClick = self:getChildGO("GuideClick")
    self:addOnClick(self.mGuideClick, self.onClickItemHandler)
end

function setData(self, param)
    super.setData(self, param)

    local selectVo = self.data
    local teamId = selectVo:getDataVo().teamId
    local manager = selectVo:getDataVo().manager
    local teamVo = manager:getTeamVoByTeamId(teamId)
    -- manager:isTeamIdInFight(teamId)

    if (teamVo.teamName == "") then
        self.mTxtSelect.text = _TT(1261, manager:getTeamIdIndex(teamId))
        self.mTxtUnSelect.text = _TT(1261, manager:getTeamIdIndex(teamId))
    else
        self.mTxtSelect.text = teamVo.teamName
        self.mTxtUnSelect.text = teamVo.teamName
    end

    local isSelect = selectVo:getSelect()
    if (isSelect) then
        self.mGroupSelect:SetActive(true)
        self.mGroupUnSelect:SetActive(false)
    else
        self.mGroupSelect:SetActive(false)
        self.mGroupUnSelect:SetActive(true)
    end

    if (manager:getTeamIdIndex(teamId) > 1) then
        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EXCEPT_FIRST_TEAM, false)) then
            self.mImgLock:SetActive(false)
        else
            self.mImgLock:SetActive(true)
        end
    else
        self.mImgLock:SetActive(false)
    end
end

function onClickModifyTeamNameHandler(self)
    local selectVo = self.data
    local teamId = selectVo:getDataVo().teamId
    local manager = selectVo:getDataVo().manager
    if manager:getTeamVoByTeamId(teamId).teamName == "" then
        role.RoleManager:setInputText(_TT(1261, manager:getTeamIdIndex(teamId)))
    else
        role.RoleManager:setInputText(manager:getTeamVoByTeamId(teamId).teamName)
    end
    manager:dispatchEvent(manager.OPEN_FORMATION_MODIFY_TEAM_NAME_PANEL, { teamId = teamId })
end

function onClickItemHandler(self)
    local selectVo = self.data
    local teamId = selectVo:getDataVo().teamId
    local manager = selectVo:getDataVo().manager
    if (manager:getTeamIdIndex(teamId) > 1) then
        if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EXCEPT_FIRST_TEAM, true)) then
            return
        end
    end
    manager:dispatchEvent(manager.HERO_TEAM_SEE, { teamId = teamId })
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mButtonModify)
    self:removeOnClick(self.mGuideClick)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]