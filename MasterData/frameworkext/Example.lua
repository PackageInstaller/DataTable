-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/debug/Example.lua

local mri = require("MemoryReferenceInfo")

mri.m_cConfig.m_bAllMemoryRefFileAddTime = false

collectgarbage("collect")
mri.m_cMethods.DumpMemorySnapshot("./", "1-Before", -1)

_G.Author = {
	Hobby = "Game, Travel, Gym",
	Name = "yaukeywang",
	Job = "Game Developer",
	City = "Beijing",
	Country = "China",
	Ask = function(question)
		return "My answer is for your question: " .. question .. "."
	end
}

collectgarbage("collect")
mri.m_cMethods.DumpMemorySnapshot("./", "2-After", -1)
collectgarbage("collect")
mri.m_cMethods.DumpMemorySnapshotSingleObject("./", "SingleObjRef-Object", -1, "Author", _G.Author)
collectgarbage("collect")
mri.m_cMethods.DumpMemorySnapshotSingleObject("./", "SingleObjRef-String", -1, "Author Name", "yaukeywang")
mri.m_cMethods.DumpMemorySnapshotComparedFile("./", "Compared", -1, "./LuaMemRefInfo-All-[1-Before].txt", "./LuaMemRefInfo-All-[2-After].txt")
mri.m_cBases.OutputFilteredResult("./LuaMemRefInfo-All-[2-After].txt", "Author", true, true)
mri.m_cBases.OutputFilteredResult("./LuaMemRefInfo-All-[2-After].txt", "Author", false, true)
print("Dump memory snapshot information finished!")
