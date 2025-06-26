module("equipBuild.EquipBreakUpSucPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/success/EquipBreakUpSucPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗

function ctor(self)
    super.ctor(self)
    self:setTxtTitle("")
end

function configUI(self)
	super.configUI(self)
    self.m_textTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.m_textBreakUpCurLvl = self:getChildGO("TextBreakUpCurLvl"):GetComponent(ty.Text)
    self.m_textBreakUpNextLvl = self:getChildGO("TextBreakUpNextLvl"):GetComponent(ty.Text)

    self.mTxtAttr = self:getChildGO("mTxtAttr"):GetComponent(ty.Text)
end

function active(self, args)
    self:setData(args.oldEquipVo, args.curEquipVo, args.isStrengthen)
    self:updateView()
end

function deActive(self)
end

function initViewText(self)
    self.m_textTitle.text = _TT(71438)
    self.m_textTitle2.text = _TT(71438)
end

function addAllUIEvent(self)
end

function setData(self, oldEquipVo, curEquipVo)
    self.tuPoRank = oldEquipVo.tuPoRank
    self.curEquipVo = curEquipVo
    self.breakUpConfigVo = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(oldEquipVo.tid, self.tuPoRank)
    self.breakUpConfigVo2 = equipBuild.EquipStrengthenManager:getBreakUpConfigVo(oldEquipVo.tid, self.tuPoRank + 1)
end

function updateView(self)
    local tuPoRank = self.tuPoRank
    self.m_textBreakUpCurLvl.text = self.breakUpConfigVo.equipTargetLvl --_TT(1068) .."  ".. HtmlUtil:size(HtmlUtil:color(self.breakUpConfigVo.equipTargetLvl,"0394e7ff"),40)
    self.m_textBreakUpNextLvl.text = self.breakUpConfigVo2.equipTargetLvl -- _TT(1068) .."  ".. HtmlUtil:size(HtmlUtil:color(self.breakUpConfigVo2.equipTargetLvl,"0394e7ff"),40)
    local attachAttrList, attachAttrDic = self.curEquipVo:getTuPoAttachAttr()
    local attachAttrVo = attachAttrList[tuPoRank]
    self.mTxtAttr.text = AttConst.getName(attachAttrVo.key) .."<color=#18ec68>+" .. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value) .. "</color>"

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71438):	"突破成功"
	语言包: _TT(71438):	"突破成功"
]]
