local NewSlgS2AdditionComp = class("NewSlgS2AdditionComp", require("app.fairyGUI.newSlg.UI_NewSlgS2AdditionComp"))

function NewSlgS2AdditionComp:ctor()
	self._addArr = {}
	self._descTexts = {}

	for iter_1_0 = 1, 2 do
		self._descTexts[iter_1_0] = self.m_scrollComp:getChild("Txt_desc" .. iter_1_0)
	end

	self.m_tipTxt2:setText(g.core.lang:get(429664, {
		num = g.core.model.User.newSlgData:getNewSlgParamsValueById(153) / 100
	}))
end

function NewSlgS2AdditionComp:updateView(arg_2_1)
	if arg_2_1 then
		self._addArr = arg_2_1.addArr or {}
	end

	if #self._addArr == 0 then
		return
	end

	for iter_2_0 = 1, 2 do
		if self._addArr[iter_2_0] then
			self._descTexts[iter_2_0]:setVisible(true)

			if self._addArr[iter_2_0].tp == g.core.const.ConstMgr.NewSlgConst.Slg2CityAddType.res then
				if arg_2_1.notCity then
					self._descTexts[iter_2_0]:setText(g.core.lang:get(429667, {
						num = self._addArr[iter_2_0].value / 100 .. "%"
					}))
				else
					self._descTexts[iter_2_0]:setText(g.core.lang:get(429666, {
						num = self._addArr[iter_2_0].value / 100 .. "%"
					}))
				end
			elseif arg_2_1.notCity then
				self._descTexts[iter_2_0]:setText(g.core.lang:get(429668, {
					num = self._addArr[iter_2_0].value / 100 .. "%"
				}))
			else
				self._descTexts[iter_2_0]:setText(g.core.lang:get(429624, {
					num = self._addArr[iter_2_0].value / 100 .. "%"
				}))
			end
		else
			self._descTexts[iter_2_0]:setVisible(false)
		end
	end
end

function NewSlgS2AdditionComp:updateFarmView()
	self.m_title:setText(g.core.lang:get(429719))
	self.m_tipTxt2:setVisible(false)
	self.m_Txt_tip:setVisible(false)
	self.m_scrollComp:setHeight(108)
	self._descTexts[1]:setVisible(true)
	self._descTexts[1]:setText(g.core.config.help_text_info.get(397, 1).text)
end

function NewSlgS2AdditionComp:updateCityView()
	self.m_title:setText(g.core.lang:get(429719))
	self.m_tipTxt2:setVisible(false)
	self.m_Txt_tip:setVisible(false)
	self.m_scrollComp:setHeight(108)
	self._descTexts[1]:setVisible(true)
	self._descTexts[1]:setText(g.core.config.help_text_info.get(507, 1).text)
end

return NewSlgS2AdditionComp
