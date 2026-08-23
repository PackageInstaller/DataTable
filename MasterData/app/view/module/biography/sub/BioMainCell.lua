local BioMainCell = class("BioMainCell", require("app.fairyGUI.biography.UI_BioMainCell"))

function BioMainCell:ctor()
	self._refLand = nil
	self.m_chapterArr = {}

	for iter_1_0 = 1, 5 do
		self.m_chapterArr[iter_1_0] = self["m_chapter" .. iter_1_0]
	end
end

function BioMainCell:onLoad()
	return
end

function BioMainCell:updatePageView(arg_3_1)
	self._refLand = arg_3_1

	for iter_3_0 = 1, 5 do
		if iter_3_0 <= #arg_3_1.chapters then
			self.m_chapterArr[iter_3_0]:setVisible(true)
			self.m_chapterArr[iter_3_0]:updateData(arg_3_1.chapters[iter_3_0])
		else
			self.m_chapterArr[iter_3_0]:setVisible(false)
		end
	end

	self.m_enterTransition:play()
end

function BioMainCell:playFirstChapterOpen()
	self.m_chapterArr[1]:playAnimateUnlock(true)
end

function BioMainCell:playSwitchTransition(arg_5_1, arg_5_2)
	if arg_5_1 == "out" then
		self.m_backTransition:play(function()
			if arg_5_2 then
				arg_5_2()
			end
		end)
	else
		self.m_enterTransition:play(function()
			if arg_5_2 then
				arg_5_2()
			end
		end)
	end
end

return BioMainCell
