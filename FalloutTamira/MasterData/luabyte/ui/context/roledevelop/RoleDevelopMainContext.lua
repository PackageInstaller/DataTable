local M = BaseClass("RoleDevelopMainContext", BaseContext)

function M:Init()
    self.m_core = nil -- 选中的核心
    self.m_heroId = 0 -- 选中的英雄ID
    self.m_tabType = -1 -- 主界面页签
    self.m_docType = 0 -- 资料界面页签
    self.m_attrState = 0 -- 属性面板 1：升级，2：预览
    self.m_geneIndex = 0 -- 基因界面基因id
    self.m_jumpCfg = nil -- 跳转表
    self.m_childPanelIndex = 0 -- 是否在子界面的 1级界面 还是2级界面
end

function M:Open(jumpHeroId,index)
    self:_Show(jumpHeroId,index)
end

-- 获取最后状态数据
function M:GetSelectData()
    return {
        Core = self.m_core,
        HeroId = self.m_heroId,
        TabType = self.m_tabType,
        DocType = self.m_docType,
        AttrState = self.m_attrState,
        geneIndex = self.m_geneIndex
    }
end

function M:SelectHeroId(heroId)
    self.m_heroId = heroId
end


function M:SelectTab(tabType)
    self.m_tabType = tabType
end

function M:SelectDocType(docType)
    self.m_docType = docType
end

function M:SetAttrState(value)
    self.m_attrState = value
end

function M:SelectGeneIndex(tabType)
    self.m_geneIndex = tabType
end

function M:SelectCore(cfg)
    self.m_core = cfg
end

function M:SetJumpState(value)
    if value and value.command == "OpenStage" then
        self.m_jumpCfg = value
    else
        self.m_jumpCfg = nil
    end
end

function M:SetChildPanelIndex(index)
    self.m_childPanelIndex = index
end

function M:GetSelectHeroId()
    return self.m_heroId
end

function M:GetSelectTab()
    return self.m_tabType
end

function M:GetSelectDocType()
    return self.m_docType
end

function M:GetAttrState()
    return self.m_attrState
end

function M:GetGeneIndex()
    return self.m_geneIndex
end

function M:GetCore()
    return self.m_core
end

function M:GetChildPanelIndex()
    return self.m_childPanelIndex
end

return M
