--[[ 
-----------------------------------------------------
@Description    : 技能编辑器数据结构
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("SkillEditorDataRo", Class.impl())

function parseData(self, refID, refData)
	self.m_refID=refID

	self.m_eft = refData.eft
	self.m_target = refData.target
	self.m_frame = refData.frame
	self.m_audio = refData.audio
	self.m_skip = refData.skip
	if refData.special then
		self.m_special = refData.special[1]
	else
		self.m_special = nil
	end
end

function getRefID(self)
	return self.m_refID
end

function getEft(self)
	return self.m_eft
end

function getTarget(self)
	return self.m_target
end

function getFrame(self)
	return self.m_frame
end

function getAudio(self)
	return self.m_audio
end

function getSpecial(self)
	return self.m_special
end

function getSkip(self)
	return self.m_skip
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
