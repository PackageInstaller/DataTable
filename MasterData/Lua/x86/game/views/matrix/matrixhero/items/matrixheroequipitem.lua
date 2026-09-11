local MatrixHeroEquipItem = class("MatrixHeroEquipItem", ReduxView)

function MatrixHeroEquipItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MatrixHeroEquipItem:Init()
	self:InitUI()
end

function MatrixHeroEquipItem:InitUI()
	self:BindCfgUI()
end

function MatrixHeroEquipItem:Refresh(arg_4_1)
	self.m_icon.sprite = MatrixTools.GetMatrixItemSprite(arg_4_1)
	self.m_nameLab.text = GetI18NText(MatrixItemCfg[arg_4_1].name)
	self.m_desLab.text = GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1))

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content)

	self.m_scroller.enabled = self.m_viewport.rect.height < self.m_content.rect.height
end

return MatrixHeroEquipItem
