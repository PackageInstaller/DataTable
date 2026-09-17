local downloadedfiles = class("downloadedfiles")

function downloadedfiles:ctor()
	self._list = {}
	self._hash = {}
	self._dirty = false
end

function downloadedfiles:initial(arg_2_1)
	self._hash = {}
	self._list = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(self._list) do
		self._hash[iter_2_1] = true
	end
end

function downloadedfiles:add(arg_3_1)
	if self._hash[arg_3_1] then
		return
	end

	table.insert(self._list, arg_3_1)

	self._hash[arg_3_1] = true
	self._dirty = true
end

function downloadedfiles:isFileExist(arg_4_1)
	return self._hash[arg_4_1]
end

function downloadedfiles:queryAll()
	self._dirty = false

	return self._list
end

function downloadedfiles:needUpdate()
	return self._dirty
end

return downloadedfiles
