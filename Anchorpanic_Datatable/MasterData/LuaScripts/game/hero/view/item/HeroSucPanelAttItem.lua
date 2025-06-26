module("hero.HeroSucPanelAttItem", Class.impl(BaseReuseItem))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroSucPanelAttItem.prefab")
--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    self.Group_1 = self:getChildGO("Group_1")
    self.Group_2 = self:getChildGO("Group_2")
    self.mTxtNextAtt = self:getChildGO("mTxtNextAtt"):GetComponent(ty.Text)
    self.mTxtLastAtt = self:getChildGO("mTxtLastAtt"):GetComponent(ty.Text)
    self.mTxtAttName = self:getChildGO("mTxtAttName"):GetComponent(ty.Text)
    self.mTxtSkillDesc = self:getChildGO("mTxtSkillDesc"):GetComponent(ty.Text)
    self.mTxtSkillName = self:getChildGO("mTxtSkillName"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    --一些常用的
end

-- 设置data
function setData(self, parent, curDataVo, nextDataDic, cusIndex)
    super.setData(self, parent, curDataVo)
    if (curDataVo) then
        self.m_data = {}
        self.m_data.dataVo = curDataVo
        self.m_data.nextDataDic = nextDataDic
        self.m_data.index = cusIndex
    end
    self:updateContent()
end

function updateContent(self)
    if self.m_data.dataVo.type == 1 then
        self.Group_1:SetActive(true)
        self.Group_2:SetActive(false)

        if (self.m_data.dataVo.key ~= -1) then
            self.mTxtAttName.text = AttConst.getName(self.m_data.dataVo.key)
            self.mTxtNextAtt.text = AttConst.getValueStr(self.m_data.dataVo.key, self.m_data.nextDataDic[self.m_data.dataVo.key])
            self.mTxtLastAtt.text = AttConst.getValueStr(self.m_data.dataVo.key, self.m_data.dataVo.value)
        else
            self.mTxtAttName.text = _TT(3259) --"成长"
            self.mTxtNextAtt.text = self.m_data.dataVo.nextValue
            self.mTxtLastAtt.text = self.m_data.dataVo.value
        end
    else
        self.Group_1:SetActive(false)
        self.Group_2:SetActive(true)

        self.mTxtSkillDesc.text = self.m_data.dataVo.desc
        self.mTxtSkillName.text = self.m_data.dataVo.skillName
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]