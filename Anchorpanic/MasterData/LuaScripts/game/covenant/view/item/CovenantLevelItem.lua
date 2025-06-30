module("covenant.CovenantLevelItem",Class.impl("lib.component.BaseItemRender"))

function onInit(self,go)
    super.onInit(self,go)

    self.m_notGet = self:getChildGO("NotGet")
    self.m_select = self:getChildGO("Select")
    self.m_geted = self:getChildGO("Geted")
    self.m_redPoint = self:getChildGO("RedPoint")

    self:addOnClick(self:getChildGO("Btn"),self.__onClickHandler)

    self.notGetTxt = self.m_notGet.transform:Find("LevelTxt"):GetComponent(ty.Text)
    self.selectTxt = self.m_select.transform:Find("LevelTxt"):GetComponent(ty.Text)
    self.getedTxt = self.m_geted.transform:Find("LevelTxt"):GetComponent(ty.Text)
end

function setData(self,param)
    super.setData(self,param)
    self.m_notGet:SetActive(false)
    self.m_select:SetActive(false)
    self.m_geted:SetActive(false)
    self.m_redPoint:SetActive(false)

    local type = self.data.type
    local level = covenant.CovenantManager:getPerstigeStage()

    if type == covenant.LevelConst.Geted then
        self.m_geted:SetActive(true)
        self.m_redPoint:SetActive(false)
    elseif type == covenant.LevelConst.NotGET then
        self.m_notGet:SetActive(true)
       
        if  level >= self.data.data.id then
            self.m_redPoint:SetActive(true)
        else
            self.m_redPoint:SetActive(false)
        end
    end

    if self.data.isSelect then
        self.m_notGet:SetActive(false)
        self.m_geted:SetActive(false)
        self.m_select:SetActive(true)
    end

    self.notGetTxt.text = self.data.data.id
    self.selectTxt.text = self.data.data.id
    self.getedTxt.text = self.data.data.id
end


function __onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.UPDATE_COVENANT_HQ_PANEL,{id = self.data.data.id})
end

function deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
