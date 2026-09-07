local CutFruitGameRunningData = class("CutFruitGameRunningData")

function CutFruitGameRunningData:Ctor()
	return
end

function CutFruitGameRunningData:SetChapterConfig(arg_2_1)
	self._chapterConfig = arg_2_1

	return
end

function CutFruitGameRunningData:SetCharData(arg_3_1)
	if arg_3_1 then
		if arg_3_1.char then
			self._char = arg_3_1.char or self._char
		end

		if arg_3_1.npc then
			self._npc = arg_3_1.npc or self._npc
		end
	end

	return
end

function CutFruitGameRunningData:GetConfig(arg_4_1)
	return self._chapterConfig[arg_4_1]
end

function CutFruitGameRunningData:GetChar()
	return self._char
end

function CutFruitGameRunningData:GetNpc()
	return self._npc
end

function CutFruitGameRunningData:Clear()
	return
end

function CutFruitGameRunningData:Dispose()
	self._tpl = nil
	self._tplItemPool = {}

	return
end

return CutFruitGameRunningData
