local WSAnim = class("WSAnim", import("...BaseEntity"))

WSAnim.Fields = {
	caches = "table"
}

function WSAnim:Setup()
	self.caches = {}

	return
end

function WSAnim:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.caches) do
		iter_2_1:Dispose()
	end

	self:Clear()

	return
end

function WSAnim:GetAnim(arg_3_1)
	return self.caches[arg_3_1]
end

function WSAnim:SetAnim(arg_4_1, arg_4_2)
	self.caches[arg_4_1] = arg_4_2

	return
end

function WSAnim:Stop()
	for iter_5_0, iter_5_1 in pairs(self.caches) do
		if iter_5_1.playing then
			iter_5_1:Stop()
		end
	end

	return
end

return WSAnim
