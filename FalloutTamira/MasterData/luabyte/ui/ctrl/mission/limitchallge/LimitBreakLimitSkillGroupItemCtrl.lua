local M = BaseClass("LimitBreakLimitSkillGroupItemCtrl",UIBaseComponent)

function M:__init(view)
    self._view = view
    self._itemDic = {}
    self._canselectedNum = 0
end

function M:SetGroupInfo(skillGroup,groupIdx)
    --从 0开始
    self._groupIdx = groupIdx
    self._skillGroup = skillGroup
    local exMapConditionIds = skillGroup:GetIds()
    self._canselectedNum = skillGroup:GetCanSelect()
    local selectedIds = skillGroup:GetSelectIds()
    local selectCallback = Bind(self,self._OnClickSelect)
    for i = 1 , 3 do 
        local item = self._view["item"..i]
        if i <= #exMapConditionIds then 
            item:SetActive(true)
            self._itemDic[exMapConditionIds[i]] = item
            item:SetSkillInfo(exMapConditionIds[i],selectCallback)
            item:SetSelect(table.indexof(selectedIds,exMapConditionIds[i]))
        else
            item:SetActive(false)
        end
    end
    self:_SetSelectInfo()
end

function M:_SetSelectInfo()
    local selectedNum = 0 
    for _, tmpItem in pairs(self._itemDic) do
        -- body
        if tmpItem:GetSelect() then 
            selectedNum = selectedNum + 1
        end
    end
    self._view.txt_select:SetText("已选:"..selectedNum .. "/" .. self._canselectedNum )
end

function M:_OnClickSelect(exMapConditionId)
    local item = self._itemDic[exMapConditionId]
    
    if not item:GetSelect() then 
        local selectedNum = 0 
        local selectedIdx = {}
        for _, tmpItem in pairs(self._itemDic) do
            -- body
            if tmpItem:GetSelect() then 
                selectedNum = selectedNum + 1
                table.insert(selectedIdx,tmpItem:GetSelectId())
            end
        end
        if selectedNum >= self._canselectedNum then 
            GameHelper.Tips("只能选择" ..self._canselectedNum.."个" )
            return
        end
        table.insert(selectedIdx,item:GetSelectId())
        LimitDataMgr:GetInstance():RequestChooseExtremeBattleSkills(self._groupIdx,selectedIdx,Bind(self,self._OnSelectOk))
    else
        item:SetSelect(false)
    end
end

function M:_OnSelectOk()
    self:SetGroupInfo(self._skillGroup,self._groupIdx)
end

function M:OnDestroy()
    GameUtil.DestroyGo(self._view.gameObject)
    M.super.OnDestroy(self)
end

return M