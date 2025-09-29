-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonGradeComp.lua

module("logic.extensions.season.view.SeasonGradeComp", package.seeall)

local M = class("SeasonGradeComp")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self._btnAdd:RemoveClickListener()

	self._btnAdd = nil
end

function M:_buildUI()
	self._txtLv = goutil.findChildTextComponent(self._mainGO, "txtGradeLv")
	self._imgLvProgress = goutil.findChildImageComponent(self._mainGO, "imgSliderValue")
	self._imgLvProgress1 = goutil.findChildImageComponent(self._mainGO, "imgSliderValue/imgSliderValue (1)")
	self._txtLvProgress = goutil.findChildTextComponent(self._mainGO, "txtActiveValue")
	self._btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "btnAdd"))

	self._btnAdd:AddClickListener(self._onClickBtnAdd, self)

	self._goLvAnim = goutil.findChild(self._mainGO, "txtGradeLayout")
	self._goLvBai = goutil.findChild(self._goLvAnim, "txtGradeList1")
	self._goLvShi = goutil.findChild(self._goLvAnim, "txtGradeList2")
	self._goLvGe = goutil.findChild(self._goLvAnim, "txtGradeList3")
end

function M:setLocalPos(x, y, z)
	Astral.TransformUtil.SetLocalPos(self._mainGO.transform, x, y, z)
end

function M:setLvText(lv)
	self._txtLv.text = lv
end

function M:setProgress(curr, total, showAnim)
	self._txtLvProgress.text = string.format("<color=#E1E1E1>%s</color>/%s", curr, total)

	if showAnim then
		self:showProgressAnim(curr / total)
	else
		self._imgLvProgress.fillAmount = curr / total
	end
end

function M:setAddBtnVisible(visible)
	goutil.setActive(self._btnAdd.gameObject, visible)
end

function M:_onClickBtnAdd()
	local costCode = SeasonConfig.instance:getUpgradeLvMoneyCode()
	local costPerNum = SeasonConfig.instance:getUpgradeLvMoneyNum()
	local ownNum = ItemModel.instance:getItemCountByItemId(costCode)

	if costPerNum <= ownNum then
		ViewMgr.instance:open(ViewName.SeasonNewPromote)
	else
		FloatWordMgr.instance:show(lang("tip_season_5"))
	end
end

function M:showLvAnim(lv)
	local function _setNum(go, value, isLast)
		goutil.setActive(go, true)

		local numArray1 = {}
		local numArray2 = {}

		for i = 1, 10 do
			local numImg1 = goutil.findChildImageComponent(go, string.format("content/num_%s", i - 1))

			table.insert(numArray1, numImg1)

			local numImg2 = goutil.findChildImageComponent(numImg1.gameObject, string.format("num_%s_blur", i - 1))

			table.insert(numArray2, numImg2)
		end

		local function _setImg1(img, num)
			IconLoader.setSprite(img, IconType.DynSpriteAtlas_Season, string.format("fcpy_num_%s", num))
		end

		local function _setImg2(img, num)
			IconLoader.setSprite(img, IconType.DynSpriteAtlas_Season, string.format("fcpy_num_blur_%s", num))
		end

		if isLast then
			for i = 10, 1, -1 do
				local newValue = value + i - 10

				newValue = newValue < 0 and newValue + 10 or newValue

				_setImg1(numArray1[i], newValue)
				_setImg2(numArray2[i], newValue)
			end
		else
			for i = 1, 10 do
				local newValue = value + i - 1

				newValue = newValue > 9 and newValue - 10 or newValue

				_setImg1(numArray1[i], newValue)
				_setImg2(numArray2[i], newValue)
			end
		end
	end

	goutil.setActive(self._txtLv.gameObject, false)

	local bai = math.floor(lv / 100)
	local shi = math.floor((lv - bai * 100) / 10)
	local ge = math.floor(lv - bai * 100 - shi * 10)

	if bai == 0 then
		goutil.setActive(self._goLvBai, false)
	else
		_setNum(self._goLvBai, bai, true)
	end

	if shi == 0 then
		goutil.setActive(self._goLvShi, false)
	else
		_setNum(self._goLvShi, shi, false)
	end

	_setNum(self._goLvGe, ge, true)
	goutil.setActive(self._goLvAnim, true)

	local anim = self._goLvAnim:GetComponent(ComponentType.Animation)

	anim:Play("fcpy_lv")
end

function M:showProgressAnim(progress)
	self._imgLvProgress.fillAmount = 0
	self._imgLvProgress1.fillAmount = 0

	goutil.setActive(self._imgLvProgress1.gameObject, true)

	local anim = self._imgLvProgress1.gameObject:GetComponent(ComponentType.Animation)

	anim:Play("ani_slider")

	local tweenTime = 1.1

	self._tweener = DoTweenUtil.To(0, tweenTime, tweenTime, function(time)
		local newProgress = time / tweenTime * progress

		self._imgLvProgress.fillAmount = newProgress
		self._imgLvProgress1.fillAmount = newProgress
	end)

	self._tweener:OnComplete(function()
		anim:Play("ani_slider_out")
	end)
	self._tweener:SetTarget(self._mainGO)
end

return M
