local var_0_0 = {
	VSN_42_PASSPORT_ID = 20023,
	PASSPORT_USER_LEVEL = {
		FULL_LEVEL = 202,
		BASE_LEVEL = 201,
		NOT_BUY = 0
	},
	PASSPORT_ALL_TYPE = {
		DEFAULT = "default",
		VSN_42 = "vsn_42"
	},
	PASSPORT_USER_TYPE = {
		NORMAL = "normal",
		RETURN = "return"
	},
	PASSPORT_ALL_PAY_ID = {
		default = {
			normal = {
				201,
				202,
				203
			},
			["return"] = {
				211,
				212,
				213
			}
		},
		vsn_42 = {
			normal = {
				221,
				222,
				223
			},
			["return"] = {
				231,
				232,
				233
			}
		}
	},
	PASSPORT_RETURN_DISCOUNT_TRANS = {
		[232] = 212,
		[233] = 213,
		[231] = 211
	}
}

function var_0_0.GetReturnDiscountTransPayID(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if var_0_0.PASSPORT_RETURN_DISCOUNT_TRANS[arg_1_1] then
		var_1_0 = var_0_0.PASSPORT_RETURN_DISCOUNT_TRANS[arg_1_1]
	end

	return var_1_0
end

return var_0_0
