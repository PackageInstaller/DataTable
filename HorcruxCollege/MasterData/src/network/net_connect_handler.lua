local crypt = require("crypt")
local var_0_1 = "l2_hcollege_handshake"
local var_0_2

return {
	connect = function(arg_1_0, arg_1_1)
		local var_1_0 = crypt.base64encode("LOGIN")
		local var_1_1
		local var_1_2

		local function var_1_3(arg_2_0)
			if arg_2_0.result ~= 1 then
				arg_1_1(0)
			end

			local var_2_0 = crypt.hmac64(var_1_1, (crypt.dhsecret(var_1_2, (crypt.base64decode(arg_2_0.msg)))))

			arg_1_0:rpc("handshake", {
				msg = var_0_1,
				type = var_1_0,
				token = crypt.base64encode(var_2_0)
			}, function(arg_3_0)
				if arg_3_0.result == 1 then
					var_0_2 = var_2_0

					arg_1_1(1)
				else
					arg_1_1(0)
				end
			end)
		end

		local function var_1_4(arg_4_0)
			if arg_4_0.result ~= 1 then
				arg_1_1(0)
			end

			var_1_1 = crypt.base64decode(arg_4_0.msg)
			var_1_2 = crypt.randomkey()

			arg_1_0:rpc("handshake", {
				msg = var_0_1,
				type = var_1_0,
				token = crypt.base64encode(var_1_2)
			}, var_1_3)
		end

		;(function()
			arg_1_0:rpc("handshake", {
				msg = var_0_1,
				type = var_1_0
			}, var_1_4)
		end)()
	end,
	reconnect = function(self, arg_6_1, arg_6_2)
		self:rpc("handshake", {
			msg = var_0_1,
			type = crypt.base64encode("RECONNECT"),
			token = string.format("%s@%s", crypt.base64encode(var_0_2), crypt.base64encode(tostring(arg_6_1)))
		}, arg_6_2)
	end
}
