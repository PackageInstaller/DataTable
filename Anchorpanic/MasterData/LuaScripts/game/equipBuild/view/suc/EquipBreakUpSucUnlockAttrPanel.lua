module("equipBuild.EquipBreakUpSucUnlockAttrPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("equipBuild/success/EquipBreakUpSucUnlockAttrPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗

function ctor(self)
    super.ctor(self)
    self:setSize(828, 333)
    self:setTxtTitle(_TT(71439))
end

function configUI(self)
	super.configUI(self)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.m_textTitle2 = self:getChildGO("TextTitle2"):GetComponent(ty.Text)

    self.m_textRankTitle = self:getChildGO("TexRanktTitle"):GetComponent(ty.Text)
    self.m_textAttr = self:getChildGO("TextAttr"):GetComponent(ty.Text)
end

function active(self, args)
    self:setData(args)
    self:updateView()
end

function deActive(self)
end

function initViewText(self)
    self.m_textTitle.text = _TT(71439)
    self.m_textTitle2.text = _TT(71439)
end

function addAllUIEvent(self)
end

function setData(self, curEquipVo)
    self.m_equipVo = curEquipVo
    
end

function updateView(self)
   
    self.m_textRankTitle.text =  _TT(4316)--string.format( "解锁第RANK%s附加属性",self.m_equipVo.tuPoRank-1)

    local attachAttrList, attachAttrDic = self.m_equipVo:getTuPoAttachAttr()

    for i = 1, #attachAttrList do
        local attachAttrVo = attachAttrList[i]
        if (attachAttrVo.breakUpRank == self.m_equipVo.tuPoRank) then
            self.m_textAttr.text = AttConst.getName(attachAttrVo.key) .. HtmlUtil:color(" +".. AttConst.getValueStr(attachAttrVo.key, attachAttrVo.value),"255eee")
            break
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71439):	"解锁属性"
	语言包: _TT(71439):	"解锁属性"
]]
