local var_0_0 = {}
local var_0_1 = {
	["88f1de1bd24c50e10da8fee80807a131"] = true,
	["915e46ff1db75c05efc5170c51009acf"] = true,
	f62de093082aa76474eb485d868c7517 = true,
	["596e444083ac8b0ea8f4e810a5985473"] = true,
	e90a535109fa08ea49316d581a016f6b = true,
	["0581d23b6c33e9c397b8b0786e01472a"] = true,
	["3a1333dd56cc2b83467669202e0b6ebc"] = true,
	fe2d3ee9d5ba415a4d6c4bc0c3cc0e58 = true,
	db88c0e863e92fc1d7fe7c92e339388d = true,
	c2a6acb33ee52063d2adaa77d6304afd = true,
	c3be77edf652df0f3bfb5d5ef1faefd0 = true,
	caec911e5c74a357e2719c6276220391 = true,
	dd2e6bf29b56730be0518bb23d26c2f3 = true,
	d5515559465b4398dcea8cc3e414cf6b = true,
	c6b369c71d96bf519743bdd5a5e6e775 = true,
	["38e40c2eb94b5f61c1b0de9e08a5bdc0"] = true,
	af3b130d82ce4a6a5aa375ac7734f9c7 = true,
	c11804063d92443f4bd9de2f4a0e231b = true,
	a78ea1ad7e61dd745efef7895c90470f = true,
	["7eed25f8eda1a67a421c99aeec4a8a32"] = true,
	["1d7f455e1177a84ff11f4b04129d30a7"] = true,
	c0d05a8a82d9f29de85bc4340f1d65ce = true,
	["91f2cf52838c04929f0ede8fec7d5476"] = true,
	["33dadd85a442b5eacde991555d374aee"] = true,
	a55abad4fc71622bd8a3c26945259cc5 = true,
	["76d46f04588e6c63b28f1926af975d53"] = true,
	b9c3f10a0e777281d892aaaf8f1ba303 = true,
	["1a19e15e1f4756ed26541a78b699881a"] = true,
	["20062ff666fef95433cedd1a5fe39ec4"] = true,
	ec07dbd02a29c942c960fe6e939ad067 = true,
	["9f082db22af15819d6d5054007bf1786"] = true,
	bf6eb3a6bd3d6de94117f34b033078be = true,
	["5492dd1eef8a4f8181f945dc019c7007"] = true,
	["7a289a100691a96bec4a0420a1bdb642"] = true,
	["09f1274758550e1755cdae0cda160b73"] = true,
	["19dc434f6eab65358b0d9442483b7dc2"] = true,
	["3b623e23c7e1435a5b93a0c1dd8a946a"] = true,
	["0763c82a962b17253170ac9e0667defb"] = true
}

function var_0_0.canPurchases()
	if DeviceManager.platform ~= "ios" then
		return false
	end

	if not var_0_1[require("controller.account_manager"):getUserID()] then
		return false
	end

	return AOKIPurchases ~= nil
end

function var_0_0.initAOKIPurchases()
	AOKIPurchases.initAOKIPurchases()
end

function var_0_0.startPurchases(arg_3_0, arg_3_1)
	AOKIPurchases.startPurchases(arg_3_0, arg_3_1)
end

function var_0_0.finishPurchases(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	AOKIPurchases.finishPurchases(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.registerPurchasesVerifyHandler(arg_5_0)
	AOKIPurchases.registerEventHandler(AOKIPurchases.EventType.AOKIVERIFY, arg_5_0)
end

function var_0_0.registerPurchasesHandler(arg_6_0)
	AOKIPurchases.registerEventHandler(AOKIPurchases.EventType.AOKIPURCHASES, arg_6_0)
end

return var_0_0
