module("tips.NuclearSkillTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/NuclearSkillTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
	self.m_btnLeft = self.m_childGos['BtnLeft']
	self.m_btnRight = self.m_childGos['BtnRight']
	self.m_textCloseTip = self.m_childTrans['TextCloseTip']

	self.m_imgSkillIcon = self.m_childTrans['ImgSkillIcon']:GetComponent(ty.AutoRefImage)
	self.mTxtName = self.m_childTrans['TextName']:GetComponent(ty.Text)

	self.m_textDes_1 = self.m_childTrans['TextDes_1']:GetComponent(ty.Text)
	self.m_textDes_2 = self.m_childTrans['TextDes_2']:GetComponent(ty.Text)
	
	self.m_element_2 = self:getChildGO('Element_2')

	self.m_imgPreview = self:getChildGO('ImgPreview')
end

function active(self)
    super.active(self)
	self:addOnClick(self.m_btnLeft, self.__onClickBtnLeftHandler)
	self:addOnClick(self.m_btnRight, self.__onClickBtnRightHandler)
	self:addOnClick(self.m_imgPreview, self.__onClickPreviewHandler)
end

function deActive(self)
    super.deActive(self)
	self:removeOnClick(self.m_btnLeft)
	self:removeOnClick(self.m_btnRight)
	self:removeOnClick(self.m_imgPreview)
end

-- 初始化数据
function initData(self)
    self.m_instance = nil
    self.m_nuclearSkillList = nil
    self.m_nuclearSkillData = nil
    self.m_heroVo = nil
    self.m_specialTitle = nil
end

function __getInstance(self)
    if (self.m_instance == nil) then
        self.m_instance = tips.NuclearSkillTips.new()
    else
        if (self.m_instance.isPop == 0) then
            self.m_instance:loadAsset()
        end
    end
    return self.m_instance
end

function showTips(self, nuclearSkillDataList, nuclearSkillData)
    if (not nuclearSkillData) then
        Debug:log_warn("SkillTips", "数据Vo为空")
        return
    end
	local instance = self:__getInstance()
	instance.m_nuclearSkillList = nuclearSkillDataList
    instance.m_nuclearSkillData = nuclearSkillData
    instance:__updateView()
    instance:open()
end

function __updateView(self)
	self:__updateLeftRightBtnHandler()
	
	self.m_textCloseTip:GetComponent(ty.Text).text = _TT(4065)

	local des = equip.EquipSkillManager:getSkillDes(self.m_nuclearSkillData)
	local skillVo = fight.SkillManager:getSkillRo(self.m_nuclearSkillData.skillId)

	self.m_imgSkillIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), true)
	self.mTxtName.text = skillVo:getName()
	self.m_textDes_1.text = HtmlUtil:size(_TT(4059, equip.EquipSkillManager:getSkillLvl(self.m_nuclearSkillData) ), 22).."\n"..des
	self.m_element_2:SetActive(false)
end

function __updateLeftRightBtnHandler(self)
	if(not self.m_nuclearSkillList)then
		self.m_nuclearSkillList = {}
	end
	local isInclude = false
	for i = 1, #self.m_nuclearSkillList do
		if(self.m_nuclearSkillList[i] == self.m_nuclearSkillData)then
			isInclude = true
			break
		end
	end
	if(not isInclude)then
		table.insert(self.m_nuclearSkillList, 0, self.m_nuclearSkillData)
	end
	if(#self.m_nuclearSkillList > 1)then
		self.m_btnLeft:SetActive(true)
		self.m_btnRight:SetActive(true)
	else
		self.m_btnLeft:SetActive(false)
		self.m_btnRight:SetActive(false)
	end
end

function __onClickPreviewHandler(self)
	logInfo("点击技能效果演示")
end

-- 点击查看上一条技能
function __onClickBtnLeftHandler(self)
	local serachIndex = self:getSearchIndex()
	if(serachIndex ~= nil)then
		serachIndex = serachIndex - 1
		serachIndex = serachIndex < 1 and #self.m_nuclearSkillList or serachIndex
		self.m_nuclearSkillData = self.m_nuclearSkillList[serachIndex]
		self:__updateView()
	end
end

-- 点击查看下一条技能
function __onClickBtnRightHandler(self)
	local serachIndex = self:getSearchIndex()
	if(serachIndex ~= nil)then
		serachIndex = serachIndex + 1
		serachIndex = serachIndex > #self.m_nuclearSkillList and 1 or serachIndex
		self.m_nuclearSkillData = self.m_nuclearSkillList[serachIndex]
		self:__updateView()
	end
end

function getSearchIndex(self)
	local serachIndex = nil
	for i = 1, #self.m_nuclearSkillList do
		if(self.m_nuclearSkillData.skillId == self.m_nuclearSkillList[i].skillId)then
			serachIndex = i
			break
		end
	end
	return serachIndex
end

function onClose(self)
    super.onClose(self)
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(4065):	"<点击空白位置返回>"
]]
