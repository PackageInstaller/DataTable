return {
	Play301011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 301011001
		arg_1_1.duration_ = 5.37

		local var_1_0 = {
			zh = 5.366,
			ja = 5.3
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play301011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effectwuyishizhuangtai

				if not arg_1_1.var_.effectwuyishizhuangtai then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blckspace2"), manager.ui.mainCamera.transform)
					var_4_9.name = "wuyishizhuangtai"
					arg_1_1.var_.effectwuyishizhuangtai = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9000)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_11 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_4_9.transform.localScale = Vector3.New(var_4_9.transform.localScale.x * var_4_11, var_4_9.transform.localScale.y * var_4_11, var_4_9.transform.localScale.z * var_4_11)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.225

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:GetWordFromCfg(301011001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 9 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 9)

				if (9 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 9)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011001", "story_v_out_301011.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_301011", "301011001", "story_v_out_301011.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_301011", "301011001", "story_v_out_301011.awb")

						arg_1_1:RecordAudio("301011001", var_4_21)
						arg_1_1:RecordAudio("301011001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_301011", "301011001", "story_v_out_301011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_301011", "301011001", "story_v_out_301011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play301011002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 301011002
		arg_7_1.duration_ = 3.27

		local var_7_0 = {
			zh = 3.266,
			ja = 3.066
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play301011003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.225

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:GetWordFromCfg(301011002)
				local var_10_2 = arg_7_1:FormatText(var_10_1.content)

				arg_7_1.text_.text = var_10_2

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 9 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 9)

				if (9 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_2) / 9)) > 0 and var_10_0 < var_10_4 then
					arg_7_1.talkMaxDuration = var_10_4

					if var_10_4 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_4 + 0
					end
				end

				arg_7_1.text_.text = var_10_2
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011002", "story_v_out_301011.awb") ~= 0 then
					local var_10_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011002", "story_v_out_301011.awb") / 1000

					if var_10_5 + 0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + 0
					end

					if var_10_1.prefab_name ~= "" and arg_7_1.actors_[var_10_1.prefab_name] ~= nil then
						local var_10_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_1.prefab_name].transform, "story_v_out_301011", "301011002", "story_v_out_301011.awb")

						arg_7_1:RecordAudio("301011002", var_10_6)
						arg_7_1:RecordAudio("301011002", var_10_6)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_301011", "301011002", "story_v_out_301011.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_301011", "301011002", "story_v_out_301011.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_0, arg_7_1.talkMaxDuration)

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - 0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= 0 + var_10_7 and arg_7_1.time_ < 0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play301011003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 301011003
		arg_11_1.duration_ = 2.8

		local var_11_0 = {
			zh = 1.9,
			ja = 2.8
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play301011004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.175

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:GetWordFromCfg(301011003)
				local var_14_2 = arg_11_1:FormatText(var_14_1.content)

				arg_11_1.text_.text = var_14_2

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 7 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 7)

				if (7 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_2) / 7)) > 0 and var_14_0 < var_14_4 then
					arg_11_1.talkMaxDuration = var_14_4

					if var_14_4 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_4 + 0
					end
				end

				arg_11_1.text_.text = var_14_2
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011003", "story_v_out_301011.awb") ~= 0 then
					local var_14_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011003", "story_v_out_301011.awb") / 1000

					if var_14_5 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_5 + 0
					end

					if var_14_1.prefab_name ~= "" and arg_11_1.actors_[var_14_1.prefab_name] ~= nil then
						local var_14_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_1.prefab_name].transform, "story_v_out_301011", "301011003", "story_v_out_301011.awb")

						arg_11_1:RecordAudio("301011003", var_14_6)
						arg_11_1:RecordAudio("301011003", var_14_6)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_301011", "301011003", "story_v_out_301011.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_301011", "301011003", "story_v_out_301011.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_7 and arg_11_1.time_ < 0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play301011004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 301011004
		arg_15_1.duration_ = 3.8

		local var_15_0 = {
			zh = 3.8,
			ja = 3.233
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play301011005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.25

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:GetWordFromCfg(301011004)
				local var_18_2 = arg_15_1:FormatText(var_18_1.content)

				arg_15_1.text_.text = var_18_2

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 10 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 10)

				if (10 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_2) / 10)) > 0 and var_18_0 < var_18_4 then
					arg_15_1.talkMaxDuration = var_18_4

					if var_18_4 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_4 + 0
					end
				end

				arg_15_1.text_.text = var_18_2
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011004", "story_v_out_301011.awb") ~= 0 then
					local var_18_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011004", "story_v_out_301011.awb") / 1000

					if var_18_5 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + 0
					end

					if var_18_1.prefab_name ~= "" and arg_15_1.actors_[var_18_1.prefab_name] ~= nil then
						local var_18_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_1.prefab_name].transform, "story_v_out_301011", "301011004", "story_v_out_301011.awb")

						arg_15_1:RecordAudio("301011004", var_18_6)
						arg_15_1:RecordAudio("301011004", var_18_6)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_301011", "301011004", "story_v_out_301011.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_301011", "301011004", "story_v_out_301011.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play301011005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 301011005
		arg_19_1.duration_ = 1

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"

			SetActive(arg_19_1.choicesGo_, true)

			for iter_20_0, iter_20_1 in ipairs(arg_19_1.choices_) do
				SetActive(iter_20_1.go, iter_20_0 <= 2)
			end

			arg_19_1.choices_[1].txt.text = arg_19_1:FormatText(StoryChoiceCfg[1711].name)
			arg_19_1.choices_[2].txt.text = arg_19_1:FormatText(StoryChoiceCfg[1712].name)
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play301011006(arg_19_1)
			end

			if arg_21_0 == 2 then
				arg_19_0:Play301011006(arg_19_1)
			end

			arg_19_1:RecordChoiceLog(301011005, 1711, 1712)
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.allBtn_.enabled = false
			end

			if arg_19_1.time_ >= 0 + 1 and arg_19_1.time_ < 0 + 1 + arg_22_0 then
				arg_19_1.allBtn_.enabled = true
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play301011006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 301011006
		arg_23_1.duration_ = 7

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play301011007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_9000

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_0 = arg_23_1.bgs_.STblack

				arg_23_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_1 = var_26_0:GetComponent("SpriteRenderer")

				if var_26_1 and var_26_1.sprite then
					local var_26_2 = 2 * (var_26_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_0.transform.localScale = Vector3.New(var_26_2 / var_26_1.sprite.bounds.size.y < var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x and var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x or var_26_2 / var_26_1.sprite.bounds.size.y, var_26_2 / var_26_1.sprite.bounds.size.y < var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x and var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x or var_26_2 / var_26_1.sprite.bounds.size.y, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "STblack" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_3 = 2

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.allBtn_.enabled = false
			end

			if arg_23_1.time_ >= var_26_3 + 0.3 and arg_23_1.time_ < var_26_3 + 0.3 + arg_26_0 then
				arg_23_1.allBtn_.enabled = true
			end

			local var_26_4 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = false

				arg_23_1:SetGaussion(false)
			end

			local var_26_5 = 1

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_5 then
				local var_26_6 = Color.New(1, 1, 1)

				var_26_6.a = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_4) / var_26_5)
				arg_23_1.mask_.color = var_26_6
			end

			if arg_23_1.time_ >= var_26_4 + var_26_5 and arg_23_1.time_ < var_26_4 + var_26_5 + arg_26_0 then
				local var_26_7 = Color.New(1, 1, 1)

				arg_23_1.mask_.enabled = false
				var_26_7.a = 0
				arg_23_1.mask_.color = var_26_7
			end

			if 0.1 < arg_23_1.time_ and arg_23_1.time_ <= 0.1 + arg_26_0 then
				if arg_23_1.var_.effectwuyishizhuangtai then
					Object.Destroy(arg_23_1.var_.effectwuyishizhuangtai)

					arg_23_1.var_.effectwuyishizhuangtai = nil
				end
			end

			if 0.1 < arg_23_1.time_ and arg_23_1.time_ <= 0.1 + arg_26_0 then
				local var_26_9 = arg_23_1.var_.effectwuyishizhuangtai2

				if not arg_23_1.var_.effectwuyishizhuangtai2 then
					var_26_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error03_keep"), manager.ui.mainCamera.transform)
					var_26_9.name = "wuyishizhuangtai2"
					arg_23_1.var_.effectwuyishizhuangtai2 = var_26_9
				else
					var_26_9.transform:SetParent(var_26_9000)
				end

				var_26_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_26_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_26_11 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_26_9.transform.localScale = Vector3.New(var_26_9.transform.localScale.x * var_26_11, var_26_9.transform.localScale.y * var_26_11, var_26_9.transform.localScale.z * var_26_11)
			end

			if 1.2 < arg_23_1.time_ and arg_23_1.time_ <= 1.2 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_140", "se_story_140_glass", "")
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_13 = 2
			local var_26_14 = 0.75

			if 2 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_15 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_15:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_16 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(301011006).content)

				arg_23_1.text_.text = var_26_16

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_18 = 30 <= 0 and var_26_14 or var_26_14 * (utf8.len(var_26_16) / 30)

				if (30 <= 0 and var_26_14 or var_26_14 * (utf8.len(var_26_16) / 30)) > 0 and var_26_14 < var_26_18 then
					arg_23_1.talkMaxDuration = var_26_18
					var_26_13 = var_26_13 + 0.3

					if var_26_18 + var_26_13 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_18 + var_26_13
					end
				end

				arg_23_1.text_.text = var_26_16
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_19 = var_26_13 + 0.3
			local var_26_20 = math.max(var_26_14, arg_23_1.talkMaxDuration)

			if var_26_13 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_19 + var_26_20 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_19) / var_26_20

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_19 + var_26_20 and arg_23_1.time_ < var_26_19 + var_26_20 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play301011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 301011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play301011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(301011007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 40 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 40)

				if (40 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 40)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play301011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 301011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play301011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.9

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(301011008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 36 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 36)

				if (36 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 36)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play301011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 301011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play301011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(301011009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 40 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 40)

				if (40 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 40)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play301011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 301011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play301011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0.2 < arg_41_1.time_ and arg_41_1.time_ <= 0.2 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_152", "se_story_152_amb_electrocardiogram_up", "")
			end

			if 0.2 < arg_41_1.time_ and arg_41_1.time_ <= 0.2 + arg_44_0 then
				arg_41_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_44_2 = 0
			local var_44_3 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(301011010).content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 11 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 11)

				if (11 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_4) / 11)) > 0 and var_44_3 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_7 and arg_41_1.time_ < var_44_2 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play301011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 301011011
		arg_45_1.duration_ = 1.6

		local var_45_0 = {
			zh = 1.5,
			ja = 1.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play301011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.125

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(301011011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 5 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 5)

				if (5 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 5)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011011", "story_v_out_301011.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011011", "story_v_out_301011.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_301011", "301011011", "story_v_out_301011.awb")

						arg_45_1:RecordAudio("301011011", var_48_6)
						arg_45_1:RecordAudio("301011011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_301011", "301011011", "story_v_out_301011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_301011", "301011011", "story_v_out_301011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play301011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 301011012
		arg_49_1.duration_ = 8.07

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play301011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_9000

			if arg_49_1.bgs_.XH0504 == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0504")
				var_52_0.name = "XH0504"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.XH0504 = var_52_0
			end

			if 1.06666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 1.06666666666667 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.XH0504

				arg_49_1.bgs_.XH0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "XH0504" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 3.06666666666667

			if 3.06666666666667 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_4 + 0.3 and arg_49_1.time_ < var_52_4 + 0.3 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			if 0.633333333333333 < arg_49_1.time_ and arg_49_1.time_ <= 0.633333333333333 + arg_52_0 then
				if arg_49_1.var_.effectwuyishizhuangtai2 then
					Object.Destroy(arg_49_1.var_.effectwuyishizhuangtai2)

					arg_49_1.var_.effectwuyishizhuangtai2 = nil
				end
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_6 = arg_49_1.var_.effectwuyishizhuangtai3

				if not arg_49_1.var_.effectwuyishizhuangtai3 then
					var_52_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_52_6.name = "wuyishizhuangtai3"
					arg_49_1.var_.effectwuyishizhuangtai3 = var_52_6
				else
					var_52_6.transform:SetParent(var_52_9000)
				end

				var_52_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_52_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_52_8 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_52_6.transform.localScale = Vector3.New(var_52_6.transform.localScale.x * var_52_8, var_52_6.transform.localScale.y * var_52_8, var_52_6.transform.localScale.z * var_52_8)
			end

			local var_52_9 = arg_49_1.bgs_.XH0504.transform

			if 1.06666666666667 < arg_49_1.time_ and arg_49_1.time_ <= 1.06666666666667 + arg_52_0 then
				arg_49_1.var_.moveOldPosXH0504 = var_52_9.localPosition
			end

			local var_52_10 = 1.93333333333333

			if 1.06666666666667 <= arg_49_1.time_ and arg_49_1.time_ < 1.06666666666667 + var_52_10 then
				var_52_9.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPosXH0504, Vector3.New(0, 1, 10), (arg_49_1.time_ - 1.06666666666667) / var_52_10)
			end

			if arg_49_1.time_ >= 1.06666666666667 + var_52_10 and arg_49_1.time_ < 1.06666666666667 + var_52_10 + arg_52_0 then
				var_52_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_52_11 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_12 = 0.633333333333333

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_12 then
				local var_52_13 = Color.New(0, 0, 0)

				var_52_13.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_11) / var_52_12)
				arg_49_1.mask_.color = var_52_13
			end

			if arg_49_1.time_ >= var_52_11 + var_52_12 and arg_49_1.time_ < var_52_11 + var_52_12 + arg_52_0 then
				local var_52_14 = Color.New(0, 0, 0)

				var_52_14.a = 1
				arg_49_1.mask_.color = var_52_14
			end

			local var_52_15 = 0.633333333333333

			if 0.633333333333333 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_16 = 0.633333333333333

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 then
				local var_52_17 = Color.New(0, 0, 0)

				var_52_17.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_15) / var_52_16)
				arg_49_1.mask_.color = var_52_17
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 then
				local var_52_18 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_18.a = 0
				arg_49_1.mask_.color = var_52_18
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_19 = 3.06666666666667
			local var_52_20 = 1.575

			if 3.06666666666667 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_21 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_21:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_22 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(301011012).content)

				arg_49_1.text_.text = var_52_22

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_24 = 63 <= 0 and var_52_20 or var_52_20 * (utf8.len(var_52_22) / 63)

				if (63 <= 0 and var_52_20 or var_52_20 * (utf8.len(var_52_22) / 63)) > 0 and var_52_20 < var_52_24 then
					arg_49_1.talkMaxDuration = var_52_24
					var_52_19 = var_52_19 + 0.3

					if var_52_24 + var_52_19 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_24 + var_52_19
					end
				end

				arg_49_1.text_.text = var_52_22
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = var_52_19 + 0.3
			local var_52_26 = math.max(var_52_20, arg_49_1.talkMaxDuration)

			if var_52_19 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_25) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "XH0504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.93333333333333,
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 4),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play301011013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 301011013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play301011014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(301011013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 40 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 40)

				if (40 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 40)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play301011014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 301011014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play301011015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(301011014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 80 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 80)

				if (80 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 80)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play301011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 301011015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play301011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.85

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(301011015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 74 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 74)

				if (74 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 74)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play301011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 301011016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play301011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.1

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(301011016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 4 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 4)

				if (4 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 4)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play301011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 301011017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play301011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 1 < arg_71_1.time_ and arg_71_1.time_ <= 1 + arg_74_0 then
				arg_71_1:AudioAction("stop", "effect", "se_story_152", "se_story_152_amb_electrocardiogram", "")
			end

			local var_74_1 = 0
			local var_74_2 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(301011017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 8 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 8)

				if (8 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 8)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play301011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 301011018
		arg_75_1.duration_ = 9

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play301011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_9003
			local var_78_9002
			local var_78_9001
			local var_78_9000

			if arg_75_1.bgs_.ST07b == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07b")
				var_78_0.name = "ST07b"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.ST07b = var_78_0
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.ST07b

				arg_75_1.bgs_.ST07b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "ST07b" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = 4

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_4 + 0.3 and arg_75_1.time_ < var_78_4 + 0.3 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_5 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_6 = 2

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = Color.New(0, 0, 0)

				var_78_7.a = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_5) / var_78_6)
				arg_75_1.mask_.color = var_78_7
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 then
				local var_78_8 = Color.New(0, 0, 0)

				var_78_8.a = 1
				arg_75_1.mask_.color = var_78_8
			end

			local var_78_9 = 2

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_10 = 2

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				local var_78_11 = Color.New(0, 0, 0)

				var_78_11.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_9) / var_78_10)
				arg_75_1.mask_.color = var_78_11
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				local var_78_12 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_12.a = 0
				arg_75_1.mask_.color = var_78_12
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_13 = arg_75_1.var_.effectansebeijing1

				if not arg_75_1.var_.effectansebeijing1 then
					var_78_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_black"), manager.ui.mainCamera.transform)
					var_78_13.name = "ansebeijing1"
					arg_75_1.var_.effectansebeijing1 = var_78_13
				else
					var_78_13.transform:SetParent(var_78_9003)
				end

				var_78_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_15 = arg_75_1.var_.effectansebeijing2

				if not arg_75_1.var_.effectansebeijing2 then
					var_78_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_starheart"), manager.ui.mainCamera.transform)
					var_78_15.name = "ansebeijing2"
					arg_75_1.var_.effectansebeijing2 = var_78_15
				else
					var_78_15.transform:SetParent(var_78_9002)
				end

				var_78_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= 1.2 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= 1.2 + arg_78_0 then
				arg_75_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_interrogation_p2", "")
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_19 = arg_75_1.var_.effectanse

				if not arg_75_1.var_.effectanse then
					var_78_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_78_19.name = "anse"
					arg_75_1.var_.effectanse = var_78_19
				else
					var_78_19.transform:SetParent(var_78_9001)
				end

				var_78_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				local var_78_21 = arg_75_1.var_.effectanse2

				if not arg_75_1.var_.effectanse2 then
					var_78_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_78_21.name = "anse2"
					arg_75_1.var_.effectanse2 = var_78_21
				else
					var_78_21.transform:SetParent(var_78_9000)
				end

				var_78_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_78_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_23 = 4
			local var_78_24 = 1.925

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_23 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_25 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_25:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_26 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(301011018).content)

				arg_75_1.text_.text = var_78_26

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_28 = 77 <= 0 and var_78_24 or var_78_24 * (utf8.len(var_78_26) / 77)

				if (77 <= 0 and var_78_24 or var_78_24 * (utf8.len(var_78_26) / 77)) > 0 and var_78_24 < var_78_28 then
					arg_75_1.talkMaxDuration = var_78_28
					var_78_23 = var_78_23 + 0.3

					if var_78_28 + var_78_23 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_28 + var_78_23
					end
				end

				arg_75_1.text_.text = var_78_26
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_29 = var_78_23 + 0.3
			local var_78_30 = math.max(var_78_24, arg_75_1.talkMaxDuration)

			if var_78_23 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_29 + var_78_30 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_29) / var_78_30

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_29 + var_78_30 and arg_75_1.time_ < var_78_29 + var_78_30 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play301011019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 301011019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play301011020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.125

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(301011019).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 45 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 45)

				if (45 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 45)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play301011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 301011020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play301011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(301011020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 40 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 40)

				if (40 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 40)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play301011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 301011021
		arg_89_1.duration_ = 4.6

		local var_89_0 = {
			zh = 2.766,
			ja = 4.6
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play301011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.375

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(301011021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 15 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 15)

				if (15 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 15)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011021", "story_v_out_301011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011021", "story_v_out_301011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_301011", "301011021", "story_v_out_301011.awb")

						arg_89_1:RecordAudio("301011021", var_92_6)
						arg_89_1:RecordAudio("301011021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_301011", "301011021", "story_v_out_301011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_301011", "301011021", "story_v_out_301011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play301011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 301011022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play301011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.6

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(301011022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 64 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 64)

				if (64 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 64)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play301011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 301011023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play301011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.25

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(301011023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 10 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 10)

				if (10 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 10)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play301011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 301011024
		arg_101_1.duration_ = 1.47

		local var_101_0 = {
			zh = 1.166,
			ja = 1.466
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play301011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(301011024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 2 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 2)

				if (2 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 2)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011024", "story_v_out_301011.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011024", "story_v_out_301011.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_301011", "301011024", "story_v_out_301011.awb")

						arg_101_1:RecordAudio("301011024", var_104_6)
						arg_101_1:RecordAudio("301011024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_301011", "301011024", "story_v_out_301011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_301011", "301011024", "story_v_out_301011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play301011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 301011025
		arg_105_1.duration_ = 5.6

		local var_105_0 = {
			zh = 4.033,
			ja = 5.6
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play301011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(301011025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)

				if (14 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 14)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011025", "story_v_out_301011.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011025", "story_v_out_301011.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_301011", "301011025", "story_v_out_301011.awb")

						arg_105_1:RecordAudio("301011025", var_108_6)
						arg_105_1:RecordAudio("301011025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_301011", "301011025", "story_v_out_301011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_301011", "301011025", "story_v_out_301011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play301011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 301011026
		arg_109_1.duration_ = 6.77

		local var_109_0 = {
			zh = 5.466,
			ja = 6.766
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play301011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.45

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(301011026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 18 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 18)

				if (18 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 18)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011026", "story_v_out_301011.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011026", "story_v_out_301011.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_301011", "301011026", "story_v_out_301011.awb")

						arg_109_1:RecordAudio("301011026", var_112_6)
						arg_109_1:RecordAudio("301011026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_301011", "301011026", "story_v_out_301011.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_301011", "301011026", "story_v_out_301011.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play301011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 301011027
		arg_113_1.duration_ = 4

		local var_113_0 = {
			zh = 4,
			ja = 3.266
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play301011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(301011027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 14)

				if (14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 14)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011027", "story_v_out_301011.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011027", "story_v_out_301011.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_301011", "301011027", "story_v_out_301011.awb")

						arg_113_1:RecordAudio("301011027", var_116_6)
						arg_113_1:RecordAudio("301011027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_301011", "301011027", "story_v_out_301011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_301011", "301011027", "story_v_out_301011.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play301011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 301011028
		arg_117_1.duration_ = 5.67

		local var_117_0 = {
			zh = 3.5,
			ja = 5.666
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play301011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.375

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(301011028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 15 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 15)

				if (15 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 15)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011028", "story_v_out_301011.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011028", "story_v_out_301011.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_301011", "301011028", "story_v_out_301011.awb")

						arg_117_1:RecordAudio("301011028", var_120_6)
						arg_117_1:RecordAudio("301011028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_301011", "301011028", "story_v_out_301011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_301011", "301011028", "story_v_out_301011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play301011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 301011029
		arg_121_1.duration_ = 8.73

		local var_121_0 = {
			zh = 6.366,
			ja = 8.733
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play301011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.6

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(301011029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 24 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 24)

				if (24 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 24)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011029", "story_v_out_301011.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011029", "story_v_out_301011.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_301011", "301011029", "story_v_out_301011.awb")

						arg_121_1:RecordAudio("301011029", var_124_6)
						arg_121_1:RecordAudio("301011029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_301011", "301011029", "story_v_out_301011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_301011", "301011029", "story_v_out_301011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play301011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 301011030
		arg_125_1.duration_ = 4.7

		local var_125_0 = {
			zh = 4.6,
			ja = 4.7
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play301011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.475

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(301011030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 19 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 19)

				if (19 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 19)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011030", "story_v_out_301011.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011030", "story_v_out_301011.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_301011", "301011030", "story_v_out_301011.awb")

						arg_125_1:RecordAudio("301011030", var_128_6)
						arg_125_1:RecordAudio("301011030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_301011", "301011030", "story_v_out_301011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_301011", "301011030", "story_v_out_301011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play301011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 301011031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play301011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.6

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(301011031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 64 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 64)

				if (64 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 64)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play301011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 301011032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play301011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(301011032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 14 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 14)

				if (14 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 14)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play301011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 301011033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play301011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(301011033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 28 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 28)

				if (28 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 28)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play301011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 301011034
		arg_141_1.duration_ = 1

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"

			SetActive(arg_141_1.choicesGo_, true)

			for iter_142_0, iter_142_1 in ipairs(arg_141_1.choices_) do
				SetActive(iter_142_1.go, iter_142_0 <= 2)
			end

			arg_141_1.choices_[1].txt.text = arg_141_1:FormatText(StoryChoiceCfg[1713].name)
			arg_141_1.choices_[2].txt.text = arg_141_1:FormatText(StoryChoiceCfg[1714].name)
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play301011035(arg_141_1)
			end

			if arg_143_0 == 2 then
				arg_141_0:Play301011035(arg_141_1)
			end

			arg_141_1:RecordChoiceLog(301011034, 1713, 1714)
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= 0 + 0.666666666666667 and arg_141_1.time_ < 0 + 0.666666666666667 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play301011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 301011035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play301011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.125

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(301011035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 5)

				if (5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 5)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play301011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 301011036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play301011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.525

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(301011036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 61 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 61)

				if (61 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 61)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play301011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 301011037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play301011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.925

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(301011037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 37)

				if (37 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 37)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play301011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 301011038
		arg_157_1.duration_ = 9.47

		local var_157_0 = {
			zh = 8.366,
			ja = 9.466
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play301011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_160_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_157_1.stage_.transform)

				var_160_0.name = "10066ui_story"
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["10066ui_story"] = var_160_0

				local var_160_1 = var_160_0:GetComponentInChildren(typeof(CharacterEffect))

				var_160_1.enabled = true

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end

				arg_157_1:ShowWeapon(var_160_1.transform, false)

				arg_157_1.var_["10066ui_story" .. "Animator"] = var_160_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_157_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_157_1.var_["10066ui_story" .. "LipSync"] = var_160_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_160_3 = arg_157_1.actors_["10066ui_story"].transform

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= 1.6 + arg_160_0 then
				arg_157_1.var_.moveOldPos10066ui_story = var_160_3.localPosition
			end

			local var_160_4 = 0.001

			if 1.6 <= arg_157_1.time_ and arg_157_1.time_ < 1.6 + var_160_4 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_157_1.time_ - 1.6) / var_160_4)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 1.6 + var_160_4 and arg_157_1.time_ < 1.6 + var_160_4 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			local var_160_5 = arg_157_1.actors_["10066ui_story"]

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= 1.6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10066ui_story == nil then
				arg_157_1.var_.characterEffect10066ui_story = var_160_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if 1.6 <= arg_157_1.time_ and arg_157_1.time_ < 1.6 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.characterEffect10066ui_story and not isNil(var_160_5) then
					arg_157_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 1.6 + var_160_6 and arg_157_1.time_ < 1.6 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.characterEffect10066ui_story then
				arg_157_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= 1.6 + arg_160_0 then
				arg_157_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= 1.6 + arg_160_0 then
				arg_157_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0.983333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 0.983333333333333 + arg_160_0 then
				if arg_157_1.var_.effectansebeijing2 then
					Object.Destroy(arg_157_1.var_.effectansebeijing2)

					arg_157_1.var_.effectansebeijing2 = nil
				end
			end

			if 0.983333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 0.983333333333333 + arg_160_0 then
				if arg_157_1.var_.effectanse then
					Object.Destroy(arg_157_1.var_.effectanse)

					arg_157_1.var_.effectanse = nil
				end
			end

			if 0.983333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 0.983333333333333 + arg_160_0 then
				if arg_157_1.var_.effectanse2 then
					Object.Destroy(arg_157_1.var_.effectanse2)

					arg_157_1.var_.effectanse2 = nil
				end
			end

			local var_160_11 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_12 = 1

			if var_160_11 <= arg_157_1.time_ and arg_157_1.time_ < var_160_11 + var_160_12 then
				local var_160_13 = Color.New(0, 0, 0)

				var_160_13.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_11) / var_160_12)
				arg_157_1.mask_.color = var_160_13
			end

			if arg_157_1.time_ >= var_160_11 + var_160_12 and arg_157_1.time_ < var_160_11 + var_160_12 + arg_160_0 then
				local var_160_14 = Color.New(0, 0, 0)

				var_160_14.a = 1
				arg_157_1.mask_.color = var_160_14
			end

			local var_160_15 = 1

			if 1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_16 = 1

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_16 then
				local var_160_17 = Color.New(0, 0, 0)

				var_160_17.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_15) / var_160_16)
				arg_157_1.mask_.color = var_160_17
			end

			if arg_157_1.time_ >= var_160_15 + var_160_16 and arg_157_1.time_ < var_160_15 + var_160_16 + arg_160_0 then
				local var_160_18 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_18.a = 0
				arg_157_1.mask_.color = var_160_18
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_19 = 1.6
			local var_160_20 = 0.725

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_21 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_21:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_22 = arg_157_1:GetWordFromCfg(301011038)
				local var_160_23 = arg_157_1:FormatText(var_160_22.content)

				arg_157_1.text_.text = var_160_23

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_25 = 29 <= 0 and var_160_20 or var_160_20 * (utf8.len(var_160_23) / 29)

				if (29 <= 0 and var_160_20 or var_160_20 * (utf8.len(var_160_23) / 29)) > 0 and var_160_20 < var_160_25 then
					arg_157_1.talkMaxDuration = var_160_25
					var_160_19 = var_160_19 + 0.3

					if var_160_25 + var_160_19 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_25 + var_160_19
					end
				end

				arg_157_1.text_.text = var_160_23
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011038", "story_v_out_301011.awb") ~= 0 then
					local var_160_26 = manager.audio:GetVoiceLength("story_v_out_301011", "301011038", "story_v_out_301011.awb") / 1000

					if var_160_26 + var_160_19 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_26 + var_160_19
					end

					if var_160_22.prefab_name ~= "" and arg_157_1.actors_[var_160_22.prefab_name] ~= nil then
						local var_160_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_22.prefab_name].transform, "story_v_out_301011", "301011038", "story_v_out_301011.awb")

						arg_157_1:RecordAudio("301011038", var_160_27)
						arg_157_1:RecordAudio("301011038", var_160_27)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_301011", "301011038", "story_v_out_301011.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_301011", "301011038", "story_v_out_301011.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_28 = var_160_19 + 0.3
			local var_160_29 = math.max(var_160_20, arg_157_1.talkMaxDuration)

			if var_160_19 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_28 + var_160_29 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_28) / var_160_29

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_28 + var_160_29 and arg_157_1.time_ < var_160_28 + var_160_29 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play301011039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 301011039
		arg_163_1.duration_ = 9.6

		local var_163_0 = {
			zh = 5.366,
			ja = 9.6
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play301011040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10066ui_story = arg_163_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).z)
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles = arg_163_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_163_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10066ui_story"].transform.position).z)
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10066ui_story"].transform.localEulerAngles = arg_163_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_166_1 = 0
			local var_166_2 = 0.625

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(301011039)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 25 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 25)

				if (25 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 25)) > 0 and var_166_2 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011039", "story_v_out_301011.awb") ~= 0 then
					local var_166_7 = manager.audio:GetVoiceLength("story_v_out_301011", "301011039", "story_v_out_301011.awb") / 1000

					if var_166_7 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_1
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_301011", "301011039", "story_v_out_301011.awb")

						arg_163_1:RecordAudio("301011039", var_166_8)
						arg_163_1:RecordAudio("301011039", var_166_8)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_301011", "301011039", "story_v_out_301011.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_301011", "301011039", "story_v_out_301011.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_9 and arg_163_1.time_ < var_166_1 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play301011040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 301011040
		arg_167_1.duration_ = 7.63

		local var_167_0 = {
			zh = 5.266,
			ja = 7.633
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play301011041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_170_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_167_1.stage_.transform)

				var_170_0.name = "1084ui_story"
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1084ui_story"] = var_170_0

				local var_170_1 = var_170_0:GetComponentInChildren(typeof(CharacterEffect))

				var_170_1.enabled = true

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end

				arg_167_1:ShowWeapon(var_170_1.transform, false)

				arg_167_1.var_["1084ui_story" .. "Animator"] = var_170_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_167_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_167_1.var_["1084ui_story" .. "LipSync"] = var_170_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_170_3 = arg_167_1.actors_["1084ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["10066ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10066ui_story = var_170_5.localPosition
			end

			local var_170_6 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 then
				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_167_1.time_ - 0) / var_170_6)
				var_170_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_5.position).x, (manager.ui.mainCamera.transform.position - var_170_5.position).y, (manager.ui.mainCamera.transform.position - var_170_5.position).z)
				var_170_5.localEulerAngles.z = 0
				var_170_5.localEulerAngles.x = 0
				var_170_5.localEulerAngles = var_170_5.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_170_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_5.position).x, (manager.ui.mainCamera.transform.position - var_170_5.position).y, (manager.ui.mainCamera.transform.position - var_170_5.position).z)
				var_170_5.localEulerAngles.z = 0
				var_170_5.localEulerAngles.x = 0
				var_170_5.localEulerAngles = var_170_5.localEulerAngles
			end

			local var_170_7 = arg_167_1.actors_["1084ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.characterEffect1084ui_story == nil then
				arg_167_1.var_.characterEffect1084ui_story = var_170_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_8 and not isNil(var_170_7) then
				if arg_167_1.var_.characterEffect1084ui_story and not isNil(var_170_7) then
					arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_8 and arg_167_1.time_ < 0 + var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.characterEffect1084ui_story then
				arg_167_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_170_10 = arg_167_1.actors_["10066ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_10) and arg_167_1.var_.characterEffect10066ui_story == nil then
				arg_167_1.var_.characterEffect10066ui_story = var_170_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_11 and not isNil(var_170_10) then
				if arg_167_1.var_.characterEffect10066ui_story and not isNil(var_170_10) then
					arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_11)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_11 and arg_167_1.time_ < 0 + var_170_11 + arg_170_0 and not isNil(var_170_10) and arg_167_1.var_.characterEffect10066ui_story then
				arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_12 = 0
			local var_170_13 = 0.7

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(301011040)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 28 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 28)

				if (28 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 28)) > 0 and var_170_13 < var_170_17 then
					arg_167_1.talkMaxDuration = var_170_17

					if var_170_17 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011040", "story_v_out_301011.awb") ~= 0 then
					local var_170_18 = manager.audio:GetVoiceLength("story_v_out_301011", "301011040", "story_v_out_301011.awb") / 1000

					if var_170_18 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_12
					end

					if var_170_14.prefab_name ~= "" and arg_167_1.actors_[var_170_14.prefab_name] ~= nil then
						local var_170_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_14.prefab_name].transform, "story_v_out_301011", "301011040", "story_v_out_301011.awb")

						arg_167_1:RecordAudio("301011040", var_170_19)
						arg_167_1:RecordAudio("301011040", var_170_19)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_301011", "301011040", "story_v_out_301011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_301011", "301011040", "story_v_out_301011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_20 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_20 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_20

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_20 and arg_167_1.time_ < var_170_12 + var_170_20 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play301011041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 301011041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play301011042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1084ui_story = arg_171_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).z)
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles = arg_171_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1084ui_story"].transform.position).z)
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1084ui_story"].transform.localEulerAngles = arg_171_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10066ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10066ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, 100, 0)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["1084ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_3) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_3) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_4)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_174_5 = 0
			local var_174_6 = 1.025

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(301011041).content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 41 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 41)

				if (41 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_7) / 41)) > 0 and var_174_6 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_10 and arg_171_1.time_ < var_174_5 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play301011042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 301011042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play301011043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(301011042).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 44 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 44)

				if (44 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 44)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play301011043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 301011043
		arg_179_1.duration_ = 9

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play301011044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.bgs_.ST07 == nil then
				local var_182_0 = Object.Instantiate(arg_179_1.paintGo_)

				var_182_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST07")
				var_182_0.name = "ST07"
				var_182_0.transform.parent = arg_179_1.stage_.transform
				var_182_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.bgs_.ST07 = var_182_0
			end

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= 2 + arg_182_0 then
				local var_182_1 = arg_179_1.bgs_.ST07

				arg_179_1.bgs_.ST07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_182_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_2 = var_182_1:GetComponent("SpriteRenderer")

				if var_182_2 and var_182_2.sprite then
					local var_182_3 = 2 * (var_182_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_182_1.transform.localScale = Vector3.New(var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, var_182_3 / var_182_2.sprite.bounds.size.y < var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x and var_182_3 * manager.ui.mainCameraCom_.aspect / var_182_2.sprite.bounds.size.x or var_182_3 / var_182_2.sprite.bounds.size.y, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "ST07" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_182_4 = 4

			if 4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			if arg_179_1.time_ >= var_182_4 + 0.3 and arg_179_1.time_ < var_182_4 + 0.3 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_5 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_6 = 2

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_6 then
				local var_182_7 = Color.New(0, 0, 0)

				var_182_7.a = Mathf.Lerp(0, 1, (arg_179_1.time_ - var_182_5) / var_182_6)
				arg_179_1.mask_.color = var_182_7
			end

			if arg_179_1.time_ >= var_182_5 + var_182_6 and arg_179_1.time_ < var_182_5 + var_182_6 + arg_182_0 then
				local var_182_8 = Color.New(0, 0, 0)

				var_182_8.a = 1
				arg_179_1.mask_.color = var_182_8
			end

			local var_182_9 = 2

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_9 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = true

				arg_179_1:SetGaussion(false)
			end

			local var_182_10 = 2

			if var_182_9 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 then
				local var_182_11 = Color.New(0, 0, 0)

				var_182_11.a = Mathf.Lerp(1, 0, (arg_179_1.time_ - var_182_9) / var_182_10)
				arg_179_1.mask_.color = var_182_11
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 then
				local var_182_12 = Color.New(0, 0, 0)

				arg_179_1.mask_.enabled = false
				var_182_12.a = 0
				arg_179_1.mask_.color = var_182_12
			end

			if 2 < arg_179_1.time_ and arg_179_1.time_ <= 2 + arg_182_0 then
				if arg_179_1.var_.effectansebeijing1 then
					Object.Destroy(arg_179_1.var_.effectansebeijing1)

					arg_179_1.var_.effectansebeijing1 = nil
				end
			end

			if 1.2 < arg_179_1.time_ and arg_179_1.time_ <= 1.2 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if 0.2 < arg_179_1.time_ and arg_179_1.time_ <= 0.2 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0.2 < arg_179_1.time_ and arg_179_1.time_ <= 0.2 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_interrogation_p2", "")
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_17 = 4
			local var_182_18 = 1.3

			if 4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_19 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_19:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_20 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(301011043).content)

				arg_179_1.text_.text = var_182_20

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_22 = 52 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_20) / 52)

				if (52 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_20) / 52)) > 0 and var_182_18 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22
					var_182_17 = var_182_17 + 0.3

					if var_182_22 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_20
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_23 = var_182_17 + 0.3
			local var_182_24 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_24 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_24

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_24 and arg_179_1.time_ < var_182_23 + var_182_24 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play301011044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 301011044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play301011045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.825

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(301011044).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 73 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 73)

				if (73 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 73)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play301011045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 301011045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play301011046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1.65

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(301011045).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 66 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 66)

				if (66 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 66)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play301011046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 301011046
		arg_193_1.duration_ = 7.43

		local var_193_0 = {
			zh = 7.433,
			ja = 4.233
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play301011047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1084ui_story"]) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = arg_193_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1084ui_story"]) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(arg_193_1.actors_["1084ui_story"]) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1084ui_story"]) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_196_4 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_4 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_4

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_4
						arg_193_1.bgmTxt2_.text = var_196_4
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_5 = 0
			local var_196_6 = 0.05

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1084")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_7 = arg_193_1:GetWordFromCfg(301011046)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 2 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 2)

				if (2 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 2)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011046", "story_v_out_301011.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_301011", "301011046", "story_v_out_301011.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_301011", "301011046", "story_v_out_301011.awb")

						arg_193_1:RecordAudio("301011046", var_196_12)
						arg_193_1:RecordAudio("301011046", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_301011", "301011046", "story_v_out_301011.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_301011", "301011046", "story_v_out_301011.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play301011047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 301011047
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play301011048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = arg_198_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) then
				if arg_198_1.var_.characterEffect1084ui_story and not isNil(arg_198_1.actors_["1084ui_story"]) then
					arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1084ui_story"]) and arg_198_1.var_.characterEffect1084ui_story then
				arg_198_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.65

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(301011047).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 26 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 26)

				if (26 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 26)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play301011048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 301011048
		arg_202_1.duration_ = 1

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"

			SetActive(arg_202_1.choicesGo_, true)

			for iter_203_0, iter_203_1 in ipairs(arg_202_1.choices_) do
				SetActive(iter_203_1.go, iter_203_0 <= 3)
			end

			arg_202_1.choices_[1].txt.text = arg_202_1:FormatText(StoryChoiceCfg[1715].name)
			arg_202_1.choices_[2].txt.text = arg_202_1:FormatText(StoryChoiceCfg[1716].name)
			arg_202_1.choices_[3].txt.text = arg_202_1:FormatText(StoryChoiceCfg[1717].name)
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play301011049(arg_202_1)
			end

			if arg_204_0 == 2 then
				arg_202_0:Play301011050(arg_202_1)
			end

			if arg_204_0 == 3 then
				arg_202_0:Play301011051(arg_202_1)
			end

			arg_202_1:RecordChoiceLog(301011048, 1715, 1716, 1717)
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= 0 + 0.566666666666667 and arg_202_1.time_ < 0 + 0.566666666666667 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play301011049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 301011049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play301011052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 1.225

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(301011049).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 49 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 49)

				if (49 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 49)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play301011052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 301011052
		arg_210_1.duration_ = 2.7

		local var_210_0 = {
			zh = 2.7,
			ja = 1.999999999999
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play301011053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = arg_210_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1084ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.075

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(301011052)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 3 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 3)

				if (3 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 3)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011052", "story_v_out_301011.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011052", "story_v_out_301011.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_301011", "301011052", "story_v_out_301011.awb")

						arg_210_1:RecordAudio("301011052", var_213_11)
						arg_210_1:RecordAudio("301011052", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_301011", "301011052", "story_v_out_301011.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_301011", "301011052", "story_v_out_301011.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play301011053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 301011053
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play301011054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1084ui_story = arg_214_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_217_0 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				arg_214_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).z)
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles = arg_214_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				arg_214_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["1084ui_story"].transform.position).z)
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["1084ui_story"].transform.localEulerAngles = arg_214_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_217_1 = arg_214_1.actors_["1084ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = var_217_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_2 and not isNil(var_217_1) then
				if arg_214_1.var_.characterEffect1084ui_story and not isNil(var_217_1) then
					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_2)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_2 and arg_214_1.time_ < 0 + var_217_2 + arg_217_0 and not isNil(var_217_1) and arg_214_1.var_.characterEffect1084ui_story then
				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_217_3 = 0
			local var_217_4 = 1.7

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_3 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_5 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(301011053).content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 68 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_5) / 68)

				if (68 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_5) / 68)) > 0 and var_217_4 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_3 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_3
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_8 = math.max(var_217_4, arg_214_1.talkMaxDuration)

			if var_217_3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_3 + var_217_8 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_3) / var_217_8

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_3 + var_217_8 and arg_214_1.time_ < var_217_3 + var_217_8 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play301011054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 301011054
		arg_218_1.duration_ = 5.83

		local var_218_0 = {
			zh = 4.833,
			ja = 5.833
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play301011055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1084ui_story = arg_218_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1084ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story == nil then
				arg_218_1.var_.characterEffect1084ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect1084ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect1084ui_story then
				arg_218_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4413")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_221_4 = 0
			local var_221_5 = 0.45

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(301011054)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 18 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 18)

				if (18 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 18)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011054", "story_v_out_301011.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011054", "story_v_out_301011.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_301011", "301011054", "story_v_out_301011.awb")

						arg_218_1:RecordAudio("301011054", var_221_11)
						arg_218_1:RecordAudio("301011054", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_301011", "301011054", "story_v_out_301011.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_301011", "301011054", "story_v_out_301011.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play301011055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 301011055
		arg_222_1.duration_ = 2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play301011056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_225_0 = 0
			local var_225_1 = 0.1

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(301011055)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 4 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 4)

				if (4 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 4)) > 0 and var_225_1 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011055", "story_v_out_301011.awb") ~= 0 then
					local var_225_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011055", "story_v_out_301011.awb") / 1000

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end

					if var_225_2.prefab_name ~= "" and arg_222_1.actors_[var_225_2.prefab_name] ~= nil then
						local var_225_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_2.prefab_name].transform, "story_v_out_301011", "301011055", "story_v_out_301011.awb")

						arg_222_1:RecordAudio("301011055", var_225_7)
						arg_222_1:RecordAudio("301011055", var_225_7)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_301011", "301011055", "story_v_out_301011.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_301011", "301011055", "story_v_out_301011.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play301011056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 301011056
		arg_226_1.duration_ = 5.93

		local var_226_0 = {
			zh = 5.933,
			ja = 4.8
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play301011057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_229_0 = 0
			local var_229_1 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_2 = arg_226_1:GetWordFromCfg(301011056)
				local var_229_3 = arg_226_1:FormatText(var_229_2.content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 13 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 13)

				if (13 <= 0 and var_229_1 or var_229_1 * (utf8.len(var_229_3) / 13)) > 0 and var_229_1 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011056", "story_v_out_301011.awb") ~= 0 then
					local var_229_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011056", "story_v_out_301011.awb") / 1000

					if var_229_6 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_0
					end

					if var_229_2.prefab_name ~= "" and arg_226_1.actors_[var_229_2.prefab_name] ~= nil then
						local var_229_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_2.prefab_name].transform, "story_v_out_301011", "301011056", "story_v_out_301011.awb")

						arg_226_1:RecordAudio("301011056", var_229_7)
						arg_226_1:RecordAudio("301011056", var_229_7)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_301011", "301011056", "story_v_out_301011.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_301011", "301011056", "story_v_out_301011.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play301011057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 301011057
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play301011058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1084ui_story = arg_230_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).z)
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles = arg_230_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).z)
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles = arg_230_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1084ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_2)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1084ui_story then
				arg_230_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_233_3 = 0
			local var_233_4 = 1.175

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_5 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(301011057).content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 47 <= 0 and var_233_4 or var_233_4 * (utf8.len(var_233_5) / 47)

				if (47 <= 0 and var_233_4 or var_233_4 * (utf8.len(var_233_5) / 47)) > 0 and var_233_4 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_3 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_3
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_4, arg_230_1.talkMaxDuration)

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_3) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_3 + var_233_8 and arg_230_1.time_ < var_233_3 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play301011058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 301011058
		arg_234_1.duration_ = 8.27

		local var_234_0 = {
			zh = 8.266,
			ja = 7.6
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play301011059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1084ui_story = arg_234_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).z)
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles = arg_234_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_234_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1084ui_story"].transform.position).z)
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1084ui_story"].transform.localEulerAngles = arg_234_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1084ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect1084ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect1084ui_story then
				arg_234_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_4 = 0
			local var_237_5 = 0.8

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(301011058)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 32 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 32)

				if (32 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 32)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011058", "story_v_out_301011.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011058", "story_v_out_301011.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_301011", "301011058", "story_v_out_301011.awb")

						arg_234_1:RecordAudio("301011058", var_237_11)
						arg_234_1:RecordAudio("301011058", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_301011", "301011058", "story_v_out_301011.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_301011", "301011058", "story_v_out_301011.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play301011059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 301011059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play301011060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = arg_238_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) then
				if arg_238_1.var_.characterEffect1084ui_story and not isNil(arg_238_1.actors_["1084ui_story"]) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1084ui_story"]) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.425

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(301011059).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 17 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 17)

				if (17 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 17)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play301011060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 301011060
		arg_242_1.duration_ = 5.53

		local var_242_0 = {
			zh = 4.966,
			ja = 5.533
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play301011061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = arg_242_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) then
				if arg_242_1.var_.characterEffect1084ui_story and not isNil(arg_242_1.actors_["1084ui_story"]) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1084ui_story"]) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_245_2 = 0
			local var_245_3 = 0.7

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:GetWordFromCfg(301011060)
				local var_245_5 = arg_242_1:FormatText(var_245_4.content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 28 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 28)

				if (28 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 28)) > 0 and var_245_3 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011060", "story_v_out_301011.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_301011", "301011060", "story_v_out_301011.awb") / 1000

					if var_245_8 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_2
					end

					if var_245_4.prefab_name ~= "" and arg_242_1.actors_[var_245_4.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_4.prefab_name].transform, "story_v_out_301011", "301011060", "story_v_out_301011.awb")

						arg_242_1:RecordAudio("301011060", var_245_9)
						arg_242_1:RecordAudio("301011060", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_301011", "301011060", "story_v_out_301011.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_301011", "301011060", "story_v_out_301011.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_10 and arg_242_1.time_ < var_245_2 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play301011061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 301011061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play301011062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = arg_246_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).z)
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles = arg_246_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_246_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).z)
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles = arg_246_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1084ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_2)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1084ui_story then
				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_249_3 = 0
			local var_249_4 = 1.025

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(301011061).content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 41 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 41)

				if (41 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 41)) > 0 and var_249_4 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_3
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_4, arg_246_1.talkMaxDuration)

			if var_249_3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_3 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_3) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_3 + var_249_8 and arg_246_1.time_ < var_249_3 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play301011062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 301011062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play301011063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.15

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(301011062).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 6 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 6)

				if (6 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 6)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play301011063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 301011063
		arg_254_1.duration_ = 6.43

		local var_254_0 = {
			zh = 6.433,
			ja = 4.633
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play301011064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1084ui_story = arg_254_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).z)
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles = arg_254_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_254_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1084ui_story"].transform.position).z)
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1084ui_story"].transform.localEulerAngles = arg_254_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1084ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1084ui_story then
				arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_257_4 = 0
			local var_257_5 = 0.7

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(301011063)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 31 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 31)

				if (31 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 31)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011063", "story_v_out_301011.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011063", "story_v_out_301011.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_301011", "301011063", "story_v_out_301011.awb")

						arg_254_1:RecordAudio("301011063", var_257_11)
						arg_254_1:RecordAudio("301011063", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_301011", "301011063", "story_v_out_301011.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_301011", "301011063", "story_v_out_301011.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play301011064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 301011064
		arg_258_1.duration_ = 3.1

		local var_258_0 = {
			zh = 3.1,
			ja = 1.999999999999
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play301011065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_261_0 = 0
			local var_261_1 = 0.125

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_2 = arg_258_1:GetWordFromCfg(301011064)
				local var_261_3 = arg_258_1:FormatText(var_261_2.content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 5 <= 0 and var_261_1 or var_261_1 * (utf8.len(var_261_3) / 5)

				if (5 <= 0 and var_261_1 or var_261_1 * (utf8.len(var_261_3) / 5)) > 0 and var_261_1 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011064", "story_v_out_301011.awb") ~= 0 then
					local var_261_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011064", "story_v_out_301011.awb") / 1000

					if var_261_6 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_0
					end

					if var_261_2.prefab_name ~= "" and arg_258_1.actors_[var_261_2.prefab_name] ~= nil then
						local var_261_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_2.prefab_name].transform, "story_v_out_301011", "301011064", "story_v_out_301011.awb")

						arg_258_1:RecordAudio("301011064", var_261_7)
						arg_258_1:RecordAudio("301011064", var_261_7)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_301011", "301011064", "story_v_out_301011.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_301011", "301011064", "story_v_out_301011.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_8 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_8 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_8

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_8 and arg_258_1.time_ < var_261_0 + var_261_8 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play301011065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 301011065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play301011066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1084ui_story = arg_262_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).z)
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles = arg_262_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1084ui_story"].transform.position).z)
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1084ui_story"].transform.localEulerAngles = arg_262_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["1084ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = var_265_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 and not isNil(var_265_1) then
				if arg_262_1.var_.characterEffect1084ui_story and not isNil(var_265_1) then
					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_2)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 and not isNil(var_265_1) and arg_262_1.var_.characterEffect1084ui_story then
				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_265_3 = 0
			local var_265_4 = 1.475

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_5 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(301011065).content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 59 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_5) / 59)

				if (59 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_5) / 59)) > 0 and var_265_4 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_3 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_3
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_4, arg_262_1.talkMaxDuration)

			if var_265_3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_3 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_3) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_3 + var_265_8 and arg_262_1.time_ < var_265_3 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play301011066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 301011066
		arg_266_1.duration_ = 9.97

		local var_266_0 = {
			zh = 7.733,
			ja = 9.966
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play301011067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1084ui_story = arg_266_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).z)
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles = arg_266_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_266_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1084ui_story"].transform.position).z)
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1084ui_story"].transform.localEulerAngles = arg_266_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1084ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1084ui_story == nil then
				arg_266_1.var_.characterEffect1084ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1084ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1084ui_story then
				arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_269_4 = 0
			local var_269_5 = 0.9

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(301011066)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 36 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 36)

				if (36 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 36)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011066", "story_v_out_301011.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011066", "story_v_out_301011.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_301011", "301011066", "story_v_out_301011.awb")

						arg_266_1:RecordAudio("301011066", var_269_11)
						arg_266_1:RecordAudio("301011066", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_301011", "301011066", "story_v_out_301011.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_301011", "301011066", "story_v_out_301011.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play301011067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 301011067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play301011068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) and arg_270_1.var_.characterEffect1084ui_story == nil then
				arg_270_1.var_.characterEffect1084ui_story = arg_270_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) then
				if arg_270_1.var_.characterEffect1084ui_story and not isNil(arg_270_1.actors_["1084ui_story"]) then
					arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) and arg_270_1.var_.characterEffect1084ui_story then
				arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.675

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(301011067).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 27 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 27)

				if (27 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 27)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play301011068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 301011068
		arg_274_1.duration_ = 9.87

		local var_274_0 = {
			zh = 8.533,
			ja = 9.866
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play301011069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) and arg_274_1.var_.characterEffect1084ui_story == nil then
				arg_274_1.var_.characterEffect1084ui_story = arg_274_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) then
				if arg_274_1.var_.characterEffect1084ui_story and not isNil(arg_274_1.actors_["1084ui_story"]) then
					arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) and arg_274_1.var_.characterEffect1084ui_story then
				arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_277_2 = 0
			local var_277_3 = 0.85

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(301011068)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 34 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 34)

				if (34 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 34)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011068", "story_v_out_301011.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_301011", "301011068", "story_v_out_301011.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_301011", "301011068", "story_v_out_301011.awb")

						arg_274_1:RecordAudio("301011068", var_277_9)
						arg_274_1:RecordAudio("301011068", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_301011", "301011068", "story_v_out_301011.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_301011", "301011068", "story_v_out_301011.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play301011069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 301011069
		arg_278_1.duration_ = 5.9

		local var_278_0 = {
			zh = 4.6,
			ja = 5.9
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play301011070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action475")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_281_0 = 0
			local var_281_1 = 0.55

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(301011069)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 22 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 22)

				if (22 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 22)) > 0 and var_281_1 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011069", "story_v_out_301011.awb") ~= 0 then
					local var_281_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011069", "story_v_out_301011.awb") / 1000

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end

					if var_281_2.prefab_name ~= "" and arg_278_1.actors_[var_281_2.prefab_name] ~= nil then
						local var_281_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_2.prefab_name].transform, "story_v_out_301011", "301011069", "story_v_out_301011.awb")

						arg_278_1:RecordAudio("301011069", var_281_7)
						arg_278_1:RecordAudio("301011069", var_281_7)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_301011", "301011069", "story_v_out_301011.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_301011", "301011069", "story_v_out_301011.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play301011070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 301011070
		arg_282_1.duration_ = 6.3

		local var_282_0 = {
			zh = 4.9,
			ja = 6.3
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play301011071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_285_0 = 0
			local var_285_1 = 0.65

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(301011070)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 26 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 26)

				if (26 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 26)) > 0 and var_285_1 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011070", "story_v_out_301011.awb") ~= 0 then
					local var_285_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011070", "story_v_out_301011.awb") / 1000

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end

					if var_285_2.prefab_name ~= "" and arg_282_1.actors_[var_285_2.prefab_name] ~= nil then
						local var_285_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_2.prefab_name].transform, "story_v_out_301011", "301011070", "story_v_out_301011.awb")

						arg_282_1:RecordAudio("301011070", var_285_7)
						arg_282_1:RecordAudio("301011070", var_285_7)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_301011", "301011070", "story_v_out_301011.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_301011", "301011070", "story_v_out_301011.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play301011071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 301011071
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play301011072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1084ui_story"]) and arg_286_1.var_.characterEffect1084ui_story == nil then
				arg_286_1.var_.characterEffect1084ui_story = arg_286_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1084ui_story"]) then
				if arg_286_1.var_.characterEffect1084ui_story and not isNil(arg_286_1.actors_["1084ui_story"]) then
					arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1084ui_story"]) and arg_286_1.var_.characterEffect1084ui_story then
				arg_286_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 0.05

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(301011071).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 2 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 2)

				if (2 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 2)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play301011072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 301011072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play301011073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1084ui_story = arg_290_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).z)
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles = arg_290_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1084ui_story"].transform.position).z)
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1084ui_story"].transform.localEulerAngles = arg_290_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_293_1 = 0
			local var_293_2 = 1.25

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(301011072).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 50 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 50)

				if (50 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 50)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play301011073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 301011073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play301011074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.2

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(301011073).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 8 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 8)

				if (8 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 8)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play301011074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 301011074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play301011075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.3

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(301011074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 12 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 12)

				if (12 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 12)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play301011075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 301011075
		arg_302_1.duration_ = 1

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"

			SetActive(arg_302_1.choicesGo_, true)

			for iter_303_0, iter_303_1 in ipairs(arg_302_1.choices_) do
				SetActive(iter_303_1.go, iter_303_0 <= 1)
			end

			arg_302_1.choices_[1].txt.text = arg_302_1:FormatText(StoryChoiceCfg[1718].name)
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play301011076(arg_302_1)
			end

			arg_302_1:RecordChoiceLog(301011075, 1718)
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			if arg_302_1.time_ >= 0 + 0.533333333333333 and arg_302_1.time_ < 0 + 0.533333333333333 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play301011076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 301011076
		arg_306_1.duration_ = 7.43

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play301011077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_9000

			if 2.43333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 2.43333333333333 + arg_309_0 then
				local var_309_0 = arg_306_1.bgs_.STblack

				arg_306_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_309_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_309_1 = var_309_0:GetComponent("SpriteRenderer")

				if var_309_1 and var_309_1.sprite then
					local var_309_2 = 2 * (var_309_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_309_0.transform.localScale = Vector3.New(var_309_2 / var_309_1.sprite.bounds.size.y < var_309_2 * manager.ui.mainCameraCom_.aspect / var_309_1.sprite.bounds.size.x and var_309_2 * manager.ui.mainCameraCom_.aspect / var_309_1.sprite.bounds.size.x or var_309_2 / var_309_1.sprite.bounds.size.y, var_309_2 / var_309_1.sprite.bounds.size.y < var_309_2 * manager.ui.mainCameraCom_.aspect / var_309_1.sprite.bounds.size.x and var_309_2 * manager.ui.mainCameraCom_.aspect / var_309_1.sprite.bounds.size.x or var_309_2 / var_309_1.sprite.bounds.size.y, 0)
				end

				for iter_309_0, iter_309_1 in pairs(arg_306_1.bgs_) do
					if iter_309_0 ~= "STblack" then
						iter_309_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				local var_309_3 = arg_306_1.var_.effecthuiyixinghong1

				if not arg_306_1.var_.effecthuiyixinghong1 then
					var_309_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error03"), manager.ui.mainCamera.transform)
					var_309_3.name = "huiyixinghong1"
					arg_306_1.var_.effecthuiyixinghong1 = var_309_3
				else
					var_309_3.transform:SetParent(var_309_9000)
				end

				var_309_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_309_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.43333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 2.43333333333333 + arg_309_0 then
				if arg_306_1.var_.effecthuiyixinghong1 then
					Object.Destroy(arg_306_1.var_.effecthuiyixinghong1)

					arg_306_1.var_.effecthuiyixinghong1 = nil
				end
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_6 = 2.43333333333333
			local var_309_7 = 1.325

			if 2.43333333333333 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_8 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_8:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_9 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(301011076).content)

				arg_306_1.text_.text = var_309_9

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 53 <= 0 and var_309_7 or var_309_7 * (utf8.len(var_309_9) / 53)

				if (53 <= 0 and var_309_7 or var_309_7 * (utf8.len(var_309_9) / 53)) > 0 and var_309_7 < var_309_11 then
					arg_306_1.talkMaxDuration = var_309_11
					var_309_6 = var_309_6 + 0.3

					if var_309_11 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_9
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = var_309_6 + 0.3
			local var_309_13 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 + 0.3 <= arg_306_1.time_ and arg_306_1.time_ < var_309_12 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_12) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_12 + var_309_13 and arg_306_1.time_ < var_309_12 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play301011077 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 301011077
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play301011078(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 1.325

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_1 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(301011077).content)

				arg_312_1.text_.text = var_315_1

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_3 = 53 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 53)

				if (53 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_1) / 53)) > 0 and var_315_0 < var_315_3 then
					arg_312_1.talkMaxDuration = var_315_3

					if var_315_3 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_3 + 0
					end
				end

				arg_312_1.text_.text = var_315_1
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_4 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_4

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play301011078 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 301011078
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play301011079(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 1.725

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(301011078).content)

				arg_316_1.text_.text = var_319_1

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_3 = 69 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 69)

				if (69 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 69)) > 0 and var_319_0 < var_319_3 then
					arg_316_1.talkMaxDuration = var_319_3

					if var_319_3 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_3 + 0
					end
				end

				arg_316_1.text_.text = var_319_1
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_4 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_4

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play301011079 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 301011079
		arg_320_1.duration_ = 6.77

		local var_320_0 = {
			zh = 5.56633333333333,
			ja = 6.76633333333333
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play301011080(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 1.23333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 1.23333333333333 + arg_323_0 then
				arg_320_1.var_.moveOldPos10066ui_story = arg_320_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 1.23333333333333 <= arg_320_1.time_ and arg_320_1.time_ < 1.23333333333333 + var_323_0 then
				arg_320_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_320_1.time_ - 1.23333333333333) / var_323_0)
				arg_320_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).z)
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles = arg_320_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 1.23333333333333 + var_323_0 and arg_320_1.time_ < 1.23333333333333 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_320_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10066ui_story"].transform.position).z)
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["10066ui_story"].transform.localEulerAngles = arg_320_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["10066ui_story"]

			if 1.23333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 1.23333333333333 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect10066ui_story == nil then
				arg_320_1.var_.characterEffect10066ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if 1.23333333333333 <= arg_320_1.time_ and arg_320_1.time_ < 1.23333333333333 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect10066ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 1.23333333333333 + var_323_2 and arg_320_1.time_ < 1.23333333333333 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect10066ui_story then
				arg_320_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 1.23333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 1.23333333333333 + arg_323_0 then
				arg_320_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 1.23333333333333 < arg_320_1.time_ and arg_320_1.time_ <= 1.23333333333333 + arg_323_0 then
				arg_320_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				local var_323_4 = arg_320_1.bgs_.ST07

				arg_320_1.bgs_.ST07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_323_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_323_5 = var_323_4:GetComponent("SpriteRenderer")

				if var_323_5 and var_323_5.sprite then
					local var_323_6 = 2 * (var_323_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_323_4.transform.localScale = Vector3.New(var_323_6 / var_323_5.sprite.bounds.size.y < var_323_6 * manager.ui.mainCameraCom_.aspect / var_323_5.sprite.bounds.size.x and var_323_6 * manager.ui.mainCameraCom_.aspect / var_323_5.sprite.bounds.size.x or var_323_6 / var_323_5.sprite.bounds.size.y, var_323_6 / var_323_5.sprite.bounds.size.y < var_323_6 * manager.ui.mainCameraCom_.aspect / var_323_5.sprite.bounds.size.x and var_323_6 * manager.ui.mainCameraCom_.aspect / var_323_5.sprite.bounds.size.x or var_323_6 / var_323_5.sprite.bounds.size.y, 0)
				end

				for iter_323_0, iter_323_1 in pairs(arg_320_1.bgs_) do
					if iter_323_0 ~= "ST07" then
						iter_323_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_323_7 = 0

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_7 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_8 = 1.23333333333333

			if var_323_7 <= arg_320_1.time_ and arg_320_1.time_ < var_323_7 + var_323_8 then
				local var_323_9 = Color.New(0, 0, 0)

				var_323_9.a = Mathf.Lerp(1, 0, (arg_320_1.time_ - var_323_7) / var_323_8)
				arg_320_1.mask_.color = var_323_9
			end

			if arg_320_1.time_ >= var_323_7 + var_323_8 and arg_320_1.time_ < var_323_7 + var_323_8 + arg_323_0 then
				local var_323_10 = Color.New(0, 0, 0)

				arg_320_1.mask_.enabled = false
				var_323_10.a = 0
				arg_320_1.mask_.color = var_323_10
			end

			if 0.1 < arg_320_1.time_ and arg_320_1.time_ <= 0.1 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_12 = 1.23333333333333
			local var_323_13 = 0.35

			if 1.23333333333333 < arg_320_1.time_ and arg_320_1.time_ <= var_323_12 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_14 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_14:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_15 = arg_320_1:GetWordFromCfg(301011079)
				local var_323_16 = arg_320_1:FormatText(var_323_15.content)

				arg_320_1.text_.text = var_323_16

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_18 = 14 <= 0 and var_323_13 or var_323_13 * (utf8.len(var_323_16) / 14)

				if (14 <= 0 and var_323_13 or var_323_13 * (utf8.len(var_323_16) / 14)) > 0 and var_323_13 < var_323_18 then
					arg_320_1.talkMaxDuration = var_323_18
					var_323_12 = var_323_12 + 0.3

					if var_323_18 + var_323_12 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_18 + var_323_12
					end
				end

				arg_320_1.text_.text = var_323_16
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011079", "story_v_out_301011.awb") ~= 0 then
					local var_323_19 = manager.audio:GetVoiceLength("story_v_out_301011", "301011079", "story_v_out_301011.awb") / 1000

					if var_323_19 + var_323_12 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_19 + var_323_12
					end

					if var_323_15.prefab_name ~= "" and arg_320_1.actors_[var_323_15.prefab_name] ~= nil then
						local var_323_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_15.prefab_name].transform, "story_v_out_301011", "301011079", "story_v_out_301011.awb")

						arg_320_1:RecordAudio("301011079", var_323_20)
						arg_320_1:RecordAudio("301011079", var_323_20)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_301011", "301011079", "story_v_out_301011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_301011", "301011079", "story_v_out_301011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_21 = var_323_12 + 0.3
			local var_323_22 = math.max(var_323_13, arg_320_1.talkMaxDuration)

			if var_323_12 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_21 + var_323_22 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_21) / var_323_22

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_21 + var_323_22 and arg_320_1.time_ < var_323_21 + var_323_22 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play301011080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 301011080
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play301011081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10066ui_story = arg_326_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).z)
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles = arg_326_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["10066ui_story"].transform.position).z)
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["10066ui_story"].transform.localEulerAngles = arg_326_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["10066ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect10066ui_story == nil then
				arg_326_1.var_.characterEffect10066ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect10066ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_326_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_2)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect10066ui_story then
				arg_326_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_326_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_329_3 = 0
			local var_329_4 = 1.45

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_5 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(301011080).content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 58 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 58)

				if (58 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 58)) > 0 and var_329_4 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_3 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_3
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_4, arg_326_1.talkMaxDuration)

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_3) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_3 + var_329_8 and arg_326_1.time_ < var_329_3 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play301011081 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 301011081
		arg_330_1.duration_ = 5.73

		local var_330_0 = {
			zh = 5.733,
			ja = 4.6
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play301011082(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10066ui_story = arg_330_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).z)
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles = arg_330_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_330_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["10066ui_story"].transform.position).z)
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["10066ui_story"].transform.localEulerAngles = arg_330_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["10066ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10066ui_story == nil then
				arg_330_1.var_.characterEffect10066ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect10066ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect10066ui_story then
				arg_330_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_333_4 = 0
			local var_333_5 = 0.5

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(301011081)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 20 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 20)

				if (20 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 20)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011081", "story_v_out_301011.awb") ~= 0 then
					local var_333_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011081", "story_v_out_301011.awb") / 1000

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end

					if var_333_6.prefab_name ~= "" and arg_330_1.actors_[var_333_6.prefab_name] ~= nil then
						local var_333_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_6.prefab_name].transform, "story_v_out_301011", "301011081", "story_v_out_301011.awb")

						arg_330_1:RecordAudio("301011081", var_333_11)
						arg_330_1:RecordAudio("301011081", var_333_11)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_301011", "301011081", "story_v_out_301011.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_301011", "301011081", "story_v_out_301011.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_12 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_12 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_12

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_12 and arg_330_1.time_ < var_333_4 + var_333_12 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play301011082 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 301011082
		arg_334_1.duration_ = 7.13

		local var_334_0 = {
			zh = 5.033,
			ja = 7.133
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play301011083(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = arg_334_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_334_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1084ui_story"].transform.position).z)
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1084ui_story"].transform.localEulerAngles = arg_334_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1084ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_337_4 = arg_334_1.actors_["10066ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_4) and arg_334_1.var_.characterEffect10066ui_story == nil then
				arg_334_1.var_.characterEffect10066ui_story = var_337_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_5 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_5 and not isNil(var_337_4) then
				if arg_334_1.var_.characterEffect10066ui_story and not isNil(var_337_4) then
					arg_334_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_5)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_5 and arg_334_1.time_ < 0 + var_337_5 + arg_337_0 and not isNil(var_337_4) and arg_334_1.var_.characterEffect10066ui_story then
				arg_334_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_337_6 = 0
			local var_337_7 = 0.6

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1547].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(301011082)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 24 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 24)

				if (24 <= 0 and var_337_7 or var_337_7 * (utf8.len(var_337_9) / 24)) > 0 and var_337_7 < var_337_11 then
					arg_334_1.talkMaxDuration = var_337_11

					if var_337_11 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011082", "story_v_out_301011.awb") ~= 0 then
					local var_337_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011082", "story_v_out_301011.awb") / 1000

					if var_337_12 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_6
					end

					if var_337_8.prefab_name ~= "" and arg_334_1.actors_[var_337_8.prefab_name] ~= nil then
						local var_337_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_8.prefab_name].transform, "story_v_out_301011", "301011082", "story_v_out_301011.awb")

						arg_334_1:RecordAudio("301011082", var_337_13)
						arg_334_1:RecordAudio("301011082", var_337_13)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_301011", "301011082", "story_v_out_301011.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_301011", "301011082", "story_v_out_301011.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_14 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_14 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_14

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_14 and arg_334_1.time_ < var_337_6 + var_337_14 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play301011083 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 301011083
		arg_338_1.duration_ = 6.3

		local var_338_0 = {
			zh = 5.2,
			ja = 6.3
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play301011084(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10066ui_story = arg_338_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).z)
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles = arg_338_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_338_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10066ui_story"].transform.position).z)
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["10066ui_story"].transform.localEulerAngles = arg_338_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["10066ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect10066ui_story == nil then
				arg_338_1.var_.characterEffect10066ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect10066ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect10066ui_story then
				arg_338_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_341_4 = arg_338_1.actors_["1084ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_4) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = var_341_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_5 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_5 and not isNil(var_341_4) then
				if arg_338_1.var_.characterEffect1084ui_story and not isNil(var_341_4) then
					arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_5)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_5 and arg_338_1.time_ < 0 + var_341_5 + arg_341_0 and not isNil(var_341_4) and arg_338_1.var_.characterEffect1084ui_story then
				arg_338_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_341_6 = 0
			local var_341_7 = 0.5

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_8 = arg_338_1:GetWordFromCfg(301011083)
				local var_341_9 = arg_338_1:FormatText(var_341_8.content)

				arg_338_1.text_.text = var_341_9

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 20 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 20)

				if (20 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 20)) > 0 and var_341_7 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_9
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011083", "story_v_out_301011.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011083", "story_v_out_301011.awb") / 1000

					if var_341_12 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_6
					end

					if var_341_8.prefab_name ~= "" and arg_338_1.actors_[var_341_8.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_8.prefab_name].transform, "story_v_out_301011", "301011083", "story_v_out_301011.awb")

						arg_338_1:RecordAudio("301011083", var_341_13)
						arg_338_1:RecordAudio("301011083", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_301011", "301011083", "story_v_out_301011.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_301011", "301011083", "story_v_out_301011.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play301011084 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 301011084
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play301011085(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10066ui_story"]) and arg_342_1.var_.characterEffect10066ui_story == nil then
				arg_342_1.var_.characterEffect10066ui_story = arg_342_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10066ui_story"]) then
				if arg_342_1.var_.characterEffect10066ui_story and not isNil(arg_342_1.actors_["10066ui_story"]) then
					arg_342_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10066ui_story"]) and arg_342_1.var_.characterEffect10066ui_story then
				arg_342_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_345_1 = 0
			local var_345_2 = 1.175

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_3 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(301011084).content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 47 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 47)

				if (47 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 47)) > 0 and var_345_2 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_6 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_6 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_6

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_6 and arg_342_1.time_ < var_345_1 + var_345_6 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play301011085 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 301011085
		arg_346_1.duration_ = 13.53

		local var_346_0 = {
			zh = 8.4,
			ja = 13.533
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play301011086(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10066ui_story"]) and arg_346_1.var_.characterEffect10066ui_story == nil then
				arg_346_1.var_.characterEffect10066ui_story = arg_346_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10066ui_story"]) then
				if arg_346_1.var_.characterEffect10066ui_story and not isNil(arg_346_1.actors_["10066ui_story"]) then
					arg_346_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10066ui_story"]) and arg_346_1.var_.characterEffect10066ui_story then
				arg_346_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_349_2 = 0
			local var_349_3 = 0.975

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_4 = arg_346_1:GetWordFromCfg(301011085)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 39 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 39)

				if (39 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 39)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011085", "story_v_out_301011.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_301011", "301011085", "story_v_out_301011.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_out_301011", "301011085", "story_v_out_301011.awb")

						arg_346_1:RecordAudio("301011085", var_349_9)
						arg_346_1:RecordAudio("301011085", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_301011", "301011085", "story_v_out_301011.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_301011", "301011085", "story_v_out_301011.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_10 and arg_346_1.time_ < var_349_2 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play301011086 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 301011086
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play301011087(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10066ui_story"]) and arg_350_1.var_.characterEffect10066ui_story == nil then
				arg_350_1.var_.characterEffect10066ui_story = arg_350_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10066ui_story"]) then
				if arg_350_1.var_.characterEffect10066ui_story and not isNil(arg_350_1.actors_["10066ui_story"]) then
					arg_350_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_350_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_0)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10066ui_story"]) and arg_350_1.var_.characterEffect10066ui_story then
				arg_350_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_350_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_353_1 = 0
			local var_353_2 = 0.275

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(301011086).content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 11 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 11)

				if (11 <= 0 and var_353_2 or var_353_2 * (utf8.len(var_353_3) / 11)) > 0 and var_353_2 < var_353_5 then
					arg_350_1.talkMaxDuration = var_353_5

					if var_353_5 + var_353_1 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + var_353_1
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_6 = math.max(var_353_2, arg_350_1.talkMaxDuration)

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_6 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_1) / var_353_6

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_1 + var_353_6 and arg_350_1.time_ < var_353_1 + var_353_6 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play301011087 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 301011087
		arg_354_1.duration_ = 12

		local var_354_0 = {
			zh = 10.666,
			ja = 12
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play301011088(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["10066ui_story"]) and arg_354_1.var_.characterEffect10066ui_story == nil then
				arg_354_1.var_.characterEffect10066ui_story = arg_354_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["10066ui_story"]) then
				if arg_354_1.var_.characterEffect10066ui_story and not isNil(arg_354_1.actors_["10066ui_story"]) then
					arg_354_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["10066ui_story"]) and arg_354_1.var_.characterEffect10066ui_story then
				arg_354_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_357_2 = 0
			local var_357_3 = 0.975

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(301011087)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 39 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 39)

				if (39 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 39)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011087", "story_v_out_301011.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_301011", "301011087", "story_v_out_301011.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_out_301011", "301011087", "story_v_out_301011.awb")

						arg_354_1:RecordAudio("301011087", var_357_9)
						arg_354_1:RecordAudio("301011087", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_301011", "301011087", "story_v_out_301011.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_301011", "301011087", "story_v_out_301011.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play301011088 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 301011088
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play301011089(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["10066ui_story"]) and arg_358_1.var_.characterEffect10066ui_story == nil then
				arg_358_1.var_.characterEffect10066ui_story = arg_358_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["10066ui_story"]) then
				if arg_358_1.var_.characterEffect10066ui_story and not isNil(arg_358_1.actors_["10066ui_story"]) then
					arg_358_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_358_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["10066ui_story"]) and arg_358_1.var_.characterEffect10066ui_story then
				arg_358_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_358_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 0.3

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(301011088).content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 12 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 12)

				if (12 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 12)) > 0 and var_361_2 < var_361_5 then
					arg_358_1.talkMaxDuration = var_361_5

					if var_361_5 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_6 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_6 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_6

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_6 and arg_358_1.time_ < var_361_1 + var_361_6 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play301011089 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 301011089
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play301011090(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos10066ui_story = arg_362_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).z)
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles = arg_362_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_362_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["10066ui_story"].transform.position).z)
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["10066ui_story"].transform.localEulerAngles = arg_362_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["1084ui_story"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1084ui_story = var_365_1.localPosition
			end

			local var_365_2 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 then
				var_365_1.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_362_1.time_ - 0) / var_365_2)
				var_365_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_1.position).x, (manager.ui.mainCamera.transform.position - var_365_1.position).y, (manager.ui.mainCamera.transform.position - var_365_1.position).z)
				var_365_1.localEulerAngles.z = 0
				var_365_1.localEulerAngles.x = 0
				var_365_1.localEulerAngles = var_365_1.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 then
				var_365_1.localPosition = Vector3.New(0, 100, 0)
				var_365_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_1.position).x, (manager.ui.mainCamera.transform.position - var_365_1.position).y, (manager.ui.mainCamera.transform.position - var_365_1.position).z)
				var_365_1.localEulerAngles.z = 0
				var_365_1.localEulerAngles.x = 0
				var_365_1.localEulerAngles = var_365_1.localEulerAngles
			end

			local var_365_3 = 0
			local var_365_4 = 1.35

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_5 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(301011089).content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 54 <= 0 and var_365_4 or var_365_4 * (utf8.len(var_365_5) / 54)

				if (54 <= 0 and var_365_4 or var_365_4 * (utf8.len(var_365_5) / 54)) > 0 and var_365_4 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_3 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_3
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_4, arg_362_1.talkMaxDuration)

			if var_365_3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_3 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_3) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_3 + var_365_8 and arg_362_1.time_ < var_365_3 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play301011090 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 301011090
		arg_366_1.duration_ = 1

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"

			SetActive(arg_366_1.choicesGo_, true)

			for iter_367_0, iter_367_1 in ipairs(arg_366_1.choices_) do
				SetActive(iter_367_1.go, iter_367_0 <= 1)
			end

			arg_366_1.choices_[1].txt.text = arg_366_1:FormatText(StoryChoiceCfg[1719].name)
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play301011091(arg_366_1)
			end

			arg_366_1:RecordChoiceLog(301011090, 1719)
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.allBtn_.enabled = false
			end

			if arg_366_1.time_ >= 0 + 0.466666666666667 and arg_366_1.time_ < 0 + 0.466666666666667 + arg_369_0 then
				arg_366_1.allBtn_.enabled = true
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play301011091 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 301011091
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play301011092(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_152", "se_story_side_152_metal_cup_drop", "")
			end

			local var_373_1 = 0
			local var_373_2 = 1.4

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_3 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(301011091).content)

				arg_370_1.text_.text = var_373_3

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_5 = 56 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 56)

				if (56 <= 0 and var_373_2 or var_373_2 * (utf8.len(var_373_3) / 56)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_1 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_1
					end
				end

				arg_370_1.text_.text = var_373_3
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_6 = math.max(var_373_2, arg_370_1.talkMaxDuration)

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_6 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_1) / var_373_6

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_1 + var_373_6 and arg_370_1.time_ < var_373_1 + var_373_6 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play301011092 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 301011092
		arg_374_1.duration_ = 3.87

		local var_374_0 = {
			zh = 3.866,
			ja = 3.6
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play301011093(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1084ui_story = arg_374_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).z)
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles = arg_374_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_374_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1084ui_story"].transform.position).z)
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1084ui_story"].transform.localEulerAngles = arg_374_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1084ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1084ui_story == nil then
				arg_374_1.var_.characterEffect1084ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1084ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1084ui_story then
				arg_374_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_377_4 = 0
			local var_377_5 = 0.35

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(301011092)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 14 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 14)

				if (14 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 14)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011092", "story_v_out_301011.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011092", "story_v_out_301011.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_out_301011", "301011092", "story_v_out_301011.awb")

						arg_374_1:RecordAudio("301011092", var_377_11)
						arg_374_1:RecordAudio("301011092", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_301011", "301011092", "story_v_out_301011.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_301011", "301011092", "story_v_out_301011.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play301011093 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 301011093
		arg_378_1.duration_ = 6.93

		local var_378_0 = {
			zh = 5.1,
			ja = 6.933
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play301011094(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_381_0 = 0
			local var_381_1 = 0.625

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(301011093)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 25 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 25)

				if (25 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 25)) > 0 and var_381_1 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011093", "story_v_out_301011.awb") ~= 0 then
					local var_381_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011093", "story_v_out_301011.awb") / 1000

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end

					if var_381_2.prefab_name ~= "" and arg_378_1.actors_[var_381_2.prefab_name] ~= nil then
						local var_381_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_2.prefab_name].transform, "story_v_out_301011", "301011093", "story_v_out_301011.awb")

						arg_378_1:RecordAudio("301011093", var_381_7)
						arg_378_1:RecordAudio("301011093", var_381_7)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_301011", "301011093", "story_v_out_301011.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_301011", "301011093", "story_v_out_301011.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play301011094 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 301011094
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play301011095(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1084ui_story"]) and arg_382_1.var_.characterEffect1084ui_story == nil then
				arg_382_1.var_.characterEffect1084ui_story = arg_382_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1084ui_story"]) then
				if arg_382_1.var_.characterEffect1084ui_story and not isNil(arg_382_1.actors_["1084ui_story"]) then
					arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_0)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1084ui_story"]) and arg_382_1.var_.characterEffect1084ui_story then
				arg_382_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_385_1 = 0
			local var_385_2 = 0.125

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(301011094).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 5 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 5)

				if (5 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 5)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play301011095 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 301011095
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play301011096(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.var_.moveOldPos1084ui_story = arg_386_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_389_0 = 0.001

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 then
				arg_386_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_386_1.time_ - 0) / var_389_0)
				arg_386_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).z)
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles = arg_386_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 then
				arg_386_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_386_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_386_1.actors_["1084ui_story"].transform.position).z)
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_386_1.actors_["1084ui_story"].transform.localEulerAngles = arg_386_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_389_1 = 0
			local var_389_2 = 1.775

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(301011095).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 71 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 71)

				if (71 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 71)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play301011096 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 301011096
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play301011097(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 1.275

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(301011096).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 51 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 51)

				if (51 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 51)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play301011097 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 301011097
		arg_394_1.duration_ = 10.87

		local var_394_0 = {
			zh = 9.4,
			ja = 10.866
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play301011098(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10066ui_story = arg_394_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_397_0 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 then
				arg_394_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_394_1.time_ - 0) / var_397_0)
				arg_394_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).z)
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles = arg_394_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 then
				arg_394_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_394_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["10066ui_story"].transform.position).z)
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["10066ui_story"].transform.localEulerAngles = arg_394_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_397_1 = arg_394_1.actors_["10066ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect10066ui_story == nil then
				arg_394_1.var_.characterEffect10066ui_story = var_397_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_2 and not isNil(var_397_1) then
				if arg_394_1.var_.characterEffect10066ui_story and not isNil(var_397_1) then
					arg_394_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_394_1.time_ >= 0 + var_397_2 and arg_394_1.time_ < 0 + var_397_2 + arg_397_0 and not isNil(var_397_1) and arg_394_1.var_.characterEffect10066ui_story then
				arg_394_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_397_4 = 0
			local var_397_5 = 0.85

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_6 = arg_394_1:GetWordFromCfg(301011097)
				local var_397_7 = arg_394_1:FormatText(var_397_6.content)

				arg_394_1.text_.text = var_397_7

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_9 = 34 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 34)

				if (34 <= 0 and var_397_5 or var_397_5 * (utf8.len(var_397_7) / 34)) > 0 and var_397_5 < var_397_9 then
					arg_394_1.talkMaxDuration = var_397_9

					if var_397_9 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_9 + var_397_4
					end
				end

				arg_394_1.text_.text = var_397_7
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011097", "story_v_out_301011.awb") ~= 0 then
					local var_397_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011097", "story_v_out_301011.awb") / 1000

					if var_397_10 + var_397_4 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_10 + var_397_4
					end

					if var_397_6.prefab_name ~= "" and arg_394_1.actors_[var_397_6.prefab_name] ~= nil then
						local var_397_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_6.prefab_name].transform, "story_v_out_301011", "301011097", "story_v_out_301011.awb")

						arg_394_1:RecordAudio("301011097", var_397_11)
						arg_394_1:RecordAudio("301011097", var_397_11)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_301011", "301011097", "story_v_out_301011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_301011", "301011097", "story_v_out_301011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_12 = math.max(var_397_5, arg_394_1.talkMaxDuration)

			if var_397_4 <= arg_394_1.time_ and arg_394_1.time_ < var_397_4 + var_397_12 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_4) / var_397_12

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_4 + var_397_12 and arg_394_1.time_ < var_397_4 + var_397_12 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play301011098 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 301011098
		arg_398_1.duration_ = 6.2

		local var_398_0 = {
			zh = 5.033,
			ja = 6.2
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play301011099(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_401_0 = 0
			local var_401_1 = 0.55

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_2 = arg_398_1:GetWordFromCfg(301011098)
				local var_401_3 = arg_398_1:FormatText(var_401_2.content)

				arg_398_1.text_.text = var_401_3

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 22 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 22)

				if (22 <= 0 and var_401_1 or var_401_1 * (utf8.len(var_401_3) / 22)) > 0 and var_401_1 < var_401_5 then
					arg_398_1.talkMaxDuration = var_401_5

					if var_401_5 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_3
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011098", "story_v_out_301011.awb") ~= 0 then
					local var_401_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011098", "story_v_out_301011.awb") / 1000

					if var_401_6 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_6 + var_401_0
					end

					if var_401_2.prefab_name ~= "" and arg_398_1.actors_[var_401_2.prefab_name] ~= nil then
						local var_401_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_2.prefab_name].transform, "story_v_out_301011", "301011098", "story_v_out_301011.awb")

						arg_398_1:RecordAudio("301011098", var_401_7)
						arg_398_1:RecordAudio("301011098", var_401_7)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_301011", "301011098", "story_v_out_301011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_301011", "301011098", "story_v_out_301011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play301011099 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 301011099
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play301011100(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10066ui_story"]) and arg_402_1.var_.characterEffect10066ui_story == nil then
				arg_402_1.var_.characterEffect10066ui_story = arg_402_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_0 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10066ui_story"]) then
				if arg_402_1.var_.characterEffect10066ui_story and not isNil(arg_402_1.actors_["10066ui_story"]) then
					arg_402_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_402_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_0)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10066ui_story"]) and arg_402_1.var_.characterEffect10066ui_story then
				arg_402_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_402_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_405_1 = 0
			local var_405_2 = 0.875

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(301011099).content)

				arg_402_1.text_.text = var_405_3

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 35 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 35)

				if (35 <= 0 and var_405_2 or var_405_2 * (utf8.len(var_405_3) / 35)) > 0 and var_405_2 < var_405_5 then
					arg_402_1.talkMaxDuration = var_405_5

					if var_405_5 + var_405_1 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + var_405_1
					end
				end

				arg_402_1.text_.text = var_405_3
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_6 = math.max(var_405_2, arg_402_1.talkMaxDuration)

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_6 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_1) / var_405_6

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_1 + var_405_6 and arg_402_1.time_ < var_405_1 + var_405_6 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play301011100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 301011100
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play301011101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.2

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(301011100).content)

				arg_406_1.text_.text = var_409_1

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_3 = 8 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 8)

				if (8 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 8)) > 0 and var_409_0 < var_409_3 then
					arg_406_1.talkMaxDuration = var_409_3

					if var_409_3 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_3 + 0
					end
				end

				arg_406_1.text_.text = var_409_1
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_4 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_4

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play301011101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 301011101
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play301011102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos10066ui_story = arg_410_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_413_0 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 then
				arg_410_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_410_1.time_ - 0) / var_413_0)
				arg_410_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).z)
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles = arg_410_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 then
				arg_410_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_410_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_410_1.actors_["10066ui_story"].transform.position).z)
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_410_1.actors_["10066ui_story"].transform.localEulerAngles = arg_410_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_413_1 = 0
			local var_413_2 = 1.5

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(301011101).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 60 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 60)

				if (60 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 60)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play301011102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 301011102
		arg_414_1.duration_ = 7.83

		local var_414_0 = {
			zh = 7.3,
			ja = 7.833
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play301011103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos10066ui_story = arg_414_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).z)
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles = arg_414_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_414_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["10066ui_story"].transform.position).z)
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["10066ui_story"].transform.localEulerAngles = arg_414_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["10066ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect10066ui_story == nil then
				arg_414_1.var_.characterEffect10066ui_story = var_417_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 and not isNil(var_417_1) then
				if arg_414_1.var_.characterEffect10066ui_story and not isNil(var_417_1) then
					arg_414_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect10066ui_story then
				arg_414_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_417_4 = arg_414_1.actors_["10066ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos10066ui_story = var_417_4.localPosition
			end

			local var_417_5 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_5 then
				var_417_4.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_414_1.time_ - 0) / var_417_5)
				var_417_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_4.position).x, (manager.ui.mainCamera.transform.position - var_417_4.position).y, (manager.ui.mainCamera.transform.position - var_417_4.position).z)
				var_417_4.localEulerAngles.z = 0
				var_417_4.localEulerAngles.x = 0
				var_417_4.localEulerAngles = var_417_4.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_5 and arg_414_1.time_ < 0 + var_417_5 + arg_417_0 then
				var_417_4.localPosition = Vector3.New(0, -0.99, -5.83)
				var_417_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_4.position).x, (manager.ui.mainCamera.transform.position - var_417_4.position).y, (manager.ui.mainCamera.transform.position - var_417_4.position).z)
				var_417_4.localEulerAngles.z = 0
				var_417_4.localEulerAngles.x = 0
				var_417_4.localEulerAngles = var_417_4.localEulerAngles
			end

			local var_417_6 = 0
			local var_417_7 = 0.55

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_8 = arg_414_1:GetWordFromCfg(301011102)
				local var_417_9 = arg_414_1:FormatText(var_417_8.content)

				arg_414_1.text_.text = var_417_9

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 22 <= 0 and var_417_7 or var_417_7 * (utf8.len(var_417_9) / 22)

				if (22 <= 0 and var_417_7 or var_417_7 * (utf8.len(var_417_9) / 22)) > 0 and var_417_7 < var_417_11 then
					arg_414_1.talkMaxDuration = var_417_11

					if var_417_11 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_11 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_9
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011102", "story_v_out_301011.awb") ~= 0 then
					local var_417_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011102", "story_v_out_301011.awb") / 1000

					if var_417_12 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_12 + var_417_6
					end

					if var_417_8.prefab_name ~= "" and arg_414_1.actors_[var_417_8.prefab_name] ~= nil then
						local var_417_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_8.prefab_name].transform, "story_v_out_301011", "301011102", "story_v_out_301011.awb")

						arg_414_1:RecordAudio("301011102", var_417_13)
						arg_414_1:RecordAudio("301011102", var_417_13)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_301011", "301011102", "story_v_out_301011.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_301011", "301011102", "story_v_out_301011.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_14 and arg_414_1.time_ < var_417_6 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play301011103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 301011103
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play301011104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["10066ui_story"]) and arg_418_1.var_.characterEffect10066ui_story == nil then
				arg_418_1.var_.characterEffect10066ui_story = arg_418_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["10066ui_story"]) then
				if arg_418_1.var_.characterEffect10066ui_story and not isNil(arg_418_1.actors_["10066ui_story"]) then
					arg_418_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_418_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["10066ui_story"]) and arg_418_1.var_.characterEffect10066ui_story then
				arg_418_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_418_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.175

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(301011103).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 7 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 7)

				if (7 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 7)) > 0 and var_421_2 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_6 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_6 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_6

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_6 and arg_418_1.time_ < var_421_1 + var_421_6 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play301011104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 301011104
		arg_422_1.duration_ = 6.6

		local var_422_0 = {
			zh = 6.5,
			ja = 6.6
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play301011105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["10066ui_story"]) and arg_422_1.var_.characterEffect10066ui_story == nil then
				arg_422_1.var_.characterEffect10066ui_story = arg_422_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["10066ui_story"]) then
				if arg_422_1.var_.characterEffect10066ui_story and not isNil(arg_422_1.actors_["10066ui_story"]) then
					arg_422_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["10066ui_story"]) and arg_422_1.var_.characterEffect10066ui_story then
				arg_422_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_425_2 = arg_422_1.actors_["10066ui_story"].transform

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.var_.moveOldPos10066ui_story = var_425_2.localPosition
			end

			local var_425_3 = 0.001

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_3 then
				var_425_2.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_422_1.time_ - 0) / var_425_3)
				var_425_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_2.position).x, (manager.ui.mainCamera.transform.position - var_425_2.position).y, (manager.ui.mainCamera.transform.position - var_425_2.position).z)
				var_425_2.localEulerAngles.z = 0
				var_425_2.localEulerAngles.x = 0
				var_425_2.localEulerAngles = var_425_2.localEulerAngles
			end

			if arg_422_1.time_ >= 0 + var_425_3 and arg_422_1.time_ < 0 + var_425_3 + arg_425_0 then
				var_425_2.localPosition = Vector3.New(0, -0.99, -5.83)
				var_425_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_2.position).x, (manager.ui.mainCamera.transform.position - var_425_2.position).y, (manager.ui.mainCamera.transform.position - var_425_2.position).z)
				var_425_2.localEulerAngles.z = 0
				var_425_2.localEulerAngles.x = 0
				var_425_2.localEulerAngles = var_425_2.localEulerAngles
			end

			local var_425_4 = 0
			local var_425_5 = 0.45

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_6 = arg_422_1:GetWordFromCfg(301011104)
				local var_425_7 = arg_422_1:FormatText(var_425_6.content)

				arg_422_1.text_.text = var_425_7

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_9 = 18 <= 0 and var_425_5 or var_425_5 * (utf8.len(var_425_7) / 18)

				if (18 <= 0 and var_425_5 or var_425_5 * (utf8.len(var_425_7) / 18)) > 0 and var_425_5 < var_425_9 then
					arg_422_1.talkMaxDuration = var_425_9

					if var_425_9 + var_425_4 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_9 + var_425_4
					end
				end

				arg_422_1.text_.text = var_425_7
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011104", "story_v_out_301011.awb") ~= 0 then
					local var_425_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011104", "story_v_out_301011.awb") / 1000

					if var_425_10 + var_425_4 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_10 + var_425_4
					end

					if var_425_6.prefab_name ~= "" and arg_422_1.actors_[var_425_6.prefab_name] ~= nil then
						local var_425_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_6.prefab_name].transform, "story_v_out_301011", "301011104", "story_v_out_301011.awb")

						arg_422_1:RecordAudio("301011104", var_425_11)
						arg_422_1:RecordAudio("301011104", var_425_11)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_301011", "301011104", "story_v_out_301011.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_301011", "301011104", "story_v_out_301011.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_12 = math.max(var_425_5, arg_422_1.talkMaxDuration)

			if var_425_4 <= arg_422_1.time_ and arg_422_1.time_ < var_425_4 + var_425_12 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_4) / var_425_12

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_4 + var_425_12 and arg_422_1.time_ < var_425_4 + var_425_12 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play301011105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 301011105
		arg_426_1.duration_ = 5

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play301011106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["10066ui_story"]) and arg_426_1.var_.characterEffect10066ui_story == nil then
				arg_426_1.var_.characterEffect10066ui_story = arg_426_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["10066ui_story"]) then
				if arg_426_1.var_.characterEffect10066ui_story and not isNil(arg_426_1.actors_["10066ui_story"]) then
					arg_426_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_426_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_0)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["10066ui_story"]) and arg_426_1.var_.characterEffect10066ui_story then
				arg_426_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_426_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_429_1 = 0
			local var_429_2 = 0.325

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(301011105).content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 13 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 13)

				if (13 <= 0 and var_429_2 or var_429_2 * (utf8.len(var_429_3) / 13)) > 0 and var_429_2 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_1 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_1
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_6 = math.max(var_429_2, arg_426_1.talkMaxDuration)

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_6 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_1) / var_429_6

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_1 + var_429_6 and arg_426_1.time_ < var_429_1 + var_429_6 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play301011106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 301011106
		arg_430_1.duration_ = 9

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play301011107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 2 < arg_430_1.time_ and arg_430_1.time_ <= 2 + arg_433_0 then
				local var_433_0 = arg_430_1.bgs_.ST07

				arg_430_1.bgs_.ST07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_433_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_433_1 = var_433_0:GetComponent("SpriteRenderer")

				if var_433_1 and var_433_1.sprite then
					local var_433_2 = 2 * (var_433_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_433_0.transform.localScale = Vector3.New(var_433_2 / var_433_1.sprite.bounds.size.y < var_433_2 * manager.ui.mainCameraCom_.aspect / var_433_1.sprite.bounds.size.x and var_433_2 * manager.ui.mainCameraCom_.aspect / var_433_1.sprite.bounds.size.x or var_433_2 / var_433_1.sprite.bounds.size.y, var_433_2 / var_433_1.sprite.bounds.size.y < var_433_2 * manager.ui.mainCameraCom_.aspect / var_433_1.sprite.bounds.size.x and var_433_2 * manager.ui.mainCameraCom_.aspect / var_433_1.sprite.bounds.size.x or var_433_2 / var_433_1.sprite.bounds.size.y, 0)
				end

				for iter_433_0, iter_433_1 in pairs(arg_430_1.bgs_) do
					if iter_433_0 ~= "ST07" then
						iter_433_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_433_3 = 4

			if 4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_3 + arg_433_0 then
				arg_430_1.allBtn_.enabled = false
			end

			if arg_430_1.time_ >= var_433_3 + 0.3 and arg_430_1.time_ < var_433_3 + 0.3 + arg_433_0 then
				arg_430_1.allBtn_.enabled = true
			end

			local var_433_4 = 0

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.mask_.enabled = true
				arg_430_1.mask_.raycastTarget = true

				arg_430_1:SetGaussion(false)
			end

			local var_433_5 = 2

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_5 then
				local var_433_6 = Color.New(0, 0, 0)

				var_433_6.a = Mathf.Lerp(0, 1, (arg_430_1.time_ - var_433_4) / var_433_5)
				arg_430_1.mask_.color = var_433_6
			end

			if arg_430_1.time_ >= var_433_4 + var_433_5 and arg_430_1.time_ < var_433_4 + var_433_5 + arg_433_0 then
				local var_433_7 = Color.New(0, 0, 0)

				var_433_7.a = 1
				arg_430_1.mask_.color = var_433_7
			end

			local var_433_8 = 2

			if 2 < arg_430_1.time_ and arg_430_1.time_ <= var_433_8 + arg_433_0 then
				arg_430_1.mask_.enabled = true
				arg_430_1.mask_.raycastTarget = true

				arg_430_1:SetGaussion(false)
			end

			local var_433_9 = 2

			if var_433_8 <= arg_430_1.time_ and arg_430_1.time_ < var_433_8 + var_433_9 then
				local var_433_10 = Color.New(0, 0, 0)

				var_433_10.a = Mathf.Lerp(1, 0, (arg_430_1.time_ - var_433_8) / var_433_9)
				arg_430_1.mask_.color = var_433_10
			end

			if arg_430_1.time_ >= var_433_8 + var_433_9 and arg_430_1.time_ < var_433_8 + var_433_9 + arg_433_0 then
				local var_433_11 = Color.New(0, 0, 0)

				arg_430_1.mask_.enabled = false
				var_433_11.a = 0
				arg_430_1.mask_.color = var_433_11
			end

			local var_433_12 = arg_430_1.actors_["10066ui_story"].transform

			if 1.96599999815226 < arg_430_1.time_ and arg_430_1.time_ <= 1.96599999815226 + arg_433_0 then
				arg_430_1.var_.moveOldPos10066ui_story = var_433_12.localPosition
			end

			local var_433_13 = 0.001

			if 1.96599999815226 <= arg_430_1.time_ and arg_430_1.time_ < 1.96599999815226 + var_433_13 then
				var_433_12.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_430_1.time_ - 1.96599999815226) / var_433_13)
				var_433_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_12.position).x, (manager.ui.mainCamera.transform.position - var_433_12.position).y, (manager.ui.mainCamera.transform.position - var_433_12.position).z)
				var_433_12.localEulerAngles.z = 0
				var_433_12.localEulerAngles.x = 0
				var_433_12.localEulerAngles = var_433_12.localEulerAngles
			end

			if arg_430_1.time_ >= 1.96599999815226 + var_433_13 and arg_430_1.time_ < 1.96599999815226 + var_433_13 + arg_433_0 then
				var_433_12.localPosition = Vector3.New(0, 100, 0)
				var_433_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_433_12.position).x, (manager.ui.mainCamera.transform.position - var_433_12.position).y, (manager.ui.mainCamera.transform.position - var_433_12.position).z)
				var_433_12.localEulerAngles.z = 0
				var_433_12.localEulerAngles.x = 0
				var_433_12.localEulerAngles = var_433_12.localEulerAngles
			end

			if 1.2 < arg_430_1.time_ and arg_430_1.time_ <= 1.2 + arg_433_0 then
				arg_430_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.2 < arg_430_1.time_ and arg_430_1.time_ <= 0.2 + arg_433_0 then
				arg_430_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_430_1.frameCnt_ <= 1 then
				arg_430_1.dialog_:SetActive(false)
			end

			local var_433_16 = 4
			local var_433_17 = 0.775

			if 4 < arg_430_1.time_ and arg_430_1.time_ <= var_433_16 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0

				arg_430_1.dialog_:SetActive(true)

				arg_430_1.dialogCg_.alpha = 0

				local var_433_18 = LeanTween.value(arg_430_1.dialog_, 0, 1, 0.3)

				var_433_18:setOnUpdate(LuaHelper.FloatAction(function(arg_434_0)
					arg_430_1.dialogCg_.alpha = arg_434_0
				end))
				var_433_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_430_1.dialog_)
					var_433_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_430_1.duration_ = arg_430_1.duration_ + 0.3

				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_19 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(301011106).content)

				arg_430_1.text_.text = var_433_19

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_21 = 44 <= 0 and var_433_17 or var_433_17 * (utf8.len(var_433_19) / 44)

				if (44 <= 0 and var_433_17 or var_433_17 * (utf8.len(var_433_19) / 44)) > 0 and var_433_17 < var_433_21 then
					arg_430_1.talkMaxDuration = var_433_21
					var_433_16 = var_433_16 + 0.3

					if var_433_21 + var_433_16 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_21 + var_433_16
					end
				end

				arg_430_1.text_.text = var_433_19
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_22 = var_433_16 + 0.3
			local var_433_23 = math.max(var_433_17, arg_430_1.talkMaxDuration)

			if var_433_16 + 0.3 <= arg_430_1.time_ and arg_430_1.time_ < var_433_22 + var_433_23 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_22) / var_433_23

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_22 + var_433_23 and arg_430_1.time_ < var_433_22 + var_433_23 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play301011107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 301011107
		arg_436_1.duration_ = 5.3

		local var_436_0 = {
			zh = 4.066,
			ja = 5.3
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play301011108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos10066ui_story = arg_436_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).z)
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles = arg_436_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_436_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["10066ui_story"].transform.position).z)
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["10066ui_story"].transform.localEulerAngles = arg_436_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_439_1 = arg_436_1.actors_["10066ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect10066ui_story == nil then
				arg_436_1.var_.characterEffect10066ui_story = var_439_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_2 and not isNil(var_439_1) then
				if arg_436_1.var_.characterEffect10066ui_story and not isNil(var_439_1) then
					arg_436_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_2 and arg_436_1.time_ < 0 + var_439_2 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect10066ui_story then
				arg_436_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_439_4 = 0
			local var_439_5 = 0.5

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(301011107)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 20 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 20)

				if (20 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 20)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011107", "story_v_out_301011.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011107", "story_v_out_301011.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_out_301011", "301011107", "story_v_out_301011.awb")

						arg_436_1:RecordAudio("301011107", var_439_11)
						arg_436_1:RecordAudio("301011107", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_301011", "301011107", "story_v_out_301011.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_301011", "301011107", "story_v_out_301011.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play301011108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 301011108
		arg_440_1.duration_ = 9.37

		local var_440_0 = {
			zh = 6.766,
			ja = 9.366
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play301011109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action476")
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_443_0 = 0
			local var_443_1 = 0.9

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_2 = arg_440_1:GetWordFromCfg(301011108)
				local var_443_3 = arg_440_1:FormatText(var_443_2.content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 36 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_3) / 36)

				if (36 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_3) / 36)) > 0 and var_443_1 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011108", "story_v_out_301011.awb") ~= 0 then
					local var_443_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011108", "story_v_out_301011.awb") / 1000

					if var_443_6 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_6 + var_443_0
					end

					if var_443_2.prefab_name ~= "" and arg_440_1.actors_[var_443_2.prefab_name] ~= nil then
						local var_443_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_2.prefab_name].transform, "story_v_out_301011", "301011108", "story_v_out_301011.awb")

						arg_440_1:RecordAudio("301011108", var_443_7)
						arg_440_1:RecordAudio("301011108", var_443_7)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_301011", "301011108", "story_v_out_301011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_301011", "301011108", "story_v_out_301011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play301011109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 301011109
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play301011110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["10066ui_story"]) and arg_444_1.var_.characterEffect10066ui_story == nil then
				arg_444_1.var_.characterEffect10066ui_story = arg_444_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["10066ui_story"]) then
				if arg_444_1.var_.characterEffect10066ui_story and not isNil(arg_444_1.actors_["10066ui_story"]) then
					arg_444_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_444_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["10066ui_story"]) and arg_444_1.var_.characterEffect10066ui_story then
				arg_444_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_444_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0
			local var_447_2 = 0.275

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(301011109).content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 11 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 11)

				if (11 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 11)) > 0 and var_447_2 < var_447_5 then
					arg_444_1.talkMaxDuration = var_447_5

					if var_447_5 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_6 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_6 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_6

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_6 and arg_444_1.time_ < var_447_1 + var_447_6 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play301011110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 301011110
		arg_448_1.duration_ = 2.63

		local var_448_0 = {
			zh = 2.633,
			ja = 2.333
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play301011111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos1084ui_story = arg_448_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_451_0 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 then
				arg_448_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_448_1.time_ - 0) / var_451_0)
				arg_448_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).z)
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles = arg_448_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 then
				arg_448_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_448_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1084ui_story"].transform.position).z)
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1084ui_story"].transform.localEulerAngles = arg_448_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_451_1 = arg_448_1.actors_["10066ui_story"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos10066ui_story = var_451_1.localPosition
			end

			local var_451_2 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 then
				var_451_1.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_448_1.time_ - 0) / var_451_2)
				var_451_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_1.position).x, (manager.ui.mainCamera.transform.position - var_451_1.position).y, (manager.ui.mainCamera.transform.position - var_451_1.position).z)
				var_451_1.localEulerAngles.z = 0
				var_451_1.localEulerAngles.x = 0
				var_451_1.localEulerAngles = var_451_1.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 then
				var_451_1.localPosition = Vector3.New(0, 100, 0)
				var_451_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_451_1.position).x, (manager.ui.mainCamera.transform.position - var_451_1.position).y, (manager.ui.mainCamera.transform.position - var_451_1.position).z)
				var_451_1.localEulerAngles.z = 0
				var_451_1.localEulerAngles.x = 0
				var_451_1.localEulerAngles = var_451_1.localEulerAngles
			end

			local var_451_3 = arg_448_1.actors_["1084ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_3) and arg_448_1.var_.characterEffect1084ui_story == nil then
				arg_448_1.var_.characterEffect1084ui_story = var_451_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_4 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 and not isNil(var_451_3) then
				if arg_448_1.var_.characterEffect1084ui_story and not isNil(var_451_3) then
					arg_448_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 and not isNil(var_451_3) and arg_448_1.var_.characterEffect1084ui_story then
				arg_448_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_451_6 = 0
			local var_451_7 = 0.05

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_8 = arg_448_1:GetWordFromCfg(301011110)
				local var_451_9 = arg_448_1:FormatText(var_451_8.content)

				arg_448_1.text_.text = var_451_9

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_11 = 2 <= 0 and var_451_7 or var_451_7 * (utf8.len(var_451_9) / 2)

				if (2 <= 0 and var_451_7 or var_451_7 * (utf8.len(var_451_9) / 2)) > 0 and var_451_7 < var_451_11 then
					arg_448_1.talkMaxDuration = var_451_11

					if var_451_11 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_11 + var_451_6
					end
				end

				arg_448_1.text_.text = var_451_9
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011110", "story_v_out_301011.awb") ~= 0 then
					local var_451_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011110", "story_v_out_301011.awb") / 1000

					if var_451_12 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_12 + var_451_6
					end

					if var_451_8.prefab_name ~= "" and arg_448_1.actors_[var_451_8.prefab_name] ~= nil then
						local var_451_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_8.prefab_name].transform, "story_v_out_301011", "301011110", "story_v_out_301011.awb")

						arg_448_1:RecordAudio("301011110", var_451_13)
						arg_448_1:RecordAudio("301011110", var_451_13)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_301011", "301011110", "story_v_out_301011.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_301011", "301011110", "story_v_out_301011.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_14 = math.max(var_451_7, arg_448_1.talkMaxDuration)

			if var_451_6 <= arg_448_1.time_ and arg_448_1.time_ < var_451_6 + var_451_14 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_6) / var_451_14

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_6 + var_451_14 and arg_448_1.time_ < var_451_6 + var_451_14 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play301011111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 301011111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play301011112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1084ui_story = arg_452_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).z)
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles = arg_452_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1084ui_story"].transform.position).z)
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1084ui_story"].transform.localEulerAngles = arg_452_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["10066ui_story"].transform

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos10066ui_story = var_455_1.localPosition
			end

			local var_455_2 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 then
				var_455_1.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_2)
				var_455_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_1.position).x, (manager.ui.mainCamera.transform.position - var_455_1.position).y, (manager.ui.mainCamera.transform.position - var_455_1.position).z)
				var_455_1.localEulerAngles.z = 0
				var_455_1.localEulerAngles.x = 0
				var_455_1.localEulerAngles = var_455_1.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 then
				var_455_1.localPosition = Vector3.New(0, 100, 0)
				var_455_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_1.position).x, (manager.ui.mainCamera.transform.position - var_455_1.position).y, (manager.ui.mainCamera.transform.position - var_455_1.position).z)
				var_455_1.localEulerAngles.z = 0
				var_455_1.localEulerAngles.x = 0
				var_455_1.localEulerAngles = var_455_1.localEulerAngles
			end

			local var_455_3 = arg_452_1.actors_["1084ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_3) and arg_452_1.var_.characterEffect1084ui_story == nil then
				arg_452_1.var_.characterEffect1084ui_story = var_455_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_4 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 and not isNil(var_455_3) then
				if arg_452_1.var_.characterEffect1084ui_story and not isNil(var_455_3) then
					arg_452_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_4)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 and not isNil(var_455_3) and arg_452_1.var_.characterEffect1084ui_story then
				arg_452_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_455_5 = 0
			local var_455_6 = 1.45

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_5 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_7 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(301011111).content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_9 = 58 <= 0 and var_455_6 or var_455_6 * (utf8.len(var_455_7) / 58)

				if (58 <= 0 and var_455_6 or var_455_6 * (utf8.len(var_455_7) / 58)) > 0 and var_455_6 < var_455_9 then
					arg_452_1.talkMaxDuration = var_455_9

					if var_455_9 + var_455_5 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_9 + var_455_5
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_6, arg_452_1.talkMaxDuration)

			if var_455_5 <= arg_452_1.time_ and arg_452_1.time_ < var_455_5 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_5) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_5 + var_455_10 and arg_452_1.time_ < var_455_5 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play301011112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 301011112
		arg_456_1.duration_ = 7.57

		local var_456_0 = {
			zh = 6.233,
			ja = 7.566
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play301011113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1084ui_story = arg_456_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_459_0 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 then
				arg_456_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_456_1.time_ - 0) / var_459_0)
				arg_456_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).z)
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles = arg_456_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 then
				arg_456_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_456_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["1084ui_story"].transform.position).z)
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["1084ui_story"].transform.localEulerAngles = arg_456_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_459_1 = arg_456_1.actors_["1084ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1084ui_story == nil then
				arg_456_1.var_.characterEffect1084ui_story = var_459_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_2 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_2 and not isNil(var_459_1) then
				if arg_456_1.var_.characterEffect1084ui_story and not isNil(var_459_1) then
					arg_456_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_2 and arg_456_1.time_ < 0 + var_459_2 + arg_459_0 and not isNil(var_459_1) and arg_456_1.var_.characterEffect1084ui_story then
				arg_456_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_459_4 = 0
			local var_459_5 = 0.6

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_6 = arg_456_1:GetWordFromCfg(301011112)
				local var_459_7 = arg_456_1:FormatText(var_459_6.content)

				arg_456_1.text_.text = var_459_7

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_9 = 24 <= 0 and var_459_5 or var_459_5 * (utf8.len(var_459_7) / 24)

				if (24 <= 0 and var_459_5 or var_459_5 * (utf8.len(var_459_7) / 24)) > 0 and var_459_5 < var_459_9 then
					arg_456_1.talkMaxDuration = var_459_9

					if var_459_9 + var_459_4 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_9 + var_459_4
					end
				end

				arg_456_1.text_.text = var_459_7
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011112", "story_v_out_301011.awb") ~= 0 then
					local var_459_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011112", "story_v_out_301011.awb") / 1000

					if var_459_10 + var_459_4 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_4
					end

					if var_459_6.prefab_name ~= "" and arg_456_1.actors_[var_459_6.prefab_name] ~= nil then
						local var_459_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_6.prefab_name].transform, "story_v_out_301011", "301011112", "story_v_out_301011.awb")

						arg_456_1:RecordAudio("301011112", var_459_11)
						arg_456_1:RecordAudio("301011112", var_459_11)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_301011", "301011112", "story_v_out_301011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_301011", "301011112", "story_v_out_301011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_12 = math.max(var_459_5, arg_456_1.talkMaxDuration)

			if var_459_4 <= arg_456_1.time_ and arg_456_1.time_ < var_459_4 + var_459_12 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_4) / var_459_12

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_4 + var_459_12 and arg_456_1.time_ < var_459_4 + var_459_12 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play301011113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 301011113
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play301011114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["1084ui_story"]) and arg_460_1.var_.characterEffect1084ui_story == nil then
				arg_460_1.var_.characterEffect1084ui_story = arg_460_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_0 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["1084ui_story"]) then
				if arg_460_1.var_.characterEffect1084ui_story and not isNil(arg_460_1.actors_["1084ui_story"]) then
					arg_460_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_460_1.time_ - 0) / var_463_0)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["1084ui_story"]) and arg_460_1.var_.characterEffect1084ui_story then
				arg_460_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_463_1 = 0
			local var_463_2 = 0.3

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(301011113).content)

				arg_460_1.text_.text = var_463_3

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 12 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 12)

				if (12 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 12)) > 0 and var_463_2 < var_463_5 then
					arg_460_1.talkMaxDuration = var_463_5

					if var_463_5 + var_463_1 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + var_463_1
					end
				end

				arg_460_1.text_.text = var_463_3
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_6 = math.max(var_463_2, arg_460_1.talkMaxDuration)

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_6 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_1) / var_463_6

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_1 + var_463_6 and arg_460_1.time_ < var_463_1 + var_463_6 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play301011114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 301011114
		arg_464_1.duration_ = 8.53

		local var_464_0 = {
			zh = 8.533,
			ja = 6.6
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play301011115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1084ui_story = arg_464_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_467_0 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 then
				arg_464_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_464_1.time_ - 0) / var_467_0)
				arg_464_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).z)
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles = arg_464_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 then
				arg_464_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_464_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1084ui_story"].transform.position).z)
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1084ui_story"].transform.localEulerAngles = arg_464_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_467_1 = arg_464_1.actors_["1084ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1084ui_story == nil then
				arg_464_1.var_.characterEffect1084ui_story = var_467_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_2 and not isNil(var_467_1) then
				if arg_464_1.var_.characterEffect1084ui_story and not isNil(var_467_1) then
					arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_2 and arg_464_1.time_ < 0 + var_467_2 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1084ui_story then
				arg_464_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_467_4 = 0
			local var_467_5 = 0.475

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_6 = arg_464_1:GetWordFromCfg(301011114)
				local var_467_7 = arg_464_1:FormatText(var_467_6.content)

				arg_464_1.text_.text = var_467_7

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_9 = 19 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 19)

				if (19 <= 0 and var_467_5 or var_467_5 * (utf8.len(var_467_7) / 19)) > 0 and var_467_5 < var_467_9 then
					arg_464_1.talkMaxDuration = var_467_9

					if var_467_9 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_9 + var_467_4
					end
				end

				arg_464_1.text_.text = var_467_7
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011114", "story_v_out_301011.awb") ~= 0 then
					local var_467_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011114", "story_v_out_301011.awb") / 1000

					if var_467_10 + var_467_4 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_4
					end

					if var_467_6.prefab_name ~= "" and arg_464_1.actors_[var_467_6.prefab_name] ~= nil then
						local var_467_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_6.prefab_name].transform, "story_v_out_301011", "301011114", "story_v_out_301011.awb")

						arg_464_1:RecordAudio("301011114", var_467_11)
						arg_464_1:RecordAudio("301011114", var_467_11)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_301011", "301011114", "story_v_out_301011.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_301011", "301011114", "story_v_out_301011.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_12 = math.max(var_467_5, arg_464_1.talkMaxDuration)

			if var_467_4 <= arg_464_1.time_ and arg_464_1.time_ < var_467_4 + var_467_12 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_4) / var_467_12

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_4 + var_467_12 and arg_464_1.time_ < var_467_4 + var_467_12 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play301011115 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 301011115
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play301011116(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos1084ui_story = arg_468_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).z)
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles = arg_468_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_468_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1084ui_story"].transform.position).z)
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1084ui_story"].transform.localEulerAngles = arg_468_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["1084ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1084ui_story == nil then
				arg_468_1.var_.characterEffect1084ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1084ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_2)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1084ui_story then
				arg_468_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_471_3 = 0
			local var_471_4 = 1.525

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_3 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_5 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(301011115).content)

				arg_468_1.text_.text = var_471_5

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_7 = 61 <= 0 and var_471_4 or var_471_4 * (utf8.len(var_471_5) / 61)

				if (61 <= 0 and var_471_4 or var_471_4 * (utf8.len(var_471_5) / 61)) > 0 and var_471_4 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_3 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_3
					end
				end

				arg_468_1.text_.text = var_471_5
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_8 = math.max(var_471_4, arg_468_1.talkMaxDuration)

			if var_471_3 <= arg_468_1.time_ and arg_468_1.time_ < var_471_3 + var_471_8 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_3) / var_471_8

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_3 + var_471_8 and arg_468_1.time_ < var_471_3 + var_471_8 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_468_1:InitPlayNodeList()
	end,
	Play301011116 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 301011116
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play301011117(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_475_1 = 0
			local var_475_2 = 0.675

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_3 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(301011116).content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 27 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 27)

				if (27 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 27)) > 0 and var_475_2 < var_475_5 then
					arg_472_1.talkMaxDuration = var_475_5

					if var_475_5 + var_475_1 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + var_475_1
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_6 = math.max(var_475_2, arg_472_1.talkMaxDuration)

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_6 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_1) / var_475_6

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_1 + var_475_6 and arg_472_1.time_ < var_475_1 + var_475_6 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play301011117 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 301011117
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play301011118(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.65

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(301011117).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 26 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 26)

				if (26 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 26)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play301011118 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 301011118
		arg_480_1.duration_ = 9

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play301011119(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 2 < arg_480_1.time_ and arg_480_1.time_ <= 2 + arg_483_0 then
				local var_483_0 = arg_480_1.bgs_.STblack

				arg_480_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_483_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_483_1 = var_483_0:GetComponent("SpriteRenderer")

				if var_483_1 and var_483_1.sprite then
					local var_483_2 = 2 * (var_483_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_483_0.transform.localScale = Vector3.New(var_483_2 / var_483_1.sprite.bounds.size.y < var_483_2 * manager.ui.mainCameraCom_.aspect / var_483_1.sprite.bounds.size.x and var_483_2 * manager.ui.mainCameraCom_.aspect / var_483_1.sprite.bounds.size.x or var_483_2 / var_483_1.sprite.bounds.size.y, var_483_2 / var_483_1.sprite.bounds.size.y < var_483_2 * manager.ui.mainCameraCom_.aspect / var_483_1.sprite.bounds.size.x and var_483_2 * manager.ui.mainCameraCom_.aspect / var_483_1.sprite.bounds.size.x or var_483_2 / var_483_1.sprite.bounds.size.y, 0)
				end

				for iter_483_0, iter_483_1 in pairs(arg_480_1.bgs_) do
					if iter_483_0 ~= "STblack" then
						iter_483_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_483_3 = 4

			if 4 < arg_480_1.time_ and arg_480_1.time_ <= var_483_3 + arg_483_0 then
				arg_480_1.allBtn_.enabled = false
			end

			if arg_480_1.time_ >= var_483_3 + 0.3 and arg_480_1.time_ < var_483_3 + 0.3 + arg_483_0 then
				arg_480_1.allBtn_.enabled = true
			end

			local var_483_4 = 0

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.mask_.enabled = true
				arg_480_1.mask_.raycastTarget = true

				arg_480_1:SetGaussion(false)
			end

			local var_483_5 = 2

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_5 then
				local var_483_6 = Color.New(0, 0, 0)

				var_483_6.a = Mathf.Lerp(0, 1, (arg_480_1.time_ - var_483_4) / var_483_5)
				arg_480_1.mask_.color = var_483_6
			end

			if arg_480_1.time_ >= var_483_4 + var_483_5 and arg_480_1.time_ < var_483_4 + var_483_5 + arg_483_0 then
				local var_483_7 = Color.New(0, 0, 0)

				var_483_7.a = 1
				arg_480_1.mask_.color = var_483_7
			end

			local var_483_8 = 2

			if 2 < arg_480_1.time_ and arg_480_1.time_ <= var_483_8 + arg_483_0 then
				arg_480_1.mask_.enabled = true
				arg_480_1.mask_.raycastTarget = true

				arg_480_1:SetGaussion(false)
			end

			local var_483_9 = 2

			if var_483_8 <= arg_480_1.time_ and arg_480_1.time_ < var_483_8 + var_483_9 then
				local var_483_10 = Color.New(0, 0, 0)

				var_483_10.a = Mathf.Lerp(1, 0, (arg_480_1.time_ - var_483_8) / var_483_9)
				arg_480_1.mask_.color = var_483_10
			end

			if arg_480_1.time_ >= var_483_8 + var_483_9 and arg_480_1.time_ < var_483_8 + var_483_9 + arg_483_0 then
				local var_483_11 = Color.New(0, 0, 0)

				arg_480_1.mask_.enabled = false
				var_483_11.a = 0
				arg_480_1.mask_.color = var_483_11
			end

			if arg_480_1.frameCnt_ <= 1 then
				arg_480_1.dialog_:SetActive(false)
			end

			local var_483_12 = 4
			local var_483_13 = 1.775

			if 4 < arg_480_1.time_ and arg_480_1.time_ <= var_483_12 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0

				arg_480_1.dialog_:SetActive(true)

				arg_480_1.dialogCg_.alpha = 0

				local var_483_14 = LeanTween.value(arg_480_1.dialog_, 0, 1, 0.3)

				var_483_14:setOnUpdate(LuaHelper.FloatAction(function(arg_484_0)
					arg_480_1.dialogCg_.alpha = arg_484_0
				end))
				var_483_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_480_1.dialog_)
					var_483_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_480_1.duration_ = arg_480_1.duration_ + 0.3

				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_15 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(301011118).content)

				arg_480_1.text_.text = var_483_15

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_17 = 71 <= 0 and var_483_13 or var_483_13 * (utf8.len(var_483_15) / 71)

				if (71 <= 0 and var_483_13 or var_483_13 * (utf8.len(var_483_15) / 71)) > 0 and var_483_13 < var_483_17 then
					arg_480_1.talkMaxDuration = var_483_17
					var_483_12 = var_483_12 + 0.3

					if var_483_17 + var_483_12 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_17 + var_483_12
					end
				end

				arg_480_1.text_.text = var_483_15
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_18 = var_483_12 + 0.3
			local var_483_19 = math.max(var_483_13, arg_480_1.talkMaxDuration)

			if var_483_12 + 0.3 <= arg_480_1.time_ and arg_480_1.time_ < var_483_18 + var_483_19 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_18) / var_483_19

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_18 + var_483_19 and arg_480_1.time_ < var_483_18 + var_483_19 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play301011119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 301011119
		arg_486_1.duration_ = 7

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play301011120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if arg_486_1.bgs_.I02f == nil then
				local var_489_0 = Object.Instantiate(arg_486_1.paintGo_)

				var_489_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I02f")
				var_489_0.name = "I02f"
				var_489_0.transform.parent = arg_486_1.stage_.transform
				var_489_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_486_1.bgs_.I02f = var_489_0
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				local var_489_1 = arg_486_1.bgs_.I02f

				arg_486_1.bgs_.I02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_489_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_489_2 = var_489_1:GetComponent("SpriteRenderer")

				if var_489_2 and var_489_2.sprite then
					local var_489_3 = 2 * (var_489_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_489_1.transform.localScale = Vector3.New(var_489_3 / var_489_2.sprite.bounds.size.y < var_489_3 * manager.ui.mainCameraCom_.aspect / var_489_2.sprite.bounds.size.x and var_489_3 * manager.ui.mainCameraCom_.aspect / var_489_2.sprite.bounds.size.x or var_489_3 / var_489_2.sprite.bounds.size.y, var_489_3 / var_489_2.sprite.bounds.size.y < var_489_3 * manager.ui.mainCameraCom_.aspect / var_489_2.sprite.bounds.size.x and var_489_3 * manager.ui.mainCameraCom_.aspect / var_489_2.sprite.bounds.size.x or var_489_3 / var_489_2.sprite.bounds.size.y, 0)
				end

				for iter_489_0, iter_489_1 in pairs(arg_486_1.bgs_) do
					if iter_489_0 ~= "I02f" then
						iter_489_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_489_4 = 2

			if 2 < arg_486_1.time_ and arg_486_1.time_ <= var_489_4 + arg_489_0 then
				arg_486_1.allBtn_.enabled = false
			end

			if arg_486_1.time_ >= var_489_4 + 0.3 and arg_486_1.time_ < var_489_4 + 0.3 + arg_489_0 then
				arg_486_1.allBtn_.enabled = true
			end

			local var_489_5 = 0

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_5 + arg_489_0 then
				arg_486_1.mask_.enabled = true
				arg_486_1.mask_.raycastTarget = true

				arg_486_1:SetGaussion(false)
			end

			local var_489_6 = 2

			if var_489_5 <= arg_486_1.time_ and arg_486_1.time_ < var_489_5 + var_489_6 then
				local var_489_7 = Color.New(0, 0, 0)

				var_489_7.a = Mathf.Lerp(1, 0, (arg_486_1.time_ - var_489_5) / var_489_6)
				arg_486_1.mask_.color = var_489_7
			end

			if arg_486_1.time_ >= var_489_5 + var_489_6 and arg_486_1.time_ < var_489_5 + var_489_6 + arg_489_0 then
				local var_489_8 = Color.New(0, 0, 0)

				arg_486_1.mask_.enabled = false
				var_489_8.a = 0
				arg_486_1.mask_.color = var_489_8
			end

			if 1.2 < arg_486_1.time_ and arg_486_1.time_ <= 1.2 + arg_489_0 then
				arg_486_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.2 < arg_486_1.time_ and arg_486_1.time_ <= 0.2 + arg_489_0 then
				arg_486_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_486_1.frameCnt_ <= 1 then
				arg_486_1.dialog_:SetActive(false)
			end

			local var_489_11 = 2
			local var_489_12 = 1.3

			if 2 < arg_486_1.time_ and arg_486_1.time_ <= var_489_11 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0

				arg_486_1.dialog_:SetActive(true)

				arg_486_1.dialogCg_.alpha = 0

				local var_489_13 = LeanTween.value(arg_486_1.dialog_, 0, 1, 0.3)

				var_489_13:setOnUpdate(LuaHelper.FloatAction(function(arg_490_0)
					arg_486_1.dialogCg_.alpha = arg_490_0
				end))
				var_489_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_486_1.dialog_)
					var_489_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_486_1.duration_ = arg_486_1.duration_ + 0.3

				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_14 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(301011119).content)

				arg_486_1.text_.text = var_489_14

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_16 = 52 <= 0 and var_489_12 or var_489_12 * (utf8.len(var_489_14) / 52)

				if (52 <= 0 and var_489_12 or var_489_12 * (utf8.len(var_489_14) / 52)) > 0 and var_489_12 < var_489_16 then
					arg_486_1.talkMaxDuration = var_489_16
					var_489_11 = var_489_11 + 0.3

					if var_489_16 + var_489_11 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_16 + var_489_11
					end
				end

				arg_486_1.text_.text = var_489_14
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_17 = var_489_11 + 0.3
			local var_489_18 = math.max(var_489_12, arg_486_1.talkMaxDuration)

			if var_489_11 + 0.3 <= arg_486_1.time_ and arg_486_1.time_ < var_489_17 + var_489_18 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_17) / var_489_18

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_17 + var_489_18 and arg_486_1.time_ < var_489_17 + var_489_18 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play301011120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 301011120
		arg_492_1.duration_ = 12.63

		local var_492_0 = {
			zh = 11.3,
			ja = 12.633
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play301011121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10066ui_story = arg_492_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_495_0 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 then
				arg_492_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_492_1.time_ - 0) / var_495_0)
				arg_492_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).z)
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles = arg_492_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 then
				arg_492_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_492_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["10066ui_story"].transform.position).z)
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["10066ui_story"].transform.localEulerAngles = arg_492_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_495_1 = arg_492_1.actors_["10066ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect10066ui_story == nil then
				arg_492_1.var_.characterEffect10066ui_story = var_495_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_2 and not isNil(var_495_1) then
				if arg_492_1.var_.characterEffect10066ui_story and not isNil(var_495_1) then
					arg_492_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= 0 + var_495_2 and arg_492_1.time_ < 0 + var_495_2 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect10066ui_story then
				arg_492_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_495_4 = 0
			local var_495_5 = 1.2

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_4 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_6 = arg_492_1:GetWordFromCfg(301011120)
				local var_495_7 = arg_492_1:FormatText(var_495_6.content)

				arg_492_1.text_.text = var_495_7

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_9 = 48 <= 0 and var_495_5 or var_495_5 * (utf8.len(var_495_7) / 48)

				if (48 <= 0 and var_495_5 or var_495_5 * (utf8.len(var_495_7) / 48)) > 0 and var_495_5 < var_495_9 then
					arg_492_1.talkMaxDuration = var_495_9

					if var_495_9 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_9 + var_495_4
					end
				end

				arg_492_1.text_.text = var_495_7
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011120", "story_v_out_301011.awb") ~= 0 then
					local var_495_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011120", "story_v_out_301011.awb") / 1000

					if var_495_10 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_10 + var_495_4
					end

					if var_495_6.prefab_name ~= "" and arg_492_1.actors_[var_495_6.prefab_name] ~= nil then
						local var_495_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_6.prefab_name].transform, "story_v_out_301011", "301011120", "story_v_out_301011.awb")

						arg_492_1:RecordAudio("301011120", var_495_11)
						arg_492_1:RecordAudio("301011120", var_495_11)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_301011", "301011120", "story_v_out_301011.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_301011", "301011120", "story_v_out_301011.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_12 = math.max(var_495_5, arg_492_1.talkMaxDuration)

			if var_495_4 <= arg_492_1.time_ and arg_492_1.time_ < var_495_4 + var_495_12 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_4) / var_495_12

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_4 + var_495_12 and arg_492_1.time_ < var_495_4 + var_495_12 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play301011121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 301011121
		arg_496_1.duration_ = 3.5

		local var_496_0 = {
			zh = 2.8,
			ja = 3.5
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play301011122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if arg_496_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_499_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_496_1.stage_.transform)

				var_499_0.name = "1019ui_story"
				var_499_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.actors_["1019ui_story"] = var_499_0

				local var_499_1 = var_499_0:GetComponentInChildren(typeof(CharacterEffect))

				var_499_1.enabled = true

				local var_499_2 = GameObjectTools.GetOrAddComponent(var_499_0, typeof(DynamicBoneHelper))

				if var_499_2 then
					var_499_2:EnableDynamicBone(false)
				end

				arg_496_1:ShowWeapon(var_499_1.transform, false)

				arg_496_1.var_["1019ui_story" .. "Animator"] = var_499_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_496_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_496_1.var_["1019ui_story" .. "LipSync"] = var_499_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_499_3 = arg_496_1.actors_["1019ui_story"].transform

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos1019ui_story = var_499_3.localPosition
			end

			local var_499_4 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				var_499_3.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_496_1.time_ - 0) / var_499_4)
				var_499_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_499_3.position).x, (manager.ui.mainCamera.transform.position - var_499_3.position).y, (manager.ui.mainCamera.transform.position - var_499_3.position).z)
				var_499_3.localEulerAngles.z = 0
				var_499_3.localEulerAngles.x = 0
				var_499_3.localEulerAngles = var_499_3.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				var_499_3.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_499_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_499_3.position).x, (manager.ui.mainCamera.transform.position - var_499_3.position).y, (manager.ui.mainCamera.transform.position - var_499_3.position).z)
				var_499_3.localEulerAngles.z = 0
				var_499_3.localEulerAngles.x = 0
				var_499_3.localEulerAngles = var_499_3.localEulerAngles
			end

			local var_499_5 = arg_496_1.actors_["1019ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_5) and arg_496_1.var_.characterEffect1019ui_story == nil then
				arg_496_1.var_.characterEffect1019ui_story = var_499_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_6 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_6 and not isNil(var_499_5) then
				if arg_496_1.var_.characterEffect1019ui_story and not isNil(var_499_5) then
					arg_496_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= 0 + var_499_6 and arg_496_1.time_ < 0 + var_499_6 + arg_499_0 and not isNil(var_499_5) and arg_496_1.var_.characterEffect1019ui_story then
				arg_496_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_499_8 = arg_496_1.actors_["10066ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.characterEffect10066ui_story == nil then
				arg_496_1.var_.characterEffect10066ui_story = var_499_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_9 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_9 and not isNil(var_499_8) then
				if arg_496_1.var_.characterEffect10066ui_story and not isNil(var_499_8) then
					arg_496_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_496_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_496_1.time_ - 0) / var_499_9)
				end
			end

			if arg_496_1.time_ >= 0 + var_499_9 and arg_496_1.time_ < 0 + var_499_9 + arg_499_0 and not isNil(var_499_8) and arg_496_1.var_.characterEffect10066ui_story then
				arg_496_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_496_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_499_10 = 0
			local var_499_11 = 0.35

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_10 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_12 = arg_496_1:GetWordFromCfg(301011121)
				local var_499_13 = arg_496_1:FormatText(var_499_12.content)

				arg_496_1.text_.text = var_499_13

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_15 = 14 <= 0 and var_499_11 or var_499_11 * (utf8.len(var_499_13) / 14)

				if (14 <= 0 and var_499_11 or var_499_11 * (utf8.len(var_499_13) / 14)) > 0 and var_499_11 < var_499_15 then
					arg_496_1.talkMaxDuration = var_499_15

					if var_499_15 + var_499_10 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_15 + var_499_10
					end
				end

				arg_496_1.text_.text = var_499_13
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011121", "story_v_out_301011.awb") ~= 0 then
					local var_499_16 = manager.audio:GetVoiceLength("story_v_out_301011", "301011121", "story_v_out_301011.awb") / 1000

					if var_499_16 + var_499_10 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_16 + var_499_10
					end

					if var_499_12.prefab_name ~= "" and arg_496_1.actors_[var_499_12.prefab_name] ~= nil then
						local var_499_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_12.prefab_name].transform, "story_v_out_301011", "301011121", "story_v_out_301011.awb")

						arg_496_1:RecordAudio("301011121", var_499_17)
						arg_496_1:RecordAudio("301011121", var_499_17)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_301011", "301011121", "story_v_out_301011.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_301011", "301011121", "story_v_out_301011.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_18 = math.max(var_499_11, arg_496_1.talkMaxDuration)

			if var_499_10 <= arg_496_1.time_ and arg_496_1.time_ < var_499_10 + var_499_18 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_10) / var_499_18

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_10 + var_499_18 and arg_496_1.time_ < var_499_10 + var_499_18 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play301011122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 301011122
		arg_500_1.duration_ = 6.6

		local var_500_0 = {
			zh = 6.6,
			ja = 6.066
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play301011123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["10066ui_story"]) and arg_500_1.var_.characterEffect10066ui_story == nil then
				arg_500_1.var_.characterEffect10066ui_story = arg_500_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_0 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["10066ui_story"]) then
				if arg_500_1.var_.characterEffect10066ui_story and not isNil(arg_500_1.actors_["10066ui_story"]) then
					arg_500_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["10066ui_story"]) and arg_500_1.var_.characterEffect10066ui_story then
				arg_500_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_503_2 = arg_500_1.actors_["1019ui_story"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.characterEffect1019ui_story == nil then
				arg_500_1.var_.characterEffect1019ui_story = var_503_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_3 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_3 and not isNil(var_503_2) then
				if arg_500_1.var_.characterEffect1019ui_story and not isNil(var_503_2) then
					arg_500_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_500_1.time_ - 0) / var_503_3)
				end
			end

			if arg_500_1.time_ >= 0 + var_503_3 and arg_500_1.time_ < 0 + var_503_3 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.characterEffect1019ui_story then
				arg_500_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_503_4 = 0
			local var_503_5 = 0.575

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_4 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_6 = arg_500_1:GetWordFromCfg(301011122)
				local var_503_7 = arg_500_1:FormatText(var_503_6.content)

				arg_500_1.text_.text = var_503_7

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_9 = 23 <= 0 and var_503_5 or var_503_5 * (utf8.len(var_503_7) / 23)

				if (23 <= 0 and var_503_5 or var_503_5 * (utf8.len(var_503_7) / 23)) > 0 and var_503_5 < var_503_9 then
					arg_500_1.talkMaxDuration = var_503_9

					if var_503_9 + var_503_4 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_9 + var_503_4
					end
				end

				arg_500_1.text_.text = var_503_7
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011122", "story_v_out_301011.awb") ~= 0 then
					local var_503_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011122", "story_v_out_301011.awb") / 1000

					if var_503_10 + var_503_4 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_10 + var_503_4
					end

					if var_503_6.prefab_name ~= "" and arg_500_1.actors_[var_503_6.prefab_name] ~= nil then
						local var_503_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_6.prefab_name].transform, "story_v_out_301011", "301011122", "story_v_out_301011.awb")

						arg_500_1:RecordAudio("301011122", var_503_11)
						arg_500_1:RecordAudio("301011122", var_503_11)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_301011", "301011122", "story_v_out_301011.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_301011", "301011122", "story_v_out_301011.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_12 = math.max(var_503_5, arg_500_1.talkMaxDuration)

			if var_503_4 <= arg_500_1.time_ and arg_500_1.time_ < var_503_4 + var_503_12 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_4) / var_503_12

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_4 + var_503_12 and arg_500_1.time_ < var_503_4 + var_503_12 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play301011123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 301011123
		arg_504_1.duration_ = 11.1

		local var_504_0 = {
			zh = 9.8,
			ja = 11.1
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play301011124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_507_0 = 0
			local var_507_1 = 1.05

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_2 = arg_504_1:GetWordFromCfg(301011123)
				local var_507_3 = arg_504_1:FormatText(var_507_2.content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 42 <= 0 and var_507_1 or var_507_1 * (utf8.len(var_507_3) / 42)

				if (42 <= 0 and var_507_1 or var_507_1 * (utf8.len(var_507_3) / 42)) > 0 and var_507_1 < var_507_5 then
					arg_504_1.talkMaxDuration = var_507_5

					if var_507_5 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011123", "story_v_out_301011.awb") ~= 0 then
					local var_507_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011123", "story_v_out_301011.awb") / 1000

					if var_507_6 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_6 + var_507_0
					end

					if var_507_2.prefab_name ~= "" and arg_504_1.actors_[var_507_2.prefab_name] ~= nil then
						local var_507_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_2.prefab_name].transform, "story_v_out_301011", "301011123", "story_v_out_301011.awb")

						arg_504_1:RecordAudio("301011123", var_507_7)
						arg_504_1:RecordAudio("301011123", var_507_7)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_301011", "301011123", "story_v_out_301011.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_301011", "301011123", "story_v_out_301011.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_8 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_8 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_8

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_8 and arg_504_1.time_ < var_507_0 + var_507_8 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play301011124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 301011124
		arg_508_1.duration_ = 2.87

		local var_508_0 = {
			zh = 2.166,
			ja = 2.866
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play301011125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["1019ui_story"]) and arg_508_1.var_.characterEffect1019ui_story == nil then
				arg_508_1.var_.characterEffect1019ui_story = arg_508_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_0 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["1019ui_story"]) then
				if arg_508_1.var_.characterEffect1019ui_story and not isNil(arg_508_1.actors_["1019ui_story"]) then
					arg_508_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["1019ui_story"]) and arg_508_1.var_.characterEffect1019ui_story then
				arg_508_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_511_2 = arg_508_1.actors_["10066ui_story"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.characterEffect10066ui_story == nil then
				arg_508_1.var_.characterEffect10066ui_story = var_511_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_3 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_3 and not isNil(var_511_2) then
				if arg_508_1.var_.characterEffect10066ui_story and not isNil(var_511_2) then
					arg_508_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_508_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_508_1.time_ - 0) / var_511_3)
				end
			end

			if arg_508_1.time_ >= 0 + var_511_3 and arg_508_1.time_ < 0 + var_511_3 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.characterEffect10066ui_story then
				arg_508_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_508_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_511_4 = 0
			local var_511_5 = 0.225

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_6 = arg_508_1:GetWordFromCfg(301011124)
				local var_511_7 = arg_508_1:FormatText(var_511_6.content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 9 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 9)

				if (9 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 9)) > 0 and var_511_5 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_4
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011124", "story_v_out_301011.awb") ~= 0 then
					local var_511_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011124", "story_v_out_301011.awb") / 1000

					if var_511_10 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_4
					end

					if var_511_6.prefab_name ~= "" and arg_508_1.actors_[var_511_6.prefab_name] ~= nil then
						local var_511_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_6.prefab_name].transform, "story_v_out_301011", "301011124", "story_v_out_301011.awb")

						arg_508_1:RecordAudio("301011124", var_511_11)
						arg_508_1:RecordAudio("301011124", var_511_11)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_301011", "301011124", "story_v_out_301011.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_301011", "301011124", "story_v_out_301011.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_12 = math.max(var_511_5, arg_508_1.talkMaxDuration)

			if var_511_4 <= arg_508_1.time_ and arg_508_1.time_ < var_511_4 + var_511_12 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_4) / var_511_12

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_4 + var_511_12 and arg_508_1.time_ < var_511_4 + var_511_12 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play301011125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 301011125
		arg_512_1.duration_ = 4.43

		local var_512_0 = {
			zh = 4.433,
			ja = 3.433
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play301011126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos1084ui_story = arg_512_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_515_0 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 then
				arg_512_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_512_1.time_ - 0) / var_515_0)
				arg_512_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).z)
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles = arg_512_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 then
				arg_512_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_512_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["1084ui_story"].transform.position).z)
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["1084ui_story"].transform.localEulerAngles = arg_512_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_515_1 = arg_512_1.actors_["10066ui_story"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos10066ui_story = var_515_1.localPosition
			end

			local var_515_2 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_2 then
				var_515_1.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_512_1.time_ - 0) / var_515_2)
				var_515_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_1.position).x, (manager.ui.mainCamera.transform.position - var_515_1.position).y, (manager.ui.mainCamera.transform.position - var_515_1.position).z)
				var_515_1.localEulerAngles.z = 0
				var_515_1.localEulerAngles.x = 0
				var_515_1.localEulerAngles = var_515_1.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_2 and arg_512_1.time_ < 0 + var_515_2 + arg_515_0 then
				var_515_1.localPosition = Vector3.New(0, 100, 0)
				var_515_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_1.position).x, (manager.ui.mainCamera.transform.position - var_515_1.position).y, (manager.ui.mainCamera.transform.position - var_515_1.position).z)
				var_515_1.localEulerAngles.z = 0
				var_515_1.localEulerAngles.x = 0
				var_515_1.localEulerAngles = var_515_1.localEulerAngles
			end

			local var_515_3 = arg_512_1.actors_["1084ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_3) and arg_512_1.var_.characterEffect1084ui_story == nil then
				arg_512_1.var_.characterEffect1084ui_story = var_515_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_4 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_4 and not isNil(var_515_3) then
				if arg_512_1.var_.characterEffect1084ui_story and not isNil(var_515_3) then
					arg_512_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_4 and arg_512_1.time_ < 0 + var_515_4 + arg_515_0 and not isNil(var_515_3) and arg_512_1.var_.characterEffect1084ui_story then
				arg_512_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_515_6 = arg_512_1.actors_["1019ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_6) and arg_512_1.var_.characterEffect1019ui_story == nil then
				arg_512_1.var_.characterEffect1019ui_story = var_515_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_7 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_7 and not isNil(var_515_6) then
				if arg_512_1.var_.characterEffect1019ui_story and not isNil(var_515_6) then
					arg_512_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_512_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_7)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_7 and arg_512_1.time_ < 0 + var_515_7 + arg_515_0 and not isNil(var_515_6) and arg_512_1.var_.characterEffect1019ui_story then
				arg_512_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_512_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_515_8 = 0
			local var_515_9 = 0.45

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_8 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_10 = arg_512_1:GetWordFromCfg(301011125)
				local var_515_11 = arg_512_1:FormatText(var_515_10.content)

				arg_512_1.text_.text = var_515_11

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_13 = 18 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_11) / 18)

				if (18 <= 0 and var_515_9 or var_515_9 * (utf8.len(var_515_11) / 18)) > 0 and var_515_9 < var_515_13 then
					arg_512_1.talkMaxDuration = var_515_13

					if var_515_13 + var_515_8 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_13 + var_515_8
					end
				end

				arg_512_1.text_.text = var_515_11
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011125", "story_v_out_301011.awb") ~= 0 then
					local var_515_14 = manager.audio:GetVoiceLength("story_v_out_301011", "301011125", "story_v_out_301011.awb") / 1000

					if var_515_14 + var_515_8 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_14 + var_515_8
					end

					if var_515_10.prefab_name ~= "" and arg_512_1.actors_[var_515_10.prefab_name] ~= nil then
						local var_515_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_10.prefab_name].transform, "story_v_out_301011", "301011125", "story_v_out_301011.awb")

						arg_512_1:RecordAudio("301011125", var_515_15)
						arg_512_1:RecordAudio("301011125", var_515_15)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_301011", "301011125", "story_v_out_301011.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_301011", "301011125", "story_v_out_301011.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_16 = math.max(var_515_9, arg_512_1.talkMaxDuration)

			if var_515_8 <= arg_512_1.time_ and arg_512_1.time_ < var_515_8 + var_515_16 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_8) / var_515_16

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_8 + var_515_16 and arg_512_1.time_ < var_515_8 + var_515_16 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play301011126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 301011126
		arg_516_1.duration_ = 8.5

		local var_516_0 = {
			zh = 5.166,
			ja = 8.5
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play301011127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(arg_516_1.actors_["1019ui_story"]) and arg_516_1.var_.characterEffect1019ui_story == nil then
				arg_516_1.var_.characterEffect1019ui_story = arg_516_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_0 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 and not isNil(arg_516_1.actors_["1019ui_story"]) then
				if arg_516_1.var_.characterEffect1019ui_story and not isNil(arg_516_1.actors_["1019ui_story"]) then
					arg_516_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 and not isNil(arg_516_1.actors_["1019ui_story"]) and arg_516_1.var_.characterEffect1019ui_story then
				arg_516_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_519_2 = arg_516_1.actors_["1084ui_story"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.characterEffect1084ui_story == nil then
				arg_516_1.var_.characterEffect1084ui_story = var_519_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_3 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_3 and not isNil(var_519_2) then
				if arg_516_1.var_.characterEffect1084ui_story and not isNil(var_519_2) then
					arg_516_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_3)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_3 and arg_516_1.time_ < 0 + var_519_3 + arg_519_0 and not isNil(var_519_2) and arg_516_1.var_.characterEffect1084ui_story then
				arg_516_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_519_4 = 0
			local var_519_5 = 0.7

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_6 = arg_516_1:GetWordFromCfg(301011126)
				local var_519_7 = arg_516_1:FormatText(var_519_6.content)

				arg_516_1.text_.text = var_519_7

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_9 = 28 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 28)

				if (28 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 28)) > 0 and var_519_5 < var_519_9 then
					arg_516_1.talkMaxDuration = var_519_9

					if var_519_9 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_9 + var_519_4
					end
				end

				arg_516_1.text_.text = var_519_7
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011126", "story_v_out_301011.awb") ~= 0 then
					local var_519_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011126", "story_v_out_301011.awb") / 1000

					if var_519_10 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_10 + var_519_4
					end

					if var_519_6.prefab_name ~= "" and arg_516_1.actors_[var_519_6.prefab_name] ~= nil then
						local var_519_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_6.prefab_name].transform, "story_v_out_301011", "301011126", "story_v_out_301011.awb")

						arg_516_1:RecordAudio("301011126", var_519_11)
						arg_516_1:RecordAudio("301011126", var_519_11)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_301011", "301011126", "story_v_out_301011.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_301011", "301011126", "story_v_out_301011.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_12 = math.max(var_519_5, arg_516_1.talkMaxDuration)

			if var_519_4 <= arg_516_1.time_ and arg_516_1.time_ < var_519_4 + var_519_12 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_4) / var_519_12

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_4 + var_519_12 and arg_516_1.time_ < var_519_4 + var_519_12 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play301011127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 301011127
		arg_520_1.duration_ = 7.7

		local var_520_0 = {
			zh = 5.333,
			ja = 7.7
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play301011128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["1084ui_story"]) and arg_520_1.var_.characterEffect1084ui_story == nil then
				arg_520_1.var_.characterEffect1084ui_story = arg_520_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_0 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["1084ui_story"]) then
				if arg_520_1.var_.characterEffect1084ui_story and not isNil(arg_520_1.actors_["1084ui_story"]) then
					arg_520_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["1084ui_story"]) and arg_520_1.var_.characterEffect1084ui_story then
				arg_520_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_523_2 = arg_520_1.actors_["1019ui_story"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_2) and arg_520_1.var_.characterEffect1019ui_story == nil then
				arg_520_1.var_.characterEffect1019ui_story = var_523_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_3 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_3 and not isNil(var_523_2) then
				if arg_520_1.var_.characterEffect1019ui_story and not isNil(var_523_2) then
					arg_520_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_520_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_520_1.time_ - 0) / var_523_3)
				end
			end

			if arg_520_1.time_ >= 0 + var_523_3 and arg_520_1.time_ < 0 + var_523_3 + arg_523_0 and not isNil(var_523_2) and arg_520_1.var_.characterEffect1019ui_story then
				arg_520_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_520_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_523_4 = 0
			local var_523_5 = 0.55

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_6 = arg_520_1:GetWordFromCfg(301011127)
				local var_523_7 = arg_520_1:FormatText(var_523_6.content)

				arg_520_1.text_.text = var_523_7

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_9 = 23 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 23)

				if (23 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 23)) > 0 and var_523_5 < var_523_9 then
					arg_520_1.talkMaxDuration = var_523_9

					if var_523_9 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_9 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_7
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011127", "story_v_out_301011.awb") ~= 0 then
					local var_523_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011127", "story_v_out_301011.awb") / 1000

					if var_523_10 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_10 + var_523_4
					end

					if var_523_6.prefab_name ~= "" and arg_520_1.actors_[var_523_6.prefab_name] ~= nil then
						local var_523_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_6.prefab_name].transform, "story_v_out_301011", "301011127", "story_v_out_301011.awb")

						arg_520_1:RecordAudio("301011127", var_523_11)
						arg_520_1:RecordAudio("301011127", var_523_11)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_301011", "301011127", "story_v_out_301011.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_301011", "301011127", "story_v_out_301011.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_12 = math.max(var_523_5, arg_520_1.talkMaxDuration)

			if var_523_4 <= arg_520_1.time_ and arg_520_1.time_ < var_523_4 + var_523_12 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_4) / var_523_12

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_4 + var_523_12 and arg_520_1.time_ < var_523_4 + var_523_12 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play301011128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 301011128
		arg_524_1.duration_ = 8.4

		local var_524_0 = {
			zh = 5.666,
			ja = 8.4
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play301011129(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_527_0 = 0
			local var_527_1 = 0.7

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_2 = arg_524_1:GetWordFromCfg(301011128)
				local var_527_3 = arg_524_1:FormatText(var_527_2.content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 28 <= 0 and var_527_1 or var_527_1 * (utf8.len(var_527_3) / 28)

				if (28 <= 0 and var_527_1 or var_527_1 * (utf8.len(var_527_3) / 28)) > 0 and var_527_1 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_0
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011128", "story_v_out_301011.awb") ~= 0 then
					local var_527_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011128", "story_v_out_301011.awb") / 1000

					if var_527_6 + var_527_0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_6 + var_527_0
					end

					if var_527_2.prefab_name ~= "" and arg_524_1.actors_[var_527_2.prefab_name] ~= nil then
						local var_527_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_2.prefab_name].transform, "story_v_out_301011", "301011128", "story_v_out_301011.awb")

						arg_524_1:RecordAudio("301011128", var_527_7)
						arg_524_1:RecordAudio("301011128", var_527_7)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_301011", "301011128", "story_v_out_301011.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_301011", "301011128", "story_v_out_301011.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_8 = math.max(var_527_1, arg_524_1.talkMaxDuration)

			if var_527_0 <= arg_524_1.time_ and arg_524_1.time_ < var_527_0 + var_527_8 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_0) / var_527_8

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_0 + var_527_8 and arg_524_1.time_ < var_527_0 + var_527_8 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play301011129 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 301011129
		arg_528_1.duration_ = 11.47

		local var_528_0 = {
			zh = 7.633,
			ja = 11.466
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play301011130(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(arg_528_1.actors_["1019ui_story"]) and arg_528_1.var_.characterEffect1019ui_story == nil then
				arg_528_1.var_.characterEffect1019ui_story = arg_528_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_0 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 and not isNil(arg_528_1.actors_["1019ui_story"]) then
				if arg_528_1.var_.characterEffect1019ui_story and not isNil(arg_528_1.actors_["1019ui_story"]) then
					arg_528_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 and not isNil(arg_528_1.actors_["1019ui_story"]) and arg_528_1.var_.characterEffect1019ui_story then
				arg_528_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_531_2 = arg_528_1.actors_["1084ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_2) and arg_528_1.var_.characterEffect1084ui_story == nil then
				arg_528_1.var_.characterEffect1084ui_story = var_531_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_3 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_3 and not isNil(var_531_2) then
				if arg_528_1.var_.characterEffect1084ui_story and not isNil(var_531_2) then
					arg_528_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_528_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_528_1.time_ - 0) / var_531_3)
				end
			end

			if arg_528_1.time_ >= 0 + var_531_3 and arg_528_1.time_ < 0 + var_531_3 + arg_531_0 and not isNil(var_531_2) and arg_528_1.var_.characterEffect1084ui_story then
				arg_528_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_528_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_531_4 = 0
			local var_531_5 = 1.05

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_4 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_6 = arg_528_1:GetWordFromCfg(301011129)
				local var_531_7 = arg_528_1:FormatText(var_531_6.content)

				arg_528_1.text_.text = var_531_7

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_9 = 42 <= 0 and var_531_5 or var_531_5 * (utf8.len(var_531_7) / 42)

				if (42 <= 0 and var_531_5 or var_531_5 * (utf8.len(var_531_7) / 42)) > 0 and var_531_5 < var_531_9 then
					arg_528_1.talkMaxDuration = var_531_9

					if var_531_9 + var_531_4 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_9 + var_531_4
					end
				end

				arg_528_1.text_.text = var_531_7
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011129", "story_v_out_301011.awb") ~= 0 then
					local var_531_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011129", "story_v_out_301011.awb") / 1000

					if var_531_10 + var_531_4 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_10 + var_531_4
					end

					if var_531_6.prefab_name ~= "" and arg_528_1.actors_[var_531_6.prefab_name] ~= nil then
						local var_531_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_6.prefab_name].transform, "story_v_out_301011", "301011129", "story_v_out_301011.awb")

						arg_528_1:RecordAudio("301011129", var_531_11)
						arg_528_1:RecordAudio("301011129", var_531_11)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_301011", "301011129", "story_v_out_301011.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_301011", "301011129", "story_v_out_301011.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_12 = math.max(var_531_5, arg_528_1.talkMaxDuration)

			if var_531_4 <= arg_528_1.time_ and arg_528_1.time_ < var_531_4 + var_531_12 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_4) / var_531_12

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_4 + var_531_12 and arg_528_1.time_ < var_531_4 + var_531_12 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play301011130 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 301011130
		arg_532_1.duration_ = 3.73

		local var_532_0 = {
			zh = 3.733,
			ja = 2.233
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play301011131(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_535_0 = 0
			local var_535_1 = 0.175

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_2 = arg_532_1:GetWordFromCfg(301011130)
				local var_535_3 = arg_532_1:FormatText(var_535_2.content)

				arg_532_1.text_.text = var_535_3

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 7 <= 0 and var_535_1 or var_535_1 * (utf8.len(var_535_3) / 7)

				if (7 <= 0 and var_535_1 or var_535_1 * (utf8.len(var_535_3) / 7)) > 0 and var_535_1 < var_535_5 then
					arg_532_1.talkMaxDuration = var_535_5

					if var_535_5 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_3
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011130", "story_v_out_301011.awb") ~= 0 then
					local var_535_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011130", "story_v_out_301011.awb") / 1000

					if var_535_6 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_6 + var_535_0
					end

					if var_535_2.prefab_name ~= "" and arg_532_1.actors_[var_535_2.prefab_name] ~= nil then
						local var_535_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_2.prefab_name].transform, "story_v_out_301011", "301011130", "story_v_out_301011.awb")

						arg_532_1:RecordAudio("301011130", var_535_7)
						arg_532_1:RecordAudio("301011130", var_535_7)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_301011", "301011130", "story_v_out_301011.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_301011", "301011130", "story_v_out_301011.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_8 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_8 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_8

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_8 and arg_532_1.time_ < var_535_0 + var_535_8 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play301011131 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 301011131
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play301011132(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1084ui_story = arg_536_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_539_0 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 then
				arg_536_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_536_1.time_ - 0) / var_539_0)
				arg_536_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).z)
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles = arg_536_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 then
				arg_536_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_536_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_536_1.actors_["1084ui_story"].transform.position).z)
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_536_1.actors_["1084ui_story"].transform.localEulerAngles = arg_536_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_539_1 = arg_536_1.actors_["1019ui_story"].transform

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1019ui_story = var_539_1.localPosition
			end

			local var_539_2 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_2 then
				var_539_1.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_536_1.time_ - 0) / var_539_2)
				var_539_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_1.position).x, (manager.ui.mainCamera.transform.position - var_539_1.position).y, (manager.ui.mainCamera.transform.position - var_539_1.position).z)
				var_539_1.localEulerAngles.z = 0
				var_539_1.localEulerAngles.x = 0
				var_539_1.localEulerAngles = var_539_1.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_2 and arg_536_1.time_ < 0 + var_539_2 + arg_539_0 then
				var_539_1.localPosition = Vector3.New(0, 100, 0)
				var_539_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_1.position).x, (manager.ui.mainCamera.transform.position - var_539_1.position).y, (manager.ui.mainCamera.transform.position - var_539_1.position).z)
				var_539_1.localEulerAngles.z = 0
				var_539_1.localEulerAngles.x = 0
				var_539_1.localEulerAngles = var_539_1.localEulerAngles
			end

			local var_539_3 = arg_536_1.actors_["1019ui_story"]

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(var_539_3) and arg_536_1.var_.characterEffect1019ui_story == nil then
				arg_536_1.var_.characterEffect1019ui_story = var_539_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_4 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 and not isNil(var_539_3) then
				if arg_536_1.var_.characterEffect1019ui_story and not isNil(var_539_3) then
					arg_536_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_4)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 and not isNil(var_539_3) and arg_536_1.var_.characterEffect1019ui_story then
				arg_536_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_539_5 = 0
			local var_539_6 = 1.65

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_5 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_7 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(301011131).content)

				arg_536_1.text_.text = var_539_7

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_9 = 66 <= 0 and var_539_6 or var_539_6 * (utf8.len(var_539_7) / 66)

				if (66 <= 0 and var_539_6 or var_539_6 * (utf8.len(var_539_7) / 66)) > 0 and var_539_6 < var_539_9 then
					arg_536_1.talkMaxDuration = var_539_9

					if var_539_9 + var_539_5 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_9 + var_539_5
					end
				end

				arg_536_1.text_.text = var_539_7
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_6, arg_536_1.talkMaxDuration)

			if var_539_5 <= arg_536_1.time_ and arg_536_1.time_ < var_539_5 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_5) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_5 + var_539_10 and arg_536_1.time_ < var_539_5 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_536_1:InitPlayNodeList()
	end,
	Play301011132 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 301011132
		arg_540_1.duration_ = 2

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play301011133(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos1019ui_story = arg_540_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_543_0 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_0 then
				arg_540_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_540_1.time_ - 0) / var_543_0)
				arg_540_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).z)
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles = arg_540_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_540_1.time_ >= 0 + var_543_0 and arg_540_1.time_ < 0 + var_543_0 + arg_543_0 then
				arg_540_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_540_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["1019ui_story"].transform.position).z)
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["1019ui_story"].transform.localEulerAngles = arg_540_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_543_1 = arg_540_1.actors_["1019ui_story"]

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 and not isNil(var_543_1) and arg_540_1.var_.characterEffect1019ui_story == nil then
				arg_540_1.var_.characterEffect1019ui_story = var_543_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_2 = 0.200000002980232

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_2 and not isNil(var_543_1) then
				if arg_540_1.var_.characterEffect1019ui_story and not isNil(var_543_1) then
					arg_540_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_540_1.time_ >= 0 + var_543_2 and arg_540_1.time_ < 0 + var_543_2 + arg_543_0 and not isNil(var_543_1) and arg_540_1.var_.characterEffect1019ui_story then
				arg_540_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_543_4 = 0
			local var_543_5 = 0.1

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_4 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_6 = arg_540_1:GetWordFromCfg(301011132)
				local var_543_7 = arg_540_1:FormatText(var_543_6.content)

				arg_540_1.text_.text = var_543_7

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_9 = 4 <= 0 and var_543_5 or var_543_5 * (utf8.len(var_543_7) / 4)

				if (4 <= 0 and var_543_5 or var_543_5 * (utf8.len(var_543_7) / 4)) > 0 and var_543_5 < var_543_9 then
					arg_540_1.talkMaxDuration = var_543_9

					if var_543_9 + var_543_4 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_9 + var_543_4
					end
				end

				arg_540_1.text_.text = var_543_7
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011132", "story_v_out_301011.awb") ~= 0 then
					local var_543_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011132", "story_v_out_301011.awb") / 1000

					if var_543_10 + var_543_4 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_10 + var_543_4
					end

					if var_543_6.prefab_name ~= "" and arg_540_1.actors_[var_543_6.prefab_name] ~= nil then
						local var_543_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_6.prefab_name].transform, "story_v_out_301011", "301011132", "story_v_out_301011.awb")

						arg_540_1:RecordAudio("301011132", var_543_11)
						arg_540_1:RecordAudio("301011132", var_543_11)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_301011", "301011132", "story_v_out_301011.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_301011", "301011132", "story_v_out_301011.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_12 = math.max(var_543_5, arg_540_1.talkMaxDuration)

			if var_543_4 <= arg_540_1.time_ and arg_540_1.time_ < var_543_4 + var_543_12 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_4) / var_543_12

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_4 + var_543_12 and arg_540_1.time_ < var_543_4 + var_543_12 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play301011133 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 301011133
		arg_544_1.duration_ = 11.47

		local var_544_0 = {
			zh = 9.5,
			ja = 11.466
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play301011134(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos10066ui_story = arg_544_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_547_0 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 then
				arg_544_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_544_1.time_ - 0) / var_547_0)
				arg_544_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).z)
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles = arg_544_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 then
				arg_544_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_544_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["10066ui_story"].transform.position).z)
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["10066ui_story"].transform.localEulerAngles = arg_544_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_547_1 = arg_544_1.actors_["1019ui_story"].transform

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos1019ui_story = var_547_1.localPosition
			end

			local var_547_2 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_2 then
				var_547_1.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_544_1.time_ - 0) / var_547_2)
				var_547_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_1.position).x, (manager.ui.mainCamera.transform.position - var_547_1.position).y, (manager.ui.mainCamera.transform.position - var_547_1.position).z)
				var_547_1.localEulerAngles.z = 0
				var_547_1.localEulerAngles.x = 0
				var_547_1.localEulerAngles = var_547_1.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_2 and arg_544_1.time_ < 0 + var_547_2 + arg_547_0 then
				var_547_1.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_547_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_547_1.position).x, (manager.ui.mainCamera.transform.position - var_547_1.position).y, (manager.ui.mainCamera.transform.position - var_547_1.position).z)
				var_547_1.localEulerAngles.z = 0
				var_547_1.localEulerAngles.x = 0
				var_547_1.localEulerAngles = var_547_1.localEulerAngles
			end

			local var_547_3 = arg_544_1.actors_["10066ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_3) and arg_544_1.var_.characterEffect10066ui_story == nil then
				arg_544_1.var_.characterEffect10066ui_story = var_547_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_4 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_4 and not isNil(var_547_3) then
				if arg_544_1.var_.characterEffect10066ui_story and not isNil(var_547_3) then
					arg_544_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_4 and arg_544_1.time_ < 0 + var_547_4 + arg_547_0 and not isNil(var_547_3) and arg_544_1.var_.characterEffect10066ui_story then
				arg_544_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_547_6 = arg_544_1.actors_["1019ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_6) and arg_544_1.var_.characterEffect1019ui_story == nil then
				arg_544_1.var_.characterEffect1019ui_story = var_547_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_7 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 and not isNil(var_547_6) then
				if arg_544_1.var_.characterEffect1019ui_story and not isNil(var_547_6) then
					arg_544_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_544_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_544_1.time_ - 0) / var_547_7)
				end
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 and not isNil(var_547_6) and arg_544_1.var_.characterEffect1019ui_story then
				arg_544_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_544_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_547_8 = 0
			local var_547_9 = 1.1

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_8 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_10 = arg_544_1:GetWordFromCfg(301011133)
				local var_547_11 = arg_544_1:FormatText(var_547_10.content)

				arg_544_1.text_.text = var_547_11

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_13 = 44 <= 0 and var_547_9 or var_547_9 * (utf8.len(var_547_11) / 44)

				if (44 <= 0 and var_547_9 or var_547_9 * (utf8.len(var_547_11) / 44)) > 0 and var_547_9 < var_547_13 then
					arg_544_1.talkMaxDuration = var_547_13

					if var_547_13 + var_547_8 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_13 + var_547_8
					end
				end

				arg_544_1.text_.text = var_547_11
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011133", "story_v_out_301011.awb") ~= 0 then
					local var_547_14 = manager.audio:GetVoiceLength("story_v_out_301011", "301011133", "story_v_out_301011.awb") / 1000

					if var_547_14 + var_547_8 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_14 + var_547_8
					end

					if var_547_10.prefab_name ~= "" and arg_544_1.actors_[var_547_10.prefab_name] ~= nil then
						local var_547_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_10.prefab_name].transform, "story_v_out_301011", "301011133", "story_v_out_301011.awb")

						arg_544_1:RecordAudio("301011133", var_547_15)
						arg_544_1:RecordAudio("301011133", var_547_15)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_301011", "301011133", "story_v_out_301011.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_301011", "301011133", "story_v_out_301011.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_16 = math.max(var_547_9, arg_544_1.talkMaxDuration)

			if var_547_8 <= arg_544_1.time_ and arg_544_1.time_ < var_547_8 + var_547_16 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_8) / var_547_16

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_8 + var_547_16 and arg_544_1.time_ < var_547_8 + var_547_16 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play301011134 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 301011134
		arg_548_1.duration_ = 6.63

		local var_548_0 = {
			zh = 5.266,
			ja = 6.633
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play301011135(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["1019ui_story"]) and arg_548_1.var_.characterEffect1019ui_story == nil then
				arg_548_1.var_.characterEffect1019ui_story = arg_548_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_0 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["1019ui_story"]) then
				if arg_548_1.var_.characterEffect1019ui_story and not isNil(arg_548_1.actors_["1019ui_story"]) then
					arg_548_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["1019ui_story"]) and arg_548_1.var_.characterEffect1019ui_story then
				arg_548_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_551_2 = arg_548_1.actors_["10066ui_story"]

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(var_551_2) and arg_548_1.var_.characterEffect10066ui_story == nil then
				arg_548_1.var_.characterEffect10066ui_story = var_551_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_3 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_3 and not isNil(var_551_2) then
				if arg_548_1.var_.characterEffect10066ui_story and not isNil(var_551_2) then
					arg_548_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_548_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_548_1.time_ - 0) / var_551_3)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_3 and arg_548_1.time_ < 0 + var_551_3 + arg_551_0 and not isNil(var_551_2) and arg_548_1.var_.characterEffect10066ui_story then
				arg_548_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_548_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_551_4 = 0
			local var_551_5 = 0.65

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_4 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_6 = arg_548_1:GetWordFromCfg(301011134)
				local var_551_7 = arg_548_1:FormatText(var_551_6.content)

				arg_548_1.text_.text = var_551_7

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_9 = 26 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 26)

				if (26 <= 0 and var_551_5 or var_551_5 * (utf8.len(var_551_7) / 26)) > 0 and var_551_5 < var_551_9 then
					arg_548_1.talkMaxDuration = var_551_9

					if var_551_9 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_9 + var_551_4
					end
				end

				arg_548_1.text_.text = var_551_7
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011134", "story_v_out_301011.awb") ~= 0 then
					local var_551_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011134", "story_v_out_301011.awb") / 1000

					if var_551_10 + var_551_4 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_10 + var_551_4
					end

					if var_551_6.prefab_name ~= "" and arg_548_1.actors_[var_551_6.prefab_name] ~= nil then
						local var_551_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_6.prefab_name].transform, "story_v_out_301011", "301011134", "story_v_out_301011.awb")

						arg_548_1:RecordAudio("301011134", var_551_11)
						arg_548_1:RecordAudio("301011134", var_551_11)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_301011", "301011134", "story_v_out_301011.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_301011", "301011134", "story_v_out_301011.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_12 = math.max(var_551_5, arg_548_1.talkMaxDuration)

			if var_551_4 <= arg_548_1.time_ and arg_548_1.time_ < var_551_4 + var_551_12 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_4) / var_551_12

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_4 + var_551_12 and arg_548_1.time_ < var_551_4 + var_551_12 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play301011135 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 301011135
		arg_552_1.duration_ = 7.77

		local var_552_0 = {
			zh = 5.866,
			ja = 7.766
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play301011136(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(arg_552_1.actors_["10066ui_story"]) and arg_552_1.var_.characterEffect10066ui_story == nil then
				arg_552_1.var_.characterEffect10066ui_story = arg_552_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_0 = 0.200000002980232

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_0 and not isNil(arg_552_1.actors_["10066ui_story"]) then
				if arg_552_1.var_.characterEffect10066ui_story and not isNil(arg_552_1.actors_["10066ui_story"]) then
					arg_552_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= 0 + var_555_0 and arg_552_1.time_ < 0 + var_555_0 + arg_555_0 and not isNil(arg_552_1.actors_["10066ui_story"]) and arg_552_1.var_.characterEffect10066ui_story then
				arg_552_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_555_2 = arg_552_1.actors_["1019ui_story"]

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(var_555_2) and arg_552_1.var_.characterEffect1019ui_story == nil then
				arg_552_1.var_.characterEffect1019ui_story = var_555_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_3 = 0.200000002980232

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_3 and not isNil(var_555_2) then
				if arg_552_1.var_.characterEffect1019ui_story and not isNil(var_555_2) then
					arg_552_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_552_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_552_1.time_ - 0) / var_555_3)
				end
			end

			if arg_552_1.time_ >= 0 + var_555_3 and arg_552_1.time_ < 0 + var_555_3 + arg_555_0 and not isNil(var_555_2) and arg_552_1.var_.characterEffect1019ui_story then
				arg_552_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_552_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action436")
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_555_4 = 0
			local var_555_5 = 0.675

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_4 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_6 = arg_552_1:GetWordFromCfg(301011135)
				local var_555_7 = arg_552_1:FormatText(var_555_6.content)

				arg_552_1.text_.text = var_555_7

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_9 = 27 <= 0 and var_555_5 or var_555_5 * (utf8.len(var_555_7) / 27)

				if (27 <= 0 and var_555_5 or var_555_5 * (utf8.len(var_555_7) / 27)) > 0 and var_555_5 < var_555_9 then
					arg_552_1.talkMaxDuration = var_555_9

					if var_555_9 + var_555_4 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_9 + var_555_4
					end
				end

				arg_552_1.text_.text = var_555_7
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011135", "story_v_out_301011.awb") ~= 0 then
					local var_555_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011135", "story_v_out_301011.awb") / 1000

					if var_555_10 + var_555_4 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_10 + var_555_4
					end

					if var_555_6.prefab_name ~= "" and arg_552_1.actors_[var_555_6.prefab_name] ~= nil then
						local var_555_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_6.prefab_name].transform, "story_v_out_301011", "301011135", "story_v_out_301011.awb")

						arg_552_1:RecordAudio("301011135", var_555_11)
						arg_552_1:RecordAudio("301011135", var_555_11)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_301011", "301011135", "story_v_out_301011.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_301011", "301011135", "story_v_out_301011.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_12 = math.max(var_555_5, arg_552_1.talkMaxDuration)

			if var_555_4 <= arg_552_1.time_ and arg_552_1.time_ < var_555_4 + var_555_12 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_4) / var_555_12

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_4 + var_555_12 and arg_552_1.time_ < var_555_4 + var_555_12 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play301011136 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 301011136
		arg_556_1.duration_ = 10.43

		local var_556_0 = {
			zh = 5.8,
			ja = 10.433
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play301011137(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(arg_556_1.actors_["1019ui_story"]) and arg_556_1.var_.characterEffect1019ui_story == nil then
				arg_556_1.var_.characterEffect1019ui_story = arg_556_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_0 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_0 and not isNil(arg_556_1.actors_["1019ui_story"]) then
				if arg_556_1.var_.characterEffect1019ui_story and not isNil(arg_556_1.actors_["1019ui_story"]) then
					arg_556_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_556_1.time_ >= 0 + var_559_0 and arg_556_1.time_ < 0 + var_559_0 + arg_559_0 and not isNil(arg_556_1.actors_["1019ui_story"]) and arg_556_1.var_.characterEffect1019ui_story then
				arg_556_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_559_2 = arg_556_1.actors_["10066ui_story"]

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.characterEffect10066ui_story == nil then
				arg_556_1.var_.characterEffect10066ui_story = var_559_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_559_3 = 0.200000002980232

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_3 and not isNil(var_559_2) then
				if arg_556_1.var_.characterEffect10066ui_story and not isNil(var_559_2) then
					arg_556_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_556_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_556_1.time_ - 0) / var_559_3)
				end
			end

			if arg_556_1.time_ >= 0 + var_559_3 and arg_556_1.time_ < 0 + var_559_3 + arg_559_0 and not isNil(var_559_2) and arg_556_1.var_.characterEffect10066ui_story then
				arg_556_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_556_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_559_4 = 0
			local var_559_5 = 0.625

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_4 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_6 = arg_556_1:GetWordFromCfg(301011136)
				local var_559_7 = arg_556_1:FormatText(var_559_6.content)

				arg_556_1.text_.text = var_559_7

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_9 = 25 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 25)

				if (25 <= 0 and var_559_5 or var_559_5 * (utf8.len(var_559_7) / 25)) > 0 and var_559_5 < var_559_9 then
					arg_556_1.talkMaxDuration = var_559_9

					if var_559_9 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_9 + var_559_4
					end
				end

				arg_556_1.text_.text = var_559_7
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011136", "story_v_out_301011.awb") ~= 0 then
					local var_559_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011136", "story_v_out_301011.awb") / 1000

					if var_559_10 + var_559_4 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_10 + var_559_4
					end

					if var_559_6.prefab_name ~= "" and arg_556_1.actors_[var_559_6.prefab_name] ~= nil then
						local var_559_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_6.prefab_name].transform, "story_v_out_301011", "301011136", "story_v_out_301011.awb")

						arg_556_1:RecordAudio("301011136", var_559_11)
						arg_556_1:RecordAudio("301011136", var_559_11)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_301011", "301011136", "story_v_out_301011.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_301011", "301011136", "story_v_out_301011.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_12 = math.max(var_559_5, arg_556_1.talkMaxDuration)

			if var_559_4 <= arg_556_1.time_ and arg_556_1.time_ < var_559_4 + var_559_12 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_4) / var_559_12

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_4 + var_559_12 and arg_556_1.time_ < var_559_4 + var_559_12 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play301011137 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 301011137
		arg_560_1.duration_ = 7.07

		local var_560_0 = {
			zh = 5.333,
			ja = 7.066
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play301011138(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_563_0 = 0
			local var_563_1 = 0.725

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, false)
				arg_560_1.callingController_:SetSelectedState("normal")

				local var_563_2 = arg_560_1:GetWordFromCfg(301011137)
				local var_563_3 = arg_560_1:FormatText(var_563_2.content)

				arg_560_1.text_.text = var_563_3

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 29 <= 0 and var_563_1 or var_563_1 * (utf8.len(var_563_3) / 29)

				if (29 <= 0 and var_563_1 or var_563_1 * (utf8.len(var_563_3) / 29)) > 0 and var_563_1 < var_563_5 then
					arg_560_1.talkMaxDuration = var_563_5

					if var_563_5 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + var_563_0
					end
				end

				arg_560_1.text_.text = var_563_3
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011137", "story_v_out_301011.awb") ~= 0 then
					local var_563_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011137", "story_v_out_301011.awb") / 1000

					if var_563_6 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_6 + var_563_0
					end

					if var_563_2.prefab_name ~= "" and arg_560_1.actors_[var_563_2.prefab_name] ~= nil then
						local var_563_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_2.prefab_name].transform, "story_v_out_301011", "301011137", "story_v_out_301011.awb")

						arg_560_1:RecordAudio("301011137", var_563_7)
						arg_560_1:RecordAudio("301011137", var_563_7)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_301011", "301011137", "story_v_out_301011.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_301011", "301011137", "story_v_out_301011.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_8 = math.max(var_563_1, arg_560_1.talkMaxDuration)

			if var_563_0 <= arg_560_1.time_ and arg_560_1.time_ < var_563_0 + var_563_8 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_0) / var_563_8

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_0 + var_563_8 and arg_560_1.time_ < var_563_0 + var_563_8 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play301011138 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 301011138
		arg_564_1.duration_ = 5

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play301011139(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos10066ui_story = arg_564_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_567_0 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_0 then
				arg_564_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_564_1.time_ - 0) / var_567_0)
				arg_564_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).z)
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles = arg_564_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_564_1.time_ >= 0 + var_567_0 and arg_564_1.time_ < 0 + var_567_0 + arg_567_0 then
				arg_564_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_564_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_564_1.actors_["10066ui_story"].transform.position).z)
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_564_1.actors_["10066ui_story"].transform.localEulerAngles = arg_564_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_567_1 = arg_564_1.actors_["1019ui_story"].transform

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.var_.moveOldPos1019ui_story = var_567_1.localPosition
			end

			local var_567_2 = 0.001

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_2 then
				var_567_1.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_564_1.time_ - 0) / var_567_2)
				var_567_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_567_1.position).x, (manager.ui.mainCamera.transform.position - var_567_1.position).y, (manager.ui.mainCamera.transform.position - var_567_1.position).z)
				var_567_1.localEulerAngles.z = 0
				var_567_1.localEulerAngles.x = 0
				var_567_1.localEulerAngles = var_567_1.localEulerAngles
			end

			if arg_564_1.time_ >= 0 + var_567_2 and arg_564_1.time_ < 0 + var_567_2 + arg_567_0 then
				var_567_1.localPosition = Vector3.New(0, 100, 0)
				var_567_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_567_1.position).x, (manager.ui.mainCamera.transform.position - var_567_1.position).y, (manager.ui.mainCamera.transform.position - var_567_1.position).z)
				var_567_1.localEulerAngles.z = 0
				var_567_1.localEulerAngles.x = 0
				var_567_1.localEulerAngles = var_567_1.localEulerAngles
			end

			local var_567_3 = arg_564_1.actors_["1019ui_story"]

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 and not isNil(var_567_3) and arg_564_1.var_.characterEffect1019ui_story == nil then
				arg_564_1.var_.characterEffect1019ui_story = var_567_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_567_4 = 0.200000002980232

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_4 and not isNil(var_567_3) then
				if arg_564_1.var_.characterEffect1019ui_story and not isNil(var_567_3) then
					arg_564_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_564_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_564_1.time_ - 0) / var_567_4)
				end
			end

			if arg_564_1.time_ >= 0 + var_567_4 and arg_564_1.time_ < 0 + var_567_4 + arg_567_0 and not isNil(var_567_3) and arg_564_1.var_.characterEffect1019ui_story then
				arg_564_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_564_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_567_5 = 0
			local var_567_6 = 0.925

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_5 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_7 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(301011138).content)

				arg_564_1.text_.text = var_567_7

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_9 = 37 <= 0 and var_567_6 or var_567_6 * (utf8.len(var_567_7) / 37)

				if (37 <= 0 and var_567_6 or var_567_6 * (utf8.len(var_567_7) / 37)) > 0 and var_567_6 < var_567_9 then
					arg_564_1.talkMaxDuration = var_567_9

					if var_567_9 + var_567_5 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_9 + var_567_5
					end
				end

				arg_564_1.text_.text = var_567_7
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_10 = math.max(var_567_6, arg_564_1.talkMaxDuration)

			if var_567_5 <= arg_564_1.time_ and arg_564_1.time_ < var_567_5 + var_567_10 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_5) / var_567_10

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_5 + var_567_10 and arg_564_1.time_ < var_567_5 + var_567_10 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_564_1:InitPlayNodeList()
	end,
	Play301011139 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 301011139
		arg_568_1.duration_ = 3.7

		local var_568_0 = {
			zh = 3.066,
			ja = 3.7
		}
		local var_568_1 = manager.audio:GetLocalizationFlag()

		if var_568_0[var_568_1] ~= nil then
			arg_568_1.duration_ = var_568_0[var_568_1]
		end

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play301011140(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.var_.moveOldPos1084ui_story = arg_568_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_571_0 = 0.001

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_0 then
				arg_568_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_568_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_568_1.time_ - 0) / var_571_0)
				arg_568_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).z)
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles = arg_568_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_568_1.time_ >= 0 + var_571_0 and arg_568_1.time_ < 0 + var_571_0 + arg_571_0 then
				arg_568_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_568_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_568_1.actors_["1084ui_story"].transform.position).z)
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_568_1.actors_["1084ui_story"].transform.localEulerAngles = arg_568_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_571_1 = arg_568_1.actors_["1084ui_story"]

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 and not isNil(var_571_1) and arg_568_1.var_.characterEffect1084ui_story == nil then
				arg_568_1.var_.characterEffect1084ui_story = var_571_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_571_2 = 0.200000002980232

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_2 and not isNil(var_571_1) then
				if arg_568_1.var_.characterEffect1084ui_story and not isNil(var_571_1) then
					arg_568_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_568_1.time_ >= 0 + var_571_2 and arg_568_1.time_ < 0 + var_571_2 + arg_571_0 and not isNil(var_571_1) and arg_568_1.var_.characterEffect1084ui_story then
				arg_568_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_571_4 = 0
			local var_571_5 = 0.4

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= var_571_4 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, true)

				arg_568_1.leftNameTxt_.text = arg_568_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_568_1.leftNameTxt_.transform)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1.leftNameTxt_.text)
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_6 = arg_568_1:GetWordFromCfg(301011139)
				local var_571_7 = arg_568_1:FormatText(var_571_6.content)

				arg_568_1.text_.text = var_571_7

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_9 = 16 <= 0 and var_571_5 or var_571_5 * (utf8.len(var_571_7) / 16)

				if (16 <= 0 and var_571_5 or var_571_5 * (utf8.len(var_571_7) / 16)) > 0 and var_571_5 < var_571_9 then
					arg_568_1.talkMaxDuration = var_571_9

					if var_571_9 + var_571_4 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_9 + var_571_4
					end
				end

				arg_568_1.text_.text = var_571_7
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011139", "story_v_out_301011.awb") ~= 0 then
					local var_571_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011139", "story_v_out_301011.awb") / 1000

					if var_571_10 + var_571_4 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_10 + var_571_4
					end

					if var_571_6.prefab_name ~= "" and arg_568_1.actors_[var_571_6.prefab_name] ~= nil then
						local var_571_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_568_1.actors_[var_571_6.prefab_name].transform, "story_v_out_301011", "301011139", "story_v_out_301011.awb")

						arg_568_1:RecordAudio("301011139", var_571_11)
						arg_568_1:RecordAudio("301011139", var_571_11)
					else
						arg_568_1:AudioAction("play", "voice", "story_v_out_301011", "301011139", "story_v_out_301011.awb")
					end

					arg_568_1:RecordHistoryTalkVoice("story_v_out_301011", "301011139", "story_v_out_301011.awb")
				end

				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_12 = math.max(var_571_5, arg_568_1.talkMaxDuration)

			if var_571_4 <= arg_568_1.time_ and arg_568_1.time_ < var_571_4 + var_571_12 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - var_571_4) / var_571_12

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= var_571_4 + var_571_12 and arg_568_1.time_ < var_571_4 + var_571_12 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_568_1:InitPlayNodeList()
	end,
	Play301011140 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 301011140
		arg_572_1.duration_ = 7.57

		local var_572_0 = {
			zh = 5.666,
			ja = 7.566
		}
		local var_572_1 = manager.audio:GetLocalizationFlag()

		if var_572_0[var_572_1] ~= nil then
			arg_572_1.duration_ = var_572_0[var_572_1]
		end

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play301011141(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.var_.moveOldPos10066ui_story = arg_572_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_575_0 = 0.001

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_0 then
				arg_572_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_572_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_572_1.time_ - 0) / var_575_0)
				arg_572_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).z)
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles = arg_572_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_572_1.time_ >= 0 + var_575_0 and arg_572_1.time_ < 0 + var_575_0 + arg_575_0 then
				arg_572_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_572_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_572_1.actors_["10066ui_story"].transform.position).z)
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_572_1.actors_["10066ui_story"].transform.localEulerAngles = arg_572_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_575_1 = arg_572_1.actors_["10066ui_story"]

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect10066ui_story == nil then
				arg_572_1.var_.characterEffect10066ui_story = var_575_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_2 = 0.200000002980232

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_2 and not isNil(var_575_1) then
				if arg_572_1.var_.characterEffect10066ui_story and not isNil(var_575_1) then
					arg_572_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_572_1.time_ >= 0 + var_575_2 and arg_572_1.time_ < 0 + var_575_2 + arg_575_0 and not isNil(var_575_1) and arg_572_1.var_.characterEffect10066ui_story then
				arg_572_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_575_4 = arg_572_1.actors_["1084ui_story"]

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 and not isNil(var_575_4) and arg_572_1.var_.characterEffect1084ui_story == nil then
				arg_572_1.var_.characterEffect1084ui_story = var_575_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_575_5 = 0.200000002980232

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_5 and not isNil(var_575_4) then
				if arg_572_1.var_.characterEffect1084ui_story and not isNil(var_575_4) then
					arg_572_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_572_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_572_1.time_ - 0) / var_575_5)
				end
			end

			if arg_572_1.time_ >= 0 + var_575_5 and arg_572_1.time_ < 0 + var_575_5 + arg_575_0 and not isNil(var_575_4) and arg_572_1.var_.characterEffect1084ui_story then
				arg_572_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_572_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_575_6 = 0
			local var_575_7 = 0.45

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_6 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_8 = arg_572_1:GetWordFromCfg(301011140)
				local var_575_9 = arg_572_1:FormatText(var_575_8.content)

				arg_572_1.text_.text = var_575_9

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_11 = 18 <= 0 and var_575_7 or var_575_7 * (utf8.len(var_575_9) / 18)

				if (18 <= 0 and var_575_7 or var_575_7 * (utf8.len(var_575_9) / 18)) > 0 and var_575_7 < var_575_11 then
					arg_572_1.talkMaxDuration = var_575_11

					if var_575_11 + var_575_6 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_11 + var_575_6
					end
				end

				arg_572_1.text_.text = var_575_9
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011140", "story_v_out_301011.awb") ~= 0 then
					local var_575_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011140", "story_v_out_301011.awb") / 1000

					if var_575_12 + var_575_6 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_12 + var_575_6
					end

					if var_575_8.prefab_name ~= "" and arg_572_1.actors_[var_575_8.prefab_name] ~= nil then
						local var_575_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_572_1.actors_[var_575_8.prefab_name].transform, "story_v_out_301011", "301011140", "story_v_out_301011.awb")

						arg_572_1:RecordAudio("301011140", var_575_13)
						arg_572_1:RecordAudio("301011140", var_575_13)
					else
						arg_572_1:AudioAction("play", "voice", "story_v_out_301011", "301011140", "story_v_out_301011.awb")
					end

					arg_572_1:RecordHistoryTalkVoice("story_v_out_301011", "301011140", "story_v_out_301011.awb")
				end

				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_14 = math.max(var_575_7, arg_572_1.talkMaxDuration)

			if var_575_6 <= arg_572_1.time_ and arg_572_1.time_ < var_575_6 + var_575_14 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_6) / var_575_14

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_6 + var_575_14 and arg_572_1.time_ < var_575_6 + var_575_14 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_572_1:InitPlayNodeList()
	end,
	Play301011141 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 301011141
		arg_576_1.duration_ = 5.7

		local var_576_0 = {
			zh = 3.266,
			ja = 5.7
		}
		local var_576_1 = manager.audio:GetLocalizationFlag()

		if var_576_0[var_576_1] ~= nil then
			arg_576_1.duration_ = var_576_0[var_576_1]
		end

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play301011142(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= 0 + arg_579_0 then
				arg_576_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_579_0 = 0
			local var_579_1 = 0.4

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_0 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0
				arg_576_1.dialogCg_.alpha = 1

				arg_576_1.dialog_:SetActive(true)
				SetActive(arg_576_1.leftNameGo_, true)

				arg_576_1.leftNameTxt_.text = arg_576_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_576_1.leftNameTxt_.transform)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1.leftNameTxt_.text)
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_2 = arg_576_1:GetWordFromCfg(301011141)
				local var_579_3 = arg_576_1:FormatText(var_579_2.content)

				arg_576_1.text_.text = var_579_3

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_5 = 16 <= 0 and var_579_1 or var_579_1 * (utf8.len(var_579_3) / 16)

				if (16 <= 0 and var_579_1 or var_579_1 * (utf8.len(var_579_3) / 16)) > 0 and var_579_1 < var_579_5 then
					arg_576_1.talkMaxDuration = var_579_5

					if var_579_5 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_5 + var_579_0
					end
				end

				arg_576_1.text_.text = var_579_3
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011141", "story_v_out_301011.awb") ~= 0 then
					local var_579_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011141", "story_v_out_301011.awb") / 1000

					if var_579_6 + var_579_0 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_6 + var_579_0
					end

					if var_579_2.prefab_name ~= "" and arg_576_1.actors_[var_579_2.prefab_name] ~= nil then
						local var_579_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_576_1.actors_[var_579_2.prefab_name].transform, "story_v_out_301011", "301011141", "story_v_out_301011.awb")

						arg_576_1:RecordAudio("301011141", var_579_7)
						arg_576_1:RecordAudio("301011141", var_579_7)
					else
						arg_576_1:AudioAction("play", "voice", "story_v_out_301011", "301011141", "story_v_out_301011.awb")
					end

					arg_576_1:RecordHistoryTalkVoice("story_v_out_301011", "301011141", "story_v_out_301011.awb")
				end

				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_8 = math.max(var_579_1, arg_576_1.talkMaxDuration)

			if var_579_0 <= arg_576_1.time_ and arg_576_1.time_ < var_579_0 + var_579_8 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_0) / var_579_8

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_0 + var_579_8 and arg_576_1.time_ < var_579_0 + var_579_8 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play301011142 = function(arg_580_0, arg_580_1)
		arg_580_1.time_ = 0
		arg_580_1.frameCnt_ = 0
		arg_580_1.state_ = "playing"
		arg_580_1.curTalkId_ = 301011142
		arg_580_1.duration_ = 3.4

		local var_580_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_580_1 = manager.audio:GetLocalizationFlag()

		if var_580_0[var_580_1] ~= nil then
			arg_580_1.duration_ = var_580_0[var_580_1]
		end

		SetActive(arg_580_1.tipsGo_, false)

		function arg_580_1.onSingleLineFinish_()
			arg_580_1.onSingleLineUpdate_ = nil
			arg_580_1.onSingleLineFinish_ = nil
			arg_580_1.state_ = "waiting"
		end

		function arg_580_1.playNext_(arg_582_0)
			if arg_582_0 == 1 then
				arg_580_0:Play301011143(arg_580_1)
			end
		end

		function arg_580_1.onSingleLineUpdate_(arg_583_0)
			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(arg_580_1.actors_["1084ui_story"]) and arg_580_1.var_.characterEffect1084ui_story == nil then
				arg_580_1.var_.characterEffect1084ui_story = arg_580_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_0 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_0 and not isNil(arg_580_1.actors_["1084ui_story"]) then
				if arg_580_1.var_.characterEffect1084ui_story and not isNil(arg_580_1.actors_["1084ui_story"]) then
					arg_580_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_580_1.time_ >= 0 + var_583_0 and arg_580_1.time_ < 0 + var_583_0 + arg_583_0 and not isNil(arg_580_1.actors_["1084ui_story"]) and arg_580_1.var_.characterEffect1084ui_story then
				arg_580_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_583_2 = arg_580_1.actors_["10066ui_story"]

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 and not isNil(var_583_2) and arg_580_1.var_.characterEffect10066ui_story == nil then
				arg_580_1.var_.characterEffect10066ui_story = var_583_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_583_3 = 0.200000002980232

			if 0 <= arg_580_1.time_ and arg_580_1.time_ < 0 + var_583_3 and not isNil(var_583_2) then
				if arg_580_1.var_.characterEffect10066ui_story and not isNil(var_583_2) then
					arg_580_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_580_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_580_1.time_ - 0) / var_583_3)
				end
			end

			if arg_580_1.time_ >= 0 + var_583_3 and arg_580_1.time_ < 0 + var_583_3 + arg_583_0 and not isNil(var_583_2) and arg_580_1.var_.characterEffect10066ui_story then
				arg_580_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_580_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= 0 + arg_583_0 then
				arg_580_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_583_4 = 0
			local var_583_5 = 0.225

			if 0 < arg_580_1.time_ and arg_580_1.time_ <= var_583_4 + arg_583_0 then
				arg_580_1.talkMaxDuration = 0
				arg_580_1.dialogCg_.alpha = 1

				arg_580_1.dialog_:SetActive(true)
				SetActive(arg_580_1.leftNameGo_, true)

				arg_580_1.leftNameTxt_.text = arg_580_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_580_1.leftNameTxt_.transform)

				arg_580_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_580_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_580_1:RecordName(arg_580_1.leftNameTxt_.text)
				SetActive(arg_580_1.iconTrs_.gameObject, false)
				arg_580_1.callingController_:SetSelectedState("normal")

				local var_583_6 = arg_580_1:GetWordFromCfg(301011142)
				local var_583_7 = arg_580_1:FormatText(var_583_6.content)

				arg_580_1.text_.text = var_583_7

				LuaForUtil.ClearLinePrefixSymbol(arg_580_1.text_)

				local var_583_9 = 9 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 9)

				if (9 <= 0 and var_583_5 or var_583_5 * (utf8.len(var_583_7) / 9)) > 0 and var_583_5 < var_583_9 then
					arg_580_1.talkMaxDuration = var_583_9

					if var_583_9 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_9 + var_583_4
					end
				end

				arg_580_1.text_.text = var_583_7
				arg_580_1.typewritter.percent = 0

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011142", "story_v_out_301011.awb") ~= 0 then
					local var_583_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011142", "story_v_out_301011.awb") / 1000

					if var_583_10 + var_583_4 > arg_580_1.duration_ then
						arg_580_1.duration_ = var_583_10 + var_583_4
					end

					if var_583_6.prefab_name ~= "" and arg_580_1.actors_[var_583_6.prefab_name] ~= nil then
						local var_583_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_580_1.actors_[var_583_6.prefab_name].transform, "story_v_out_301011", "301011142", "story_v_out_301011.awb")

						arg_580_1:RecordAudio("301011142", var_583_11)
						arg_580_1:RecordAudio("301011142", var_583_11)
					else
						arg_580_1:AudioAction("play", "voice", "story_v_out_301011", "301011142", "story_v_out_301011.awb")
					end

					arg_580_1:RecordHistoryTalkVoice("story_v_out_301011", "301011142", "story_v_out_301011.awb")
				end

				arg_580_1:RecordContent(arg_580_1.text_.text)
			end

			local var_583_12 = math.max(var_583_5, arg_580_1.talkMaxDuration)

			if var_583_4 <= arg_580_1.time_ and arg_580_1.time_ < var_583_4 + var_583_12 then
				arg_580_1.typewritter.percent = (arg_580_1.time_ - var_583_4) / var_583_12

				arg_580_1.typewritter:SetDirty()
			end

			if arg_580_1.time_ >= var_583_4 + var_583_12 and arg_580_1.time_ < var_583_4 + var_583_12 + arg_583_0 then
				arg_580_1.typewritter.percent = 1

				arg_580_1.typewritter:SetDirty()
				arg_580_1:ShowNextGo(true)
			end
		end

		arg_580_1.nodeConfigList_ = {}

		arg_580_1:InitPlayNodeList()
	end,
	Play301011143 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 301011143
		arg_584_1.duration_ = 14.37

		local var_584_0 = {
			zh = 10.566,
			ja = 14.366
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play301011144(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			local var_587_0 = 1.2

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_1 = arg_584_1:GetWordFromCfg(301011143)
				local var_587_2 = arg_584_1:FormatText(var_587_1.content)

				arg_584_1.text_.text = var_587_2

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_4 = 53 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 53)

				if (53 <= 0 and var_587_0 or var_587_0 * (utf8.len(var_587_2) / 53)) > 0 and var_587_0 < var_587_4 then
					arg_584_1.talkMaxDuration = var_587_4

					if var_587_4 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_4 + 0
					end
				end

				arg_584_1.text_.text = var_587_2
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011143", "story_v_out_301011.awb") ~= 0 then
					local var_587_5 = manager.audio:GetVoiceLength("story_v_out_301011", "301011143", "story_v_out_301011.awb") / 1000

					if var_587_5 + 0 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_5 + 0
					end

					if var_587_1.prefab_name ~= "" and arg_584_1.actors_[var_587_1.prefab_name] ~= nil then
						local var_587_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_1.prefab_name].transform, "story_v_out_301011", "301011143", "story_v_out_301011.awb")

						arg_584_1:RecordAudio("301011143", var_587_6)
						arg_584_1:RecordAudio("301011143", var_587_6)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_301011", "301011143", "story_v_out_301011.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_301011", "301011143", "story_v_out_301011.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_7 = math.max(var_587_0, arg_584_1.talkMaxDuration)

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_7 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - 0) / var_587_7

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= 0 + var_587_7 and arg_584_1.time_ < 0 + var_587_7 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {}

		arg_584_1:InitPlayNodeList()
	end,
	Play301011144 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 301011144
		arg_588_1.duration_ = 14.93

		local var_588_0 = {
			zh = 8.1,
			ja = 14.933
		}
		local var_588_1 = manager.audio:GetLocalizationFlag()

		if var_588_0[var_588_1] ~= nil then
			arg_588_1.duration_ = var_588_0[var_588_1]
		end

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play301011145(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_591_0 = 0
			local var_591_1 = 1

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_2 = arg_588_1:GetWordFromCfg(301011144)
				local var_591_3 = arg_588_1:FormatText(var_591_2.content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_5 = 40 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 40)

				if (40 <= 0 and var_591_1 or var_591_1 * (utf8.len(var_591_3) / 40)) > 0 and var_591_1 < var_591_5 then
					arg_588_1.talkMaxDuration = var_591_5

					if var_591_5 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_5 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011144", "story_v_out_301011.awb") ~= 0 then
					local var_591_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011144", "story_v_out_301011.awb") / 1000

					if var_591_6 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_6 + var_591_0
					end

					if var_591_2.prefab_name ~= "" and arg_588_1.actors_[var_591_2.prefab_name] ~= nil then
						local var_591_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_588_1.actors_[var_591_2.prefab_name].transform, "story_v_out_301011", "301011144", "story_v_out_301011.awb")

						arg_588_1:RecordAudio("301011144", var_591_7)
						arg_588_1:RecordAudio("301011144", var_591_7)
					else
						arg_588_1:AudioAction("play", "voice", "story_v_out_301011", "301011144", "story_v_out_301011.awb")
					end

					arg_588_1:RecordHistoryTalkVoice("story_v_out_301011", "301011144", "story_v_out_301011.awb")
				end

				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_8 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_8 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_8

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_8 and arg_588_1.time_ < var_591_0 + var_591_8 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play301011145 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 301011145
		arg_592_1.duration_ = 7.67

		local var_592_0 = {
			zh = 7.133,
			ja = 7.666
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play301011146(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(arg_592_1.actors_["10066ui_story"]) and arg_592_1.var_.characterEffect10066ui_story == nil then
				arg_592_1.var_.characterEffect10066ui_story = arg_592_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_0 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_0 and not isNil(arg_592_1.actors_["10066ui_story"]) then
				if arg_592_1.var_.characterEffect10066ui_story and not isNil(arg_592_1.actors_["10066ui_story"]) then
					arg_592_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_592_1.time_ >= 0 + var_595_0 and arg_592_1.time_ < 0 + var_595_0 + arg_595_0 and not isNil(arg_592_1.actors_["10066ui_story"]) and arg_592_1.var_.characterEffect10066ui_story then
				arg_592_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_595_2 = arg_592_1.actors_["1084ui_story"]

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 and not isNil(var_595_2) and arg_592_1.var_.characterEffect1084ui_story == nil then
				arg_592_1.var_.characterEffect1084ui_story = var_595_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_595_3 = 0.200000002980232

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_3 and not isNil(var_595_2) then
				if arg_592_1.var_.characterEffect1084ui_story and not isNil(var_595_2) then
					arg_592_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_592_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_592_1.time_ - 0) / var_595_3)
				end
			end

			if arg_592_1.time_ >= 0 + var_595_3 and arg_592_1.time_ < 0 + var_595_3 + arg_595_0 and not isNil(var_595_2) and arg_592_1.var_.characterEffect1084ui_story then
				arg_592_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_592_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_595_4 = 0
			local var_595_5 = 0.675

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_4 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, false)
				arg_592_1.callingController_:SetSelectedState("normal")

				local var_595_6 = arg_592_1:GetWordFromCfg(301011145)
				local var_595_7 = arg_592_1:FormatText(var_595_6.content)

				arg_592_1.text_.text = var_595_7

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_9 = 27 <= 0 and var_595_5 or var_595_5 * (utf8.len(var_595_7) / 27)

				if (27 <= 0 and var_595_5 or var_595_5 * (utf8.len(var_595_7) / 27)) > 0 and var_595_5 < var_595_9 then
					arg_592_1.talkMaxDuration = var_595_9

					if var_595_9 + var_595_4 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_9 + var_595_4
					end
				end

				arg_592_1.text_.text = var_595_7
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011145", "story_v_out_301011.awb") ~= 0 then
					local var_595_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011145", "story_v_out_301011.awb") / 1000

					if var_595_10 + var_595_4 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_10 + var_595_4
					end

					if var_595_6.prefab_name ~= "" and arg_592_1.actors_[var_595_6.prefab_name] ~= nil then
						local var_595_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_6.prefab_name].transform, "story_v_out_301011", "301011145", "story_v_out_301011.awb")

						arg_592_1:RecordAudio("301011145", var_595_11)
						arg_592_1:RecordAudio("301011145", var_595_11)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_301011", "301011145", "story_v_out_301011.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_301011", "301011145", "story_v_out_301011.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_12 = math.max(var_595_5, arg_592_1.talkMaxDuration)

			if var_595_4 <= arg_592_1.time_ and arg_592_1.time_ < var_595_4 + var_595_12 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_4) / var_595_12

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_4 + var_595_12 and arg_592_1.time_ < var_595_4 + var_595_12 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play301011146 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 301011146
		arg_596_1.duration_ = 6.3

		local var_596_0 = {
			zh = 5.8,
			ja = 6.3
		}
		local var_596_1 = manager.audio:GetLocalizationFlag()

		if var_596_0[var_596_1] ~= nil then
			arg_596_1.duration_ = var_596_0[var_596_1]
		end

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play301011147(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action476")
			end

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_599_0 = 0
			local var_599_1 = 0.675

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= var_599_0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_2 = arg_596_1:GetWordFromCfg(301011146)
				local var_599_3 = arg_596_1:FormatText(var_599_2.content)

				arg_596_1.text_.text = var_599_3

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_5 = 27 <= 0 and var_599_1 or var_599_1 * (utf8.len(var_599_3) / 27)

				if (27 <= 0 and var_599_1 or var_599_1 * (utf8.len(var_599_3) / 27)) > 0 and var_599_1 < var_599_5 then
					arg_596_1.talkMaxDuration = var_599_5

					if var_599_5 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_5 + var_599_0
					end
				end

				arg_596_1.text_.text = var_599_3
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011146", "story_v_out_301011.awb") ~= 0 then
					local var_599_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011146", "story_v_out_301011.awb") / 1000

					if var_599_6 + var_599_0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_6 + var_599_0
					end

					if var_599_2.prefab_name ~= "" and arg_596_1.actors_[var_599_2.prefab_name] ~= nil then
						local var_599_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_2.prefab_name].transform, "story_v_out_301011", "301011146", "story_v_out_301011.awb")

						arg_596_1:RecordAudio("301011146", var_599_7)
						arg_596_1:RecordAudio("301011146", var_599_7)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_out_301011", "301011146", "story_v_out_301011.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_out_301011", "301011146", "story_v_out_301011.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_8 = math.max(var_599_1, arg_596_1.talkMaxDuration)

			if var_599_0 <= arg_596_1.time_ and arg_596_1.time_ < var_599_0 + var_599_8 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_0) / var_599_8

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_0 + var_599_8 and arg_596_1.time_ < var_599_0 + var_599_8 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play301011147 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 301011147
		arg_600_1.duration_ = 4.27

		local var_600_0 = {
			zh = 2.633,
			ja = 4.266
		}
		local var_600_1 = manager.audio:GetLocalizationFlag()

		if var_600_0[var_600_1] ~= nil then
			arg_600_1.duration_ = var_600_0[var_600_1]
		end

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play301011148(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(arg_600_1.actors_["1084ui_story"]) and arg_600_1.var_.characterEffect1084ui_story == nil then
				arg_600_1.var_.characterEffect1084ui_story = arg_600_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_0 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_0 and not isNil(arg_600_1.actors_["1084ui_story"]) then
				if arg_600_1.var_.characterEffect1084ui_story and not isNil(arg_600_1.actors_["1084ui_story"]) then
					arg_600_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_600_1.time_ >= 0 + var_603_0 and arg_600_1.time_ < 0 + var_603_0 + arg_603_0 and not isNil(arg_600_1.actors_["1084ui_story"]) and arg_600_1.var_.characterEffect1084ui_story then
				arg_600_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_603_2 = arg_600_1.actors_["10066ui_story"]

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 and not isNil(var_603_2) and arg_600_1.var_.characterEffect10066ui_story == nil then
				arg_600_1.var_.characterEffect10066ui_story = var_603_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_603_3 = 0.200000002980232

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_3 and not isNil(var_603_2) then
				if arg_600_1.var_.characterEffect10066ui_story and not isNil(var_603_2) then
					arg_600_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_600_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_600_1.time_ - 0) / var_603_3)
				end
			end

			if arg_600_1.time_ >= 0 + var_603_3 and arg_600_1.time_ < 0 + var_603_3 + arg_603_0 and not isNil(var_603_2) and arg_600_1.var_.characterEffect10066ui_story then
				arg_600_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_600_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_603_4 = 0
			local var_603_5 = 0.325

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_4 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_6 = arg_600_1:GetWordFromCfg(301011147)
				local var_603_7 = arg_600_1:FormatText(var_603_6.content)

				arg_600_1.text_.text = var_603_7

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_9 = 13 <= 0 and var_603_5 or var_603_5 * (utf8.len(var_603_7) / 13)

				if (13 <= 0 and var_603_5 or var_603_5 * (utf8.len(var_603_7) / 13)) > 0 and var_603_5 < var_603_9 then
					arg_600_1.talkMaxDuration = var_603_9

					if var_603_9 + var_603_4 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_9 + var_603_4
					end
				end

				arg_600_1.text_.text = var_603_7
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011147", "story_v_out_301011.awb") ~= 0 then
					local var_603_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011147", "story_v_out_301011.awb") / 1000

					if var_603_10 + var_603_4 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_10 + var_603_4
					end

					if var_603_6.prefab_name ~= "" and arg_600_1.actors_[var_603_6.prefab_name] ~= nil then
						local var_603_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_6.prefab_name].transform, "story_v_out_301011", "301011147", "story_v_out_301011.awb")

						arg_600_1:RecordAudio("301011147", var_603_11)
						arg_600_1:RecordAudio("301011147", var_603_11)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_out_301011", "301011147", "story_v_out_301011.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_out_301011", "301011147", "story_v_out_301011.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_12 = math.max(var_603_5, arg_600_1.talkMaxDuration)

			if var_603_4 <= arg_600_1.time_ and arg_600_1.time_ < var_603_4 + var_603_12 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_4) / var_603_12

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_4 + var_603_12 and arg_600_1.time_ < var_603_4 + var_603_12 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play301011148 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 301011148
		arg_604_1.duration_ = 7.37

		local var_604_0 = {
			zh = 6.433,
			ja = 7.366
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play301011149(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["10066ui_story"]) and arg_604_1.var_.characterEffect10066ui_story == nil then
				arg_604_1.var_.characterEffect10066ui_story = arg_604_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_0 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["10066ui_story"]) then
				if arg_604_1.var_.characterEffect10066ui_story and not isNil(arg_604_1.actors_["10066ui_story"]) then
					arg_604_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["10066ui_story"]) and arg_604_1.var_.characterEffect10066ui_story then
				arg_604_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_607_2 = arg_604_1.actors_["1084ui_story"]

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(var_607_2) and arg_604_1.var_.characterEffect1084ui_story == nil then
				arg_604_1.var_.characterEffect1084ui_story = var_607_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_607_3 = 0.200000002980232

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_3 and not isNil(var_607_2) then
				if arg_604_1.var_.characterEffect1084ui_story and not isNil(var_607_2) then
					arg_604_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_604_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_604_1.time_ - 0) / var_607_3)
				end
			end

			if arg_604_1.time_ >= 0 + var_607_3 and arg_604_1.time_ < 0 + var_607_3 + arg_607_0 and not isNil(var_607_2) and arg_604_1.var_.characterEffect1084ui_story then
				arg_604_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_604_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_607_4 = 0
			local var_607_5 = 0.6

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_4 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_6 = arg_604_1:GetWordFromCfg(301011148)
				local var_607_7 = arg_604_1:FormatText(var_607_6.content)

				arg_604_1.text_.text = var_607_7

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_9 = 24 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 24)

				if (24 <= 0 and var_607_5 or var_607_5 * (utf8.len(var_607_7) / 24)) > 0 and var_607_5 < var_607_9 then
					arg_604_1.talkMaxDuration = var_607_9

					if var_607_9 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_9 + var_607_4
					end
				end

				arg_604_1.text_.text = var_607_7
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011148", "story_v_out_301011.awb") ~= 0 then
					local var_607_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011148", "story_v_out_301011.awb") / 1000

					if var_607_10 + var_607_4 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_10 + var_607_4
					end

					if var_607_6.prefab_name ~= "" and arg_604_1.actors_[var_607_6.prefab_name] ~= nil then
						local var_607_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_6.prefab_name].transform, "story_v_out_301011", "301011148", "story_v_out_301011.awb")

						arg_604_1:RecordAudio("301011148", var_607_11)
						arg_604_1:RecordAudio("301011148", var_607_11)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_301011", "301011148", "story_v_out_301011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_301011", "301011148", "story_v_out_301011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_12 = math.max(var_607_5, arg_604_1.talkMaxDuration)

			if var_607_4 <= arg_604_1.time_ and arg_604_1.time_ < var_607_4 + var_607_12 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_4) / var_607_12

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_4 + var_607_12 and arg_604_1.time_ < var_607_4 + var_607_12 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play301011149 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 301011149
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play301011150(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos10066ui_story = arg_608_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_611_0 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 then
				arg_608_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_608_1.time_ - 0) / var_611_0)
				arg_608_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).z)
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles = arg_608_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 then
				arg_608_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_608_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_608_1.actors_["10066ui_story"].transform.position).z)
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_608_1.actors_["10066ui_story"].transform.localEulerAngles = arg_608_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_611_1 = arg_608_1.actors_["1084ui_story"].transform

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1084ui_story = var_611_1.localPosition
			end

			local var_611_2 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_2 then
				var_611_1.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_608_1.time_ - 0) / var_611_2)
				var_611_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_611_1.position).x, (manager.ui.mainCamera.transform.position - var_611_1.position).y, (manager.ui.mainCamera.transform.position - var_611_1.position).z)
				var_611_1.localEulerAngles.z = 0
				var_611_1.localEulerAngles.x = 0
				var_611_1.localEulerAngles = var_611_1.localEulerAngles
			end

			if arg_608_1.time_ >= 0 + var_611_2 and arg_608_1.time_ < 0 + var_611_2 + arg_611_0 then
				var_611_1.localPosition = Vector3.New(0, 100, 0)
				var_611_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_611_1.position).x, (manager.ui.mainCamera.transform.position - var_611_1.position).y, (manager.ui.mainCamera.transform.position - var_611_1.position).z)
				var_611_1.localEulerAngles.z = 0
				var_611_1.localEulerAngles.x = 0
				var_611_1.localEulerAngles = var_611_1.localEulerAngles
			end

			local var_611_3 = arg_608_1.actors_["10066ui_story"]

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(var_611_3) and arg_608_1.var_.characterEffect10066ui_story == nil then
				arg_608_1.var_.characterEffect10066ui_story = var_611_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_4 = 0.200000002980232

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_4 and not isNil(var_611_3) then
				if arg_608_1.var_.characterEffect10066ui_story and not isNil(var_611_3) then
					arg_608_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_608_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_608_1.time_ - 0) / var_611_4)
				end
			end

			if arg_608_1.time_ >= 0 + var_611_4 and arg_608_1.time_ < 0 + var_611_4 + arg_611_0 and not isNil(var_611_3) and arg_608_1.var_.characterEffect10066ui_story then
				arg_608_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_608_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_611_5 = 0
			local var_611_6 = 1.35

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_5 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_7 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(301011149).content)

				arg_608_1.text_.text = var_611_7

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_9 = 54 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_7) / 54)

				if (54 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_7) / 54)) > 0 and var_611_6 < var_611_9 then
					arg_608_1.talkMaxDuration = var_611_9

					if var_611_9 + var_611_5 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_9 + var_611_5
					end
				end

				arg_608_1.text_.text = var_611_7
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_10 = math.max(var_611_6, arg_608_1.talkMaxDuration)

			if var_611_5 <= arg_608_1.time_ and arg_608_1.time_ < var_611_5 + var_611_10 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_5) / var_611_10

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_5 + var_611_10 and arg_608_1.time_ < var_611_5 + var_611_10 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play301011150 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 301011150
		arg_612_1.duration_ = 4.07

		local var_612_0 = {
			zh = 3.8,
			ja = 4.066
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play301011151(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.var_.moveOldPos10066ui_story = arg_612_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_615_0 = 0.001

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_0 then
				arg_612_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_612_1.time_ - 0) / var_615_0)
				arg_612_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).z)
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles = arg_612_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_612_1.time_ >= 0 + var_615_0 and arg_612_1.time_ < 0 + var_615_0 + arg_615_0 then
				arg_612_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_612_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_612_1.actors_["10066ui_story"].transform.position).z)
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_612_1.actors_["10066ui_story"].transform.localEulerAngles = arg_612_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_615_1 = arg_612_1.actors_["10066ui_story"]

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect10066ui_story == nil then
				arg_612_1.var_.characterEffect10066ui_story = var_615_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_2 = 0.200000002980232

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_2 and not isNil(var_615_1) then
				if arg_612_1.var_.characterEffect10066ui_story and not isNil(var_615_1) then
					arg_612_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= 0 + var_615_2 and arg_612_1.time_ < 0 + var_615_2 + arg_615_0 and not isNil(var_615_1) and arg_612_1.var_.characterEffect10066ui_story then
				arg_612_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_615_4 = 0
			local var_615_5 = 0.225

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_4 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_6 = arg_612_1:GetWordFromCfg(301011150)
				local var_615_7 = arg_612_1:FormatText(var_615_6.content)

				arg_612_1.text_.text = var_615_7

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_9 = 9 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 9)

				if (9 <= 0 and var_615_5 or var_615_5 * (utf8.len(var_615_7) / 9)) > 0 and var_615_5 < var_615_9 then
					arg_612_1.talkMaxDuration = var_615_9

					if var_615_9 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_9 + var_615_4
					end
				end

				arg_612_1.text_.text = var_615_7
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011150", "story_v_out_301011.awb") ~= 0 then
					local var_615_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011150", "story_v_out_301011.awb") / 1000

					if var_615_10 + var_615_4 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_10 + var_615_4
					end

					if var_615_6.prefab_name ~= "" and arg_612_1.actors_[var_615_6.prefab_name] ~= nil then
						local var_615_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_6.prefab_name].transform, "story_v_out_301011", "301011150", "story_v_out_301011.awb")

						arg_612_1:RecordAudio("301011150", var_615_11)
						arg_612_1:RecordAudio("301011150", var_615_11)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_301011", "301011150", "story_v_out_301011.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_301011", "301011150", "story_v_out_301011.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_12 = math.max(var_615_5, arg_612_1.talkMaxDuration)

			if var_615_4 <= arg_612_1.time_ and arg_612_1.time_ < var_615_4 + var_615_12 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_4) / var_615_12

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_4 + var_615_12 and arg_612_1.time_ < var_615_4 + var_615_12 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play301011151 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 301011151
		arg_616_1.duration_ = 4.1

		local var_616_0 = {
			zh = 3.633,
			ja = 4.1
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play301011152(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.var_.moveOldPos1084ui_story = arg_616_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_619_0 = 0.001

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_0 then
				arg_616_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_616_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_616_1.time_ - 0) / var_619_0)
				arg_616_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).z)
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles = arg_616_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_616_1.time_ >= 0 + var_619_0 and arg_616_1.time_ < 0 + var_619_0 + arg_619_0 then
				arg_616_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_616_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_616_1.actors_["1084ui_story"].transform.position).z)
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_616_1.actors_["1084ui_story"].transform.localEulerAngles = arg_616_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_619_1 = arg_616_1.actors_["1084ui_story"]

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(var_619_1) and arg_616_1.var_.characterEffect1084ui_story == nil then
				arg_616_1.var_.characterEffect1084ui_story = var_619_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_2 = 0.200000002980232

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_2 and not isNil(var_619_1) then
				if arg_616_1.var_.characterEffect1084ui_story and not isNil(var_619_1) then
					arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_616_1.time_ >= 0 + var_619_2 and arg_616_1.time_ < 0 + var_619_2 + arg_619_0 and not isNil(var_619_1) and arg_616_1.var_.characterEffect1084ui_story then
				arg_616_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_619_4 = arg_616_1.actors_["10066ui_story"]

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 and not isNil(var_619_4) and arg_616_1.var_.characterEffect10066ui_story == nil then
				arg_616_1.var_.characterEffect10066ui_story = var_619_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_619_5 = 0.200000002980232

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_5 and not isNil(var_619_4) then
				if arg_616_1.var_.characterEffect10066ui_story and not isNil(var_619_4) then
					arg_616_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_616_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_616_1.time_ - 0) / var_619_5)
				end
			end

			if arg_616_1.time_ >= 0 + var_619_5 and arg_616_1.time_ < 0 + var_619_5 + arg_619_0 and not isNil(var_619_4) and arg_616_1.var_.characterEffect10066ui_story then
				arg_616_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_616_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_619_6 = 0
			local var_619_7 = 0.375

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_6 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_8 = arg_616_1:GetWordFromCfg(301011151)
				local var_619_9 = arg_616_1:FormatText(var_619_8.content)

				arg_616_1.text_.text = var_619_9

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_11 = 15 <= 0 and var_619_7 or var_619_7 * (utf8.len(var_619_9) / 15)

				if (15 <= 0 and var_619_7 or var_619_7 * (utf8.len(var_619_9) / 15)) > 0 and var_619_7 < var_619_11 then
					arg_616_1.talkMaxDuration = var_619_11

					if var_619_11 + var_619_6 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_11 + var_619_6
					end
				end

				arg_616_1.text_.text = var_619_9
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011151", "story_v_out_301011.awb") ~= 0 then
					local var_619_12 = manager.audio:GetVoiceLength("story_v_out_301011", "301011151", "story_v_out_301011.awb") / 1000

					if var_619_12 + var_619_6 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_12 + var_619_6
					end

					if var_619_8.prefab_name ~= "" and arg_616_1.actors_[var_619_8.prefab_name] ~= nil then
						local var_619_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_8.prefab_name].transform, "story_v_out_301011", "301011151", "story_v_out_301011.awb")

						arg_616_1:RecordAudio("301011151", var_619_13)
						arg_616_1:RecordAudio("301011151", var_619_13)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_301011", "301011151", "story_v_out_301011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_301011", "301011151", "story_v_out_301011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_14 = math.max(var_619_7, arg_616_1.talkMaxDuration)

			if var_619_6 <= arg_616_1.time_ and arg_616_1.time_ < var_619_6 + var_619_14 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_6) / var_619_14

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_6 + var_619_14 and arg_616_1.time_ < var_619_6 + var_619_14 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_616_1:InitPlayNodeList()
	end,
	Play301011152 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 301011152
		arg_620_1.duration_ = 7.63

		local var_620_0 = {
			zh = 7.2,
			ja = 7.633
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play301011153(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(arg_620_1.actors_["10066ui_story"]) and arg_620_1.var_.characterEffect10066ui_story == nil then
				arg_620_1.var_.characterEffect10066ui_story = arg_620_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_0 = 0.200000002980232

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_0 and not isNil(arg_620_1.actors_["10066ui_story"]) then
				if arg_620_1.var_.characterEffect10066ui_story and not isNil(arg_620_1.actors_["10066ui_story"]) then
					arg_620_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_620_1.time_ >= 0 + var_623_0 and arg_620_1.time_ < 0 + var_623_0 + arg_623_0 and not isNil(arg_620_1.actors_["10066ui_story"]) and arg_620_1.var_.characterEffect10066ui_story then
				arg_620_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_623_2 = arg_620_1.actors_["1084ui_story"]

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 and not isNil(var_623_2) and arg_620_1.var_.characterEffect1084ui_story == nil then
				arg_620_1.var_.characterEffect1084ui_story = var_623_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_623_3 = 0.200000002980232

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_3 and not isNil(var_623_2) then
				if arg_620_1.var_.characterEffect1084ui_story and not isNil(var_623_2) then
					arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_620_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_620_1.time_ - 0) / var_623_3)
				end
			end

			if arg_620_1.time_ >= 0 + var_623_3 and arg_620_1.time_ < 0 + var_623_3 + arg_623_0 and not isNil(var_623_2) and arg_620_1.var_.characterEffect1084ui_story then
				arg_620_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_620_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action476")
			end

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_623_4 = 0
			local var_623_5 = 0.725

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_4 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_6 = arg_620_1:GetWordFromCfg(301011152)
				local var_623_7 = arg_620_1:FormatText(var_623_6.content)

				arg_620_1.text_.text = var_623_7

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_9 = 29 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 29)

				if (29 <= 0 and var_623_5 or var_623_5 * (utf8.len(var_623_7) / 29)) > 0 and var_623_5 < var_623_9 then
					arg_620_1.talkMaxDuration = var_623_9

					if var_623_9 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_9 + var_623_4
					end
				end

				arg_620_1.text_.text = var_623_7
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011152", "story_v_out_301011.awb") ~= 0 then
					local var_623_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011152", "story_v_out_301011.awb") / 1000

					if var_623_10 + var_623_4 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_10 + var_623_4
					end

					if var_623_6.prefab_name ~= "" and arg_620_1.actors_[var_623_6.prefab_name] ~= nil then
						local var_623_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_6.prefab_name].transform, "story_v_out_301011", "301011152", "story_v_out_301011.awb")

						arg_620_1:RecordAudio("301011152", var_623_11)
						arg_620_1:RecordAudio("301011152", var_623_11)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_301011", "301011152", "story_v_out_301011.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_301011", "301011152", "story_v_out_301011.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_12 = math.max(var_623_5, arg_620_1.talkMaxDuration)

			if var_623_4 <= arg_620_1.time_ and arg_620_1.time_ < var_623_4 + var_623_12 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_4) / var_623_12

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_4 + var_623_12 and arg_620_1.time_ < var_623_4 + var_623_12 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play301011153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 301011153
		arg_624_1.duration_ = 8.07

		local var_624_0 = {
			zh = 6.633,
			ja = 8.066
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play301011154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_627_0 = 0
			local var_627_1 = 0.7

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_2 = arg_624_1:GetWordFromCfg(301011153)
				local var_627_3 = arg_624_1:FormatText(var_627_2.content)

				arg_624_1.text_.text = var_627_3

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 28 <= 0 and var_627_1 or var_627_1 * (utf8.len(var_627_3) / 28)

				if (28 <= 0 and var_627_1 or var_627_1 * (utf8.len(var_627_3) / 28)) > 0 and var_627_1 < var_627_5 then
					arg_624_1.talkMaxDuration = var_627_5

					if var_627_5 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_5 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_3
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011153", "story_v_out_301011.awb") ~= 0 then
					local var_627_6 = manager.audio:GetVoiceLength("story_v_out_301011", "301011153", "story_v_out_301011.awb") / 1000

					if var_627_6 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_6 + var_627_0
					end

					if var_627_2.prefab_name ~= "" and arg_624_1.actors_[var_627_2.prefab_name] ~= nil then
						local var_627_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_2.prefab_name].transform, "story_v_out_301011", "301011153", "story_v_out_301011.awb")

						arg_624_1:RecordAudio("301011153", var_627_7)
						arg_624_1:RecordAudio("301011153", var_627_7)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_301011", "301011153", "story_v_out_301011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_301011", "301011153", "story_v_out_301011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_8 and arg_624_1.time_ < var_627_0 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play301011154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 301011154
		arg_628_1.duration_ = 4.07

		local var_628_0 = {
			zh = 2.7,
			ja = 4.066
		}
		local var_628_1 = manager.audio:GetLocalizationFlag()

		if var_628_0[var_628_1] ~= nil then
			arg_628_1.duration_ = var_628_0[var_628_1]
		end

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play301011155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(arg_628_1.actors_["1084ui_story"]) and arg_628_1.var_.characterEffect1084ui_story == nil then
				arg_628_1.var_.characterEffect1084ui_story = arg_628_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_0 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_0 and not isNil(arg_628_1.actors_["1084ui_story"]) then
				if arg_628_1.var_.characterEffect1084ui_story and not isNil(arg_628_1.actors_["1084ui_story"]) then
					arg_628_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= 0 + var_631_0 and arg_628_1.time_ < 0 + var_631_0 + arg_631_0 and not isNil(arg_628_1.actors_["1084ui_story"]) and arg_628_1.var_.characterEffect1084ui_story then
				arg_628_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_631_2 = arg_628_1.actors_["10066ui_story"]

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 and not isNil(var_631_2) and arg_628_1.var_.characterEffect10066ui_story == nil then
				arg_628_1.var_.characterEffect10066ui_story = var_631_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_3 = 0.200000002980232

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_3 and not isNil(var_631_2) then
				if arg_628_1.var_.characterEffect10066ui_story and not isNil(var_631_2) then
					arg_628_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_628_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_628_1.time_ - 0) / var_631_3)
				end
			end

			if arg_628_1.time_ >= 0 + var_631_3 and arg_628_1.time_ < 0 + var_631_3 + arg_631_0 and not isNil(var_631_2) and arg_628_1.var_.characterEffect10066ui_story then
				arg_628_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_628_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_631_4 = 0
			local var_631_5 = 0.275

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= var_631_4 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				arg_628_1.leftNameTxt_.text = arg_628_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_6 = arg_628_1:GetWordFromCfg(301011154)
				local var_631_7 = arg_628_1:FormatText(var_631_6.content)

				arg_628_1.text_.text = var_631_7

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_9 = 11 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 11)

				if (11 <= 0 and var_631_5 or var_631_5 * (utf8.len(var_631_7) / 11)) > 0 and var_631_5 < var_631_9 then
					arg_628_1.talkMaxDuration = var_631_9

					if var_631_9 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_9 + var_631_4
					end
				end

				arg_628_1.text_.text = var_631_7
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_301011", "301011154", "story_v_out_301011.awb") ~= 0 then
					local var_631_10 = manager.audio:GetVoiceLength("story_v_out_301011", "301011154", "story_v_out_301011.awb") / 1000

					if var_631_10 + var_631_4 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_10 + var_631_4
					end

					if var_631_6.prefab_name ~= "" and arg_628_1.actors_[var_631_6.prefab_name] ~= nil then
						local var_631_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_628_1.actors_[var_631_6.prefab_name].transform, "story_v_out_301011", "301011154", "story_v_out_301011.awb")

						arg_628_1:RecordAudio("301011154", var_631_11)
						arg_628_1:RecordAudio("301011154", var_631_11)
					else
						arg_628_1:AudioAction("play", "voice", "story_v_out_301011", "301011154", "story_v_out_301011.awb")
					end

					arg_628_1:RecordHistoryTalkVoice("story_v_out_301011", "301011154", "story_v_out_301011.awb")
				end

				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_12 = math.max(var_631_5, arg_628_1.talkMaxDuration)

			if var_631_4 <= arg_628_1.time_ and arg_628_1.time_ < var_631_4 + var_631_12 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_4) / var_631_12

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_4 + var_631_12 and arg_628_1.time_ < var_631_4 + var_631_12 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play301011155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 301011155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play301011156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1.var_.moveOldPos10066ui_story = arg_632_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_635_0 = 0.001

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 then
				arg_632_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_632_1.time_ - 0) / var_635_0)
				arg_632_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).z)
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles = arg_632_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 then
				arg_632_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_632_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["10066ui_story"].transform.position).z)
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["10066ui_story"].transform.localEulerAngles = arg_632_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_635_1 = arg_632_1.actors_["1084ui_story"].transform

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1.var_.moveOldPos1084ui_story = var_635_1.localPosition
			end

			local var_635_2 = 0.001

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_2 then
				var_635_1.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_632_1.time_ - 0) / var_635_2)
				var_635_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_635_1.position).x, (manager.ui.mainCamera.transform.position - var_635_1.position).y, (manager.ui.mainCamera.transform.position - var_635_1.position).z)
				var_635_1.localEulerAngles.z = 0
				var_635_1.localEulerAngles.x = 0
				var_635_1.localEulerAngles = var_635_1.localEulerAngles
			end

			if arg_632_1.time_ >= 0 + var_635_2 and arg_632_1.time_ < 0 + var_635_2 + arg_635_0 then
				var_635_1.localPosition = Vector3.New(0, 100, 0)
				var_635_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_635_1.position).x, (manager.ui.mainCamera.transform.position - var_635_1.position).y, (manager.ui.mainCamera.transform.position - var_635_1.position).z)
				var_635_1.localEulerAngles.z = 0
				var_635_1.localEulerAngles.x = 0
				var_635_1.localEulerAngles = var_635_1.localEulerAngles
			end

			local var_635_3 = arg_632_1.actors_["1084ui_story"]

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(var_635_3) and arg_632_1.var_.characterEffect1084ui_story == nil then
				arg_632_1.var_.characterEffect1084ui_story = var_635_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_4 = 0.200000002980232

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_4 and not isNil(var_635_3) then
				if arg_632_1.var_.characterEffect1084ui_story and not isNil(var_635_3) then
					arg_632_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_632_1.time_ - 0) / var_635_4)
				end
			end

			if arg_632_1.time_ >= 0 + var_635_4 and arg_632_1.time_ < 0 + var_635_4 + arg_635_0 and not isNil(var_635_3) and arg_632_1.var_.characterEffect1084ui_story then
				arg_632_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_635_5 = 0
			local var_635_6 = 1.1

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_5 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, false)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_7 = arg_632_1:FormatText(arg_632_1:GetWordFromCfg(301011155).content)

				arg_632_1.text_.text = var_635_7

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_9 = 44 <= 0 and var_635_6 or var_635_6 * (utf8.len(var_635_7) / 44)

				if (44 <= 0 and var_635_6 or var_635_6 * (utf8.len(var_635_7) / 44)) > 0 and var_635_6 < var_635_9 then
					arg_632_1.talkMaxDuration = var_635_9

					if var_635_9 + var_635_5 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_9 + var_635_5
					end
				end

				arg_632_1.text_.text = var_635_7
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_10 = math.max(var_635_6, arg_632_1.talkMaxDuration)

			if var_635_5 <= arg_632_1.time_ and arg_632_1.time_ < var_635_5 + var_635_10 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_5) / var_635_10

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_5 + var_635_10 and arg_632_1.time_ < var_635_5 + var_635_10 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play301011156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 301011156
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
			arg_636_1.auto_ = false
		end

		function arg_636_1.playNext_(arg_638_0)
			arg_636_1.onStoryFinished_()
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0.55

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, false)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_1 = arg_636_1:FormatText(arg_636_1:GetWordFromCfg(301011156).content)

				arg_636_1.text_.text = var_639_1

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_3 = 22 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_1) / 22)

				if (22 <= 0 and var_639_0 or var_639_0 * (utf8.len(var_639_1) / 22)) > 0 and var_639_0 < var_639_3 then
					arg_636_1.talkMaxDuration = var_639_3

					if var_639_3 + 0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_3 + 0
					end
				end

				arg_636_1.text_.text = var_639_1
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_4 = math.max(var_639_0, arg_636_1.talkMaxDuration)

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_4 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - 0) / var_639_4

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= 0 + var_639_4 and arg_636_1.time_ < 0 + var_639_4 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play301011050 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 301011050
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play301011052(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = 1.35

			if 0 < arg_640_1.time_ and arg_640_1.time_ <= 0 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, false)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_640_1.iconTrs_.gameObject, false)
				arg_640_1.callingController_:SetSelectedState("normal")

				local var_643_1 = arg_640_1:FormatText(arg_640_1:GetWordFromCfg(301011050).content)

				arg_640_1.text_.text = var_643_1

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_3 = 54 <= 0 and var_643_0 or var_643_0 * (utf8.len(var_643_1) / 54)

				if (54 <= 0 and var_643_0 or var_643_0 * (utf8.len(var_643_1) / 54)) > 0 and var_643_0 < var_643_3 then
					arg_640_1.talkMaxDuration = var_643_3

					if var_643_3 + 0 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_3 + 0
					end
				end

				arg_640_1.text_.text = var_643_1
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_4 = math.max(var_643_0, arg_640_1.talkMaxDuration)

			if 0 <= arg_640_1.time_ and arg_640_1.time_ < 0 + var_643_4 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - 0) / var_643_4

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= 0 + var_643_4 and arg_640_1.time_ < 0 + var_643_4 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play301011051 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 301011051
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play301011052(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0.075

			if 0 < arg_644_1.time_ and arg_644_1.time_ <= 0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				arg_644_1.leftNameTxt_.text = arg_644_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, true)
				arg_644_1.iconController_:SetSelectedState("hero")

				arg_644_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_644_1.callingController_:SetSelectedState("normal")

				arg_644_1.keyicon_.color = Color.New(1, 1, 1)
				arg_644_1.icon_.color = Color.New(1, 1, 1)

				local var_647_1 = arg_644_1:FormatText(arg_644_1:GetWordFromCfg(301011051).content)

				arg_644_1.text_.text = var_647_1

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_3 = 3 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 3)

				if (3 <= 0 and var_647_0 or var_647_0 * (utf8.len(var_647_1) / 3)) > 0 and var_647_0 < var_647_3 then
					arg_644_1.talkMaxDuration = var_647_3

					if var_647_3 + 0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_3 + 0
					end
				end

				arg_644_1.text_.text = var_647_1
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_4 = math.max(var_647_0, arg_644_1.talkMaxDuration)

			if 0 <= arg_644_1.time_ and arg_644_1.time_ < 0 + var_647_4 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - 0) / var_647_4

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= 0 + var_647_4 and arg_644_1.time_ < 0 + var_647_4 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0504",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST07",
		"TextureConfig/Background/I02f"
	},
	voices = {
		"story_v_out_301011.awb"
	}
}
