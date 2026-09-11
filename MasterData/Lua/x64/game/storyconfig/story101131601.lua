return {
	Play113161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F04 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_4_0.name = "F04"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F04 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F04

				arg_1_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_ui", "bgm_activity_1_3_ui", "bgm_activity_1_3_ui.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_activity_1_3_ui", "bgm_activity_1_3_ui")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(113161001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 12 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 12)

				if (12 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 12)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play113161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.325

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(113161002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 53 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 53)

				if (53 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 53)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play113161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113161003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play113161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.775

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(113161003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 71 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 71)

				if (71 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 71)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play113161004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113161004
		arg_16_1.duration_ = 15.37

		local var_16_0 = {
			ja = 15.133,
			ko = 13.533,
			zh = 13.033,
			en = 15.366
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play113161005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[133].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(113161004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 64 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 64)

				if (64 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 64)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161004", "story_v_out_113161.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161004", "story_v_out_113161.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_113161", "113161004", "story_v_out_113161.awb")

						arg_16_1:RecordAudio("113161004", var_19_6)
						arg_16_1:RecordAudio("113161004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113161", "113161004", "story_v_out_113161.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113161", "113161004", "story_v_out_113161.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play113161005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113161005
		arg_20_1.duration_ = 2.53

		local var_20_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 2.533,
			en = 1.999999999999
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113161006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1068ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1068ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1068ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1068ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1068ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1068ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1068ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1068ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_23_5 = arg_20_1.actors_["1068ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1068ui_story == nil then
				arg_20_1.var_.characterEffect1068ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1068ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1068ui_story then
				arg_20_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_23_8 = 0
			local var_23_9 = 0.275

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(113161005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 11 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 11)

				if (11 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 11)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161005", "story_v_out_113161.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161005", "story_v_out_113161.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_113161", "113161005", "story_v_out_113161.awb")

						arg_20_1:RecordAudio("113161005", var_23_15)
						arg_20_1:RecordAudio("113161005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_113161", "113161005", "story_v_out_113161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_113161", "113161005", "story_v_out_113161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play113161006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113161006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play113161007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1067ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1067ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1067ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1067ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1067ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1067ui_story = var_27_3.localPosition
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_24_1.time_ - 0) / var_27_4)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_27_5 = arg_24_1.actors_["1067ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1067ui_story == nil then
				arg_24_1.var_.characterEffect1067ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 and not isNil(var_27_5) then
				if arg_24_1.var_.characterEffect1067ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect1067ui_story then
				arg_24_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_27_8 = arg_24_1.actors_["1068ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect1068ui_story == nil then
				arg_24_1.var_.characterEffect1068ui_story = var_27_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_9 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 and not isNil(var_27_8) then
				if arg_24_1.var_.characterEffect1068ui_story and not isNil(var_27_8) then
					arg_24_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_9)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect1068ui_story then
				arg_24_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_27_10 = 0
			local var_27_11 = 0.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(113161006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 2 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 2)

				if (2 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 2)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161006", "story_v_out_113161.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_113161", "113161006", "story_v_out_113161.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_113161", "113161006", "story_v_out_113161.awb")

						arg_24_1:RecordAudio("113161006", var_27_17)
						arg_24_1:RecordAudio("113161006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113161", "113161006", "story_v_out_113161.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113161", "113161006", "story_v_out_113161.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play113161007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113161007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play113161008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1067ui_story = arg_28_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).z)
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles = arg_28_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1067ui_story"].transform.position).z)
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1067ui_story"].transform.localEulerAngles = arg_28_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1068ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1068ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = 0
			local var_31_4 = 0.75

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(113161007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 30 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 30)

				if (30 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 30)) > 0 and var_31_4 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_8 and arg_28_1.time_ < var_31_3 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play113161008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 113161008
		arg_32_1.duration_ = 6.8

		local var_32_0 = {
			ja = 6.8,
			ko = 6.7,
			zh = 6.633,
			en = 6.3
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play113161009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1067ui_story = arg_32_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).z)
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles = arg_32_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_32_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1067ui_story"].transform.position).z)
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1067ui_story"].transform.localEulerAngles = arg_32_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_35_1 = arg_32_1.actors_["1067ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1067ui_story == nil then
				arg_32_1.var_.characterEffect1067ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1067ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1067ui_story then
				arg_32_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.775

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(113161008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 31 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 31)

				if (31 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 31)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161008", "story_v_out_113161.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161008", "story_v_out_113161.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_113161", "113161008", "story_v_out_113161.awb")

						arg_32_1:RecordAudio("113161008", var_35_11)
						arg_32_1:RecordAudio("113161008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_113161", "113161008", "story_v_out_113161.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_113161", "113161008", "story_v_out_113161.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play113161009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113161009
		arg_36_1.duration_ = 8.3

		local var_36_0 = {
			ja = 7.8,
			ko = 7.833,
			zh = 7.933,
			en = 8.3
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play113161010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_0 = 0
			local var_39_1 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_2 = arg_36_1:GetWordFromCfg(113161009)
				local var_39_3 = arg_36_1:FormatText(var_39_2.content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 34 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 34)

				if (34 <= 0 and var_39_1 or var_39_1 * (utf8.len(var_39_3) / 34)) > 0 and var_39_1 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161009", "story_v_out_113161.awb") ~= 0 then
					local var_39_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161009", "story_v_out_113161.awb") / 1000

					if var_39_6 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_0
					end

					if var_39_2.prefab_name ~= "" and arg_36_1.actors_[var_39_2.prefab_name] ~= nil then
						local var_39_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_2.prefab_name].transform, "story_v_out_113161", "113161009", "story_v_out_113161.awb")

						arg_36_1:RecordAudio("113161009", var_39_7)
						arg_36_1:RecordAudio("113161009", var_39_7)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113161", "113161009", "story_v_out_113161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113161", "113161009", "story_v_out_113161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_8 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_8 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_8

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_8 and arg_36_1.time_ < var_39_0 + var_39_8 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play113161010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113161010
		arg_40_1.duration_ = 11.37

		local var_40_0 = {
			ja = 11.2,
			ko = 11.033,
			zh = 11.366,
			en = 8.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113161011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_0 = 0
			local var_43_1 = 1.15

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(113161010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 46 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 46)

				if (46 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 46)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161010", "story_v_out_113161.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161010", "story_v_out_113161.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_113161", "113161010", "story_v_out_113161.awb")

						arg_40_1:RecordAudio("113161010", var_43_7)
						arg_40_1:RecordAudio("113161010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_113161", "113161010", "story_v_out_113161.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_113161", "113161010", "story_v_out_113161.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play113161011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113161011
		arg_44_1.duration_ = 12.83

		local var_44_0 = {
			ja = 12.833,
			ko = 10.9,
			zh = 11.9,
			en = 10.9
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play113161012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_0 = 0
			local var_47_1 = 1.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(113161011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 45 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 45)

				if (45 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 45)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161011", "story_v_out_113161.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161011", "story_v_out_113161.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_out_113161", "113161011", "story_v_out_113161.awb")

						arg_44_1:RecordAudio("113161011", var_47_7)
						arg_44_1:RecordAudio("113161011", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113161", "113161011", "story_v_out_113161.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113161", "113161011", "story_v_out_113161.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play113161012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113161012
		arg_48_1.duration_ = 10.6

		local var_48_0 = {
			ja = 8.9,
			ko = 8,
			zh = 9.5,
			en = 10.6
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play113161013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_0 = 0
			local var_51_1 = 0.9

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(113161012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 36 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 36)

				if (36 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 36)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161012", "story_v_out_113161.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161012", "story_v_out_113161.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_113161", "113161012", "story_v_out_113161.awb")

						arg_48_1:RecordAudio("113161012", var_51_7)
						arg_48_1:RecordAudio("113161012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113161", "113161012", "story_v_out_113161.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113161", "113161012", "story_v_out_113161.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play113161013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113161013
		arg_52_1.duration_ = 11.13

		local var_52_0 = {
			ja = 11.133,
			ko = 8.033,
			zh = 7.666,
			en = 9.266
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play113161014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_0 = 0
			local var_55_1 = 0.75

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(113161013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 30 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 30)

				if (30 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 30)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161013", "story_v_out_113161.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161013", "story_v_out_113161.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_113161", "113161013", "story_v_out_113161.awb")

						arg_52_1:RecordAudio("113161013", var_55_7)
						arg_52_1:RecordAudio("113161013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113161", "113161013", "story_v_out_113161.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113161", "113161013", "story_v_out_113161.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113161014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 113161014
		arg_56_1.duration_ = 12.37

		local var_56_0 = {
			ja = 12.366,
			ko = 8.666,
			zh = 11.5,
			en = 11.933
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play113161015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action436")
			end

			local var_59_0 = 0
			local var_59_1 = 1.1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(113161014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 44 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 44)

				if (44 <= 0 and var_59_1 or var_59_1 * (utf8.len(var_59_3) / 44)) > 0 and var_59_1 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161014", "story_v_out_113161.awb") ~= 0 then
					local var_59_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161014", "story_v_out_113161.awb") / 1000

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end

					if var_59_2.prefab_name ~= "" and arg_56_1.actors_[var_59_2.prefab_name] ~= nil then
						local var_59_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_2.prefab_name].transform, "story_v_out_113161", "113161014", "story_v_out_113161.awb")

						arg_56_1:RecordAudio("113161014", var_59_7)
						arg_56_1:RecordAudio("113161014", var_59_7)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_113161", "113161014", "story_v_out_113161.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_113161", "113161014", "story_v_out_113161.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_8 and arg_56_1.time_ < var_59_0 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play113161015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 113161015
		arg_60_1.duration_ = 11.4

		local var_60_0 = {
			ja = 8.566,
			ko = 6.633,
			zh = 8.033,
			en = 11.4
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play113161016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_63_0 = 0
			local var_63_1 = 0.725

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(113161015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 29 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 29)

				if (29 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 29)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161015", "story_v_out_113161.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161015", "story_v_out_113161.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_113161", "113161015", "story_v_out_113161.awb")

						arg_60_1:RecordAudio("113161015", var_63_7)
						arg_60_1:RecordAudio("113161015", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_113161", "113161015", "story_v_out_113161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_113161", "113161015", "story_v_out_113161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play113161016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 113161016
		arg_64_1.duration_ = 10.9

		local var_64_0 = {
			ja = 9.5,
			ko = 7.8,
			zh = 10.9,
			en = 9.033
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play113161017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action463")
			end

			local var_67_0 = 0
			local var_67_1 = 0.95

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(113161016)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 38 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 38)

				if (38 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 38)) > 0 and var_67_1 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161016", "story_v_out_113161.awb") ~= 0 then
					local var_67_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161016", "story_v_out_113161.awb") / 1000

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_113161", "113161016", "story_v_out_113161.awb")

						arg_64_1:RecordAudio("113161016", var_67_7)
						arg_64_1:RecordAudio("113161016", var_67_7)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_113161", "113161016", "story_v_out_113161.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_113161", "113161016", "story_v_out_113161.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play113161017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 113161017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play113161018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1067ui_story = arg_68_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).z)
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles = arg_68_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1067ui_story"].transform.position).z)
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1067ui_story"].transform.localEulerAngles = arg_68_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:AudioAction("play", "effect", "se_story_10", "se_story_10_cheer", "")
			end

			local var_71_2 = 0
			local var_71_3 = 0.675

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(113161017).content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 27 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 27)

				if (27 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_4) / 27)) > 0 and var_71_3 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_7 and arg_68_1.time_ < var_71_2 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play113161018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 113161018
		arg_72_1.duration_ = 7.3

		local var_72_0 = {
			ja = 7.3,
			ko = 3.833,
			zh = 3.866,
			en = 4.633
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play113161019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "1042ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1042ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["1042ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["1042ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["1042ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1042ui_story = var_75_3.localPosition
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_72_1.time_ - 0) / var_75_4)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_75_5 = arg_72_1.actors_["1042ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1042ui_story == nil then
				arg_72_1.var_.characterEffect1042ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.characterEffect1042ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1042ui_story then
				arg_72_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_75_8 = 0
			local var_75_9 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(113161018)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 19 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 19)

				if (19 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 19)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161018", "story_v_out_113161.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161018", "story_v_out_113161.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_113161", "113161018", "story_v_out_113161.awb")

						arg_72_1:RecordAudio("113161018", var_75_15)
						arg_72_1:RecordAudio("113161018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_113161", "113161018", "story_v_out_113161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_113161", "113161018", "story_v_out_113161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play113161019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 113161019
		arg_76_1.duration_ = 2.2

		local var_76_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.2,
			en = 1.999999999999
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play113161020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1067ui_story = arg_76_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).z)
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles = arg_76_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_76_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1067ui_story"].transform.position).z)
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1067ui_story"].transform.localEulerAngles = arg_76_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_79_1 = arg_76_1.actors_["1067ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1067ui_story == nil then
				arg_76_1.var_.characterEffect1067ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1067ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1067ui_story then
				arg_76_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_79_4 = arg_76_1.actors_["1042ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1042ui_story == nil then
				arg_76_1.var_.characterEffect1042ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_5 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 and not isNil(var_79_4) then
				if arg_76_1.var_.characterEffect1042ui_story and not isNil(var_79_4) then
					arg_76_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_5)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1042ui_story then
				arg_76_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_79_6 = 0
			local var_79_7 = 0.075

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(113161019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 3 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 3)

				if (3 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 3)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161019", "story_v_out_113161.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_113161", "113161019", "story_v_out_113161.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_113161", "113161019", "story_v_out_113161.awb")

						arg_76_1:RecordAudio("113161019", var_79_13)
						arg_76_1:RecordAudio("113161019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_113161", "113161019", "story_v_out_113161.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_113161", "113161019", "story_v_out_113161.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play113161020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 113161020
		arg_80_1.duration_ = 6.63

		local var_80_0 = {
			ja = 6.633,
			ko = 4.9,
			zh = 4.866,
			en = 6.633
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play113161021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_83_0 = arg_80_1.actors_["1042ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1042ui_story == nil then
				arg_80_1.var_.characterEffect1042ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_1 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 and not isNil(var_83_0) then
				if arg_80_1.var_.characterEffect1042ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1042ui_story then
				arg_80_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_83_3 = arg_80_1.actors_["1067ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1067ui_story == nil then
				arg_80_1.var_.characterEffect1067ui_story = var_83_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 and not isNil(var_83_3) then
				if arg_80_1.var_.characterEffect1067ui_story and not isNil(var_83_3) then
					arg_80_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_4)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1067ui_story then
				arg_80_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_83_5 = 0
			local var_83_6 = 0.575

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(113161020)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 23 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 23)

				if (23 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 23)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161020", "story_v_out_113161.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_113161", "113161020", "story_v_out_113161.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_113161", "113161020", "story_v_out_113161.awb")

						arg_80_1:RecordAudio("113161020", var_83_12)
						arg_80_1:RecordAudio("113161020", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_113161", "113161020", "story_v_out_113161.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_113161", "113161020", "story_v_out_113161.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play113161021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 113161021
		arg_84_1.duration_ = 6.13

		local var_84_0 = {
			ja = 5.2,
			ko = 5,
			zh = 5.133,
			en = 6.133
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play113161022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_87_0 = 0
			local var_87_1 = 0.65

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(113161021)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 26 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 26)

				if (26 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 26)) > 0 and var_87_1 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161021", "story_v_out_113161.awb") ~= 0 then
					local var_87_6 = manager.audio:GetVoiceLength("story_v_out_113161", "113161021", "story_v_out_113161.awb") / 1000

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end

					if var_87_2.prefab_name ~= "" and arg_84_1.actors_[var_87_2.prefab_name] ~= nil then
						local var_87_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_2.prefab_name].transform, "story_v_out_113161", "113161021", "story_v_out_113161.awb")

						arg_84_1:RecordAudio("113161021", var_87_7)
						arg_84_1:RecordAudio("113161021", var_87_7)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_113161", "113161021", "story_v_out_113161.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_113161", "113161021", "story_v_out_113161.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play113161022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 113161022
		arg_88_1.duration_ = 3.83

		local var_88_0 = {
			ja = 3.6,
			ko = 1.999999999999,
			zh = 3.833,
			en = 1.999999999999
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play113161023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1067ui_story"]) and arg_88_1.var_.characterEffect1067ui_story == nil then
				arg_88_1.var_.characterEffect1067ui_story = arg_88_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1067ui_story"]) then
				if arg_88_1.var_.characterEffect1067ui_story and not isNil(arg_88_1.actors_["1067ui_story"]) then
					arg_88_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1067ui_story"]) and arg_88_1.var_.characterEffect1067ui_story then
				arg_88_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_2 = arg_88_1.actors_["1042ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1042ui_story == nil then
				arg_88_1.var_.characterEffect1042ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1042ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1042ui_story then
				arg_88_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_91_4 = 0
			local var_91_5 = 0.175

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(113161022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 7 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 7)

				if (7 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 7)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161022", "story_v_out_113161.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161022", "story_v_out_113161.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_113161", "113161022", "story_v_out_113161.awb")

						arg_88_1:RecordAudio("113161022", var_91_11)
						arg_88_1:RecordAudio("113161022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_113161", "113161022", "story_v_out_113161.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_113161", "113161022", "story_v_out_113161.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play113161023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 113161023
		arg_92_1.duration_ = 4.17

		local var_92_0 = {
			ja = 4.166,
			ko = 2.166,
			zh = 2.833,
			en = 2.433
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play113161024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1067ui_story"]) and arg_92_1.var_.characterEffect1067ui_story == nil then
				arg_92_1.var_.characterEffect1067ui_story = arg_92_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1067ui_story"]) then
				if arg_92_1.var_.characterEffect1067ui_story and not isNil(arg_92_1.actors_["1067ui_story"]) then
					arg_92_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1067ui_story"]) and arg_92_1.var_.characterEffect1067ui_story then
				arg_92_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_95_1 = arg_92_1.actors_["1042ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1042ui_story == nil then
				arg_92_1.var_.characterEffect1042ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1042ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1042ui_story then
				arg_92_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_95_4 = 0
			local var_95_5 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(113161023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 9 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 9)

				if (9 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 9)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161023", "story_v_out_113161.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161023", "story_v_out_113161.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_113161", "113161023", "story_v_out_113161.awb")

						arg_92_1:RecordAudio("113161023", var_95_11)
						arg_92_1:RecordAudio("113161023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_113161", "113161023", "story_v_out_113161.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_113161", "113161023", "story_v_out_113161.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_5, arg_92_1.talkMaxDuration)

			if var_95_4 <= arg_92_1.time_ and arg_92_1.time_ < var_95_4 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_4) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_4 + var_95_12 and arg_92_1.time_ < var_95_4 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play113161024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 113161024
		arg_96_1.duration_ = 9

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play113161025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_0 = 2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				local var_99_1 = Color.New(0, 0, 0)

				var_99_1.a = Mathf.Lerp(0, 1, (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.mask_.color = var_99_1
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				local var_99_2 = Color.New(0, 0, 0)

				var_99_2.a = 1
				arg_96_1.mask_.color = var_99_2
			end

			local var_99_3 = 2

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_4 = 2

			if var_99_3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_3 + var_99_4 then
				local var_99_5 = Color.New(0, 0, 0)

				var_99_5.a = Mathf.Lerp(1, 0, (arg_96_1.time_ - var_99_3) / var_99_4)
				arg_96_1.mask_.color = var_99_5
			end

			if arg_96_1.time_ >= var_99_3 + var_99_4 and arg_96_1.time_ < var_99_3 + var_99_4 + arg_99_0 then
				local var_99_6 = Color.New(0, 0, 0)

				arg_96_1.mask_.enabled = false
				var_99_6.a = 0
				arg_96_1.mask_.color = var_99_6
			end

			local var_99_7 = arg_96_1.actors_["1042ui_story"].transform

			if 1.966 < arg_96_1.time_ and arg_96_1.time_ <= 1.966 + arg_99_0 then
				arg_96_1.var_.moveOldPos1042ui_story = var_99_7.localPosition
			end

			local var_99_8 = 0.001

			if 1.966 <= arg_96_1.time_ and arg_96_1.time_ < 1.966 + var_99_8 then
				var_99_7.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 1.966) / var_99_8)
				var_99_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_7.position).x, (manager.ui.mainCamera.transform.position - var_99_7.position).y, (manager.ui.mainCamera.transform.position - var_99_7.position).z)
				var_99_7.localEulerAngles.z = 0
				var_99_7.localEulerAngles.x = 0
				var_99_7.localEulerAngles = var_99_7.localEulerAngles
			end

			if arg_96_1.time_ >= 1.966 + var_99_8 and arg_96_1.time_ < 1.966 + var_99_8 + arg_99_0 then
				var_99_7.localPosition = Vector3.New(0, 100, 0)
				var_99_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_7.position).x, (manager.ui.mainCamera.transform.position - var_99_7.position).y, (manager.ui.mainCamera.transform.position - var_99_7.position).z)
				var_99_7.localEulerAngles.z = 0
				var_99_7.localEulerAngles.x = 0
				var_99_7.localEulerAngles = var_99_7.localEulerAngles
			end

			local var_99_9 = arg_96_1.actors_["1067ui_story"].transform

			if 1.966 < arg_96_1.time_ and arg_96_1.time_ <= 1.966 + arg_99_0 then
				arg_96_1.var_.moveOldPos1067ui_story = var_99_9.localPosition
			end

			local var_99_10 = 0.001

			if 1.966 <= arg_96_1.time_ and arg_96_1.time_ < 1.966 + var_99_10 then
				var_99_9.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 1.966) / var_99_10)
				var_99_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_9.position).x, (manager.ui.mainCamera.transform.position - var_99_9.position).y, (manager.ui.mainCamera.transform.position - var_99_9.position).z)
				var_99_9.localEulerAngles.z = 0
				var_99_9.localEulerAngles.x = 0
				var_99_9.localEulerAngles = var_99_9.localEulerAngles
			end

			if arg_96_1.time_ >= 1.966 + var_99_10 and arg_96_1.time_ < 1.966 + var_99_10 + arg_99_0 then
				var_99_9.localPosition = Vector3.New(0, 100, 0)
				var_99_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_9.position).x, (manager.ui.mainCamera.transform.position - var_99_9.position).y, (manager.ui.mainCamera.transform.position - var_99_9.position).z)
				var_99_9.localEulerAngles.z = 0
				var_99_9.localEulerAngles.x = 0
				var_99_9.localEulerAngles = var_99_9.localEulerAngles
			end

			local var_99_11 = "F03a"

			if arg_96_1.bgs_.F03a == nil then
				local var_99_12 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_11)
				var_99_12.name = var_99_11
				var_99_12.transform.parent = arg_96_1.stage_.transform
				var_99_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_11] = var_99_12
			end

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= 2 + arg_99_0 then
				local var_99_13 = arg_96_1.bgs_.F03a

				arg_96_1.bgs_.F03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_99_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_14 = var_99_13:GetComponent("SpriteRenderer")

				if var_99_14 and var_99_14.sprite then
					local var_99_15 = 2 * (var_99_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_99_13.transform.localScale = Vector3.New(var_99_15 / var_99_14.sprite.bounds.size.y < var_99_15 * manager.ui.mainCameraCom_.aspect / var_99_14.sprite.bounds.size.x and var_99_15 * manager.ui.mainCameraCom_.aspect / var_99_14.sprite.bounds.size.x or var_99_15 / var_99_14.sprite.bounds.size.y, var_99_15 / var_99_14.sprite.bounds.size.y < var_99_15 * manager.ui.mainCameraCom_.aspect / var_99_14.sprite.bounds.size.x and var_99_15 * manager.ui.mainCameraCom_.aspect / var_99_14.sprite.bounds.size.x or var_99_15 / var_99_14.sprite.bounds.size.y, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "F03a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_99_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_96_1.bgmTxt_.text ~= var_99_18 and arg_96_1.bgmTxt_.text ~= "" then
						if arg_96_1.bgmTxt2_.text ~= "" then
							arg_96_1.bgmTxt_.text = arg_96_1.bgmTxt2_.text
						end

						arg_96_1.bgmTxt2_.text = var_99_18

						arg_96_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_96_1.bgmTxt_.text = var_99_18
						arg_96_1.bgmTxt2_.text = var_99_18
					end

					if arg_96_1.bgmTimer then
						arg_96_1.bgmTimer:Stop()

						arg_96_1.bgmTimer = nil
					end

					if arg_96_1.settingData.show_music_name == 1 then
						arg_96_1.musicController:SetSelectedState("show")
						arg_96_1.musicAnimator_:Play("open", 0, 0)

						if arg_96_1.settingData.music_time ~= 0 then
							arg_96_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_96_1.settingData.music_time), function()
								if arg_96_1 == nil or isNil(arg_96_1.bgmTxt_) then
									return
								end

								arg_96_1.musicController:SetSelectedState("hide")
								arg_96_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_19 = 4
			local var_99_20 = 0.2

			if 4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_19 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_21 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_21:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_96_1.dialogCg_.alpha = arg_101_0
				end))
				var_99_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_22 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(113161024).content)

				arg_96_1.text_.text = var_99_22

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_24 = 8 <= 0 and var_99_20 or var_99_20 * (utf8.len(var_99_22) / 8)

				if (8 <= 0 and var_99_20 or var_99_20 * (utf8.len(var_99_22) / 8)) > 0 and var_99_20 < var_99_24 then
					arg_96_1.talkMaxDuration = var_99_24
					var_99_19 = var_99_19 + 0.3

					if var_99_24 + var_99_19 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_24 + var_99_19
					end
				end

				arg_96_1.text_.text = var_99_22
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = var_99_19 + 0.3
			local var_99_26 = math.max(var_99_20, arg_96_1.talkMaxDuration)

			if var_99_19 + 0.3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_25 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_25) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_25 + var_99_26 and arg_96_1.time_ < var_99_25 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play113161025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 113161025
		arg_103_1.duration_ = 3.23

		local var_103_0 = {
			ja = 3.233,
			ko = 1.233,
			zh = 3.166,
			en = 2.733
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play113161026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_106_2 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if "" ~= "" then
					if arg_103_1.bgmTxt_.text ~= var_106_2 and arg_103_1.bgmTxt_.text ~= "" then
						if arg_103_1.bgmTxt2_.text ~= "" then
							arg_103_1.bgmTxt_.text = arg_103_1.bgmTxt2_.text
						end

						arg_103_1.bgmTxt2_.text = var_106_2

						arg_103_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_103_1.bgmTxt_.text = var_106_2
						arg_103_1.bgmTxt2_.text = var_106_2
					end

					if arg_103_1.bgmTimer then
						arg_103_1.bgmTimer:Stop()

						arg_103_1.bgmTimer = nil
					end

					if arg_103_1.settingData.show_music_name == 1 then
						arg_103_1.musicController:SetSelectedState("show")
						arg_103_1.musicAnimator_:Play("open", 0, 0)

						if arg_103_1.settingData.music_time ~= 0 then
							arg_103_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_103_1.settingData.music_time), function()
								if arg_103_1 == nil or isNil(arg_103_1.bgmTxt_) then
									return
								end

								arg_103_1.musicController:SetSelectedState("hide")
								arg_103_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_106_3 = 0
			local var_106_4 = 0.2

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_5 = arg_103_1:GetWordFromCfg(113161025)
				local var_106_6 = arg_103_1:FormatText(var_106_5.content)

				arg_103_1.text_.text = var_106_6

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_8 = 8 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 8)

				if (8 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_6) / 8)) > 0 and var_106_4 < var_106_8 then
					arg_103_1.talkMaxDuration = var_106_8

					if var_106_8 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_6
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161025", "story_v_out_113161.awb") ~= 0 then
					local var_106_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161025", "story_v_out_113161.awb") / 1000

					if var_106_9 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_3
					end

					if var_106_5.prefab_name ~= "" and arg_103_1.actors_[var_106_5.prefab_name] ~= nil then
						local var_106_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_5.prefab_name].transform, "story_v_out_113161", "113161025", "story_v_out_113161.awb")

						arg_103_1:RecordAudio("113161025", var_106_10)
						arg_103_1:RecordAudio("113161025", var_106_10)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113161", "113161025", "story_v_out_113161.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113161", "113161025", "story_v_out_113161.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_11 and arg_103_1.time_ < var_106_3 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play113161026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 113161026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play113161027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.55

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(113161026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 22 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 22)

				if (22 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 22)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play113161027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 113161027
		arg_112_1.duration_ = 7.43

		local var_112_0 = {
			ja = 7.433,
			ko = 6.6,
			zh = 6.633,
			en = 6.6
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play113161028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_115_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_112_1.stage_.transform)

				var_115_0.name = "1041ui_story"
				var_115_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1041ui_story"] = var_115_0

				local var_115_1 = var_115_0:GetComponentInChildren(typeof(CharacterEffect))

				var_115_1.enabled = true

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end

				arg_112_1:ShowWeapon(var_115_1.transform, false)

				arg_112_1.var_["1041ui_story" .. "Animator"] = var_115_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_112_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_112_1.var_["1041ui_story" .. "LipSync"] = var_115_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_115_3 = arg_112_1.actors_["1041ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1041ui_story = var_115_3.localPosition
			end

			local var_115_4 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				var_115_3.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_112_1.time_ - 0) / var_115_4)
				var_115_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_3.position).x, (manager.ui.mainCamera.transform.position - var_115_3.position).y, (manager.ui.mainCamera.transform.position - var_115_3.position).z)
				var_115_3.localEulerAngles.z = 0
				var_115_3.localEulerAngles.x = 0
				var_115_3.localEulerAngles = var_115_3.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				var_115_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_115_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_3.position).x, (manager.ui.mainCamera.transform.position - var_115_3.position).y, (manager.ui.mainCamera.transform.position - var_115_3.position).z)
				var_115_3.localEulerAngles.z = 0
				var_115_3.localEulerAngles.x = 0
				var_115_3.localEulerAngles = var_115_3.localEulerAngles
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_5 = arg_112_1.actors_["1041ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect1041ui_story == nil then
				arg_112_1.var_.characterEffect1041ui_story = var_115_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_6 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_6 and not isNil(var_115_5) then
				if arg_112_1.var_.characterEffect1041ui_story and not isNil(var_115_5) then
					arg_112_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_6 and arg_112_1.time_ < 0 + var_115_6 + arg_115_0 and not isNil(var_115_5) and arg_112_1.var_.characterEffect1041ui_story then
				arg_112_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_115_8 = 0
			local var_115_9 = 0.775

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(113161027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 31 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 31)

				if (31 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 31)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161027", "story_v_out_113161.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_113161", "113161027", "story_v_out_113161.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_113161", "113161027", "story_v_out_113161.awb")

						arg_112_1:RecordAudio("113161027", var_115_15)
						arg_112_1:RecordAudio("113161027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_113161", "113161027", "story_v_out_113161.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_113161", "113161027", "story_v_out_113161.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play113161028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 113161028
		arg_116_1.duration_ = 6.67

		local var_116_0 = {
			ja = 6.666,
			ko = 4.5,
			zh = 5,
			en = 4.2
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play113161029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1041ui_story"]) and arg_116_1.var_.characterEffect1041ui_story == nil then
				arg_116_1.var_.characterEffect1041ui_story = arg_116_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1041ui_story"]) then
				if arg_116_1.var_.characterEffect1041ui_story and not isNil(arg_116_1.actors_["1041ui_story"]) then
					arg_116_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1041ui_story"]) and arg_116_1.var_.characterEffect1041ui_story then
				arg_116_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_119_1 = "10006ui_story"

			if arg_116_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_119_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_116_1.stage_.transform)

				var_119_2.name = var_119_1
				var_119_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_[var_119_1] = var_119_2

				local var_119_3 = var_119_2:GetComponentInChildren(typeof(CharacterEffect))

				var_119_3.enabled = true

				local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_2, typeof(DynamicBoneHelper))

				if var_119_4 then
					var_119_4:EnableDynamicBone(false)
				end

				arg_116_1:ShowWeapon(var_119_3.transform, false)

				arg_116_1.var_[var_119_1 .. "Animator"] = var_119_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_116_1.var_[var_119_1 .. "Animator"].applyRootMotion = true
				arg_116_1.var_[var_119_1 .. "LipSync"] = var_119_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_119_5 = arg_116_1.actors_["10006ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10006ui_story = var_119_5.localPosition
			end

			local var_119_6 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_6 then
				var_119_5.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_116_1.time_ - 0) / var_119_6)
				var_119_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_5.position).x, (manager.ui.mainCamera.transform.position - var_119_5.position).y, (manager.ui.mainCamera.transform.position - var_119_5.position).z)
				var_119_5.localEulerAngles.z = 0
				var_119_5.localEulerAngles.x = 0
				var_119_5.localEulerAngles = var_119_5.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_6 and arg_116_1.time_ < 0 + var_119_6 + arg_119_0 then
				var_119_5.localPosition = Vector3.New(0.7, -0.98, -5.65)
				var_119_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_5.position).x, (manager.ui.mainCamera.transform.position - var_119_5.position).y, (manager.ui.mainCamera.transform.position - var_119_5.position).z)
				var_119_5.localEulerAngles.z = 0
				var_119_5.localEulerAngles.x = 0
				var_119_5.localEulerAngles = var_119_5.localEulerAngles
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_119_7 = arg_116_1.actors_["10006ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.characterEffect10006ui_story == nil then
				arg_116_1.var_.characterEffect10006ui_story = var_119_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_8 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_8 and not isNil(var_119_7) then
				if arg_116_1.var_.characterEffect10006ui_story and not isNil(var_119_7) then
					arg_116_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_8 and arg_116_1.time_ < 0 + var_119_8 + arg_119_0 and not isNil(var_119_7) and arg_116_1.var_.characterEffect10006ui_story then
				arg_116_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_119_10 = 0
			local var_119_11 = 0.45

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_12 = arg_116_1:GetWordFromCfg(113161028)
				local var_119_13 = arg_116_1:FormatText(var_119_12.content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 18 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 18)

				if (18 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 18)) > 0 and var_119_11 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_10
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161028", "story_v_out_113161.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_113161", "113161028", "story_v_out_113161.awb") / 1000

					if var_119_16 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_10
					end

					if var_119_12.prefab_name ~= "" and arg_116_1.actors_[var_119_12.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_12.prefab_name].transform, "story_v_out_113161", "113161028", "story_v_out_113161.awb")

						arg_116_1:RecordAudio("113161028", var_119_17)
						arg_116_1:RecordAudio("113161028", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_113161", "113161028", "story_v_out_113161.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_113161", "113161028", "story_v_out_113161.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_11, arg_116_1.talkMaxDuration)

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_10) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_10 + var_119_18 and arg_116_1.time_ < var_119_10 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play113161029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 113161029
		arg_120_1.duration_ = 5.1

		local var_120_0 = {
			ja = 4.8,
			ko = 3.666,
			zh = 4,
			en = 5.1
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play113161030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10006ui_story"]) and arg_120_1.var_.characterEffect10006ui_story == nil then
				arg_120_1.var_.characterEffect10006ui_story = arg_120_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10006ui_story"]) then
				if arg_120_1.var_.characterEffect10006ui_story and not isNil(arg_120_1.actors_["10006ui_story"]) then
					arg_120_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10006ui_story"]) and arg_120_1.var_.characterEffect10006ui_story then
				arg_120_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action7_2")
			end

			local var_123_1 = 0
			local var_123_2 = 0.525

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(113161029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_6 = 21 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_4) / 21)

				if (21 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_4) / 21)) > 0 and var_123_2 < var_123_6 then
					arg_120_1.talkMaxDuration = var_123_6

					if var_123_6 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_6 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161029", "story_v_out_113161.awb") ~= 0 then
					local var_123_7 = manager.audio:GetVoiceLength("story_v_out_113161", "113161029", "story_v_out_113161.awb") / 1000

					if var_123_7 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_1
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_113161", "113161029", "story_v_out_113161.awb")

						arg_120_1:RecordAudio("113161029", var_123_8)
						arg_120_1:RecordAudio("113161029", var_123_8)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_113161", "113161029", "story_v_out_113161.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_113161", "113161029", "story_v_out_113161.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_9 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_9 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_9

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_9 and arg_120_1.time_ < var_123_1 + var_123_9 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play113161030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 113161030
		arg_124_1.duration_ = 4.23

		local var_124_0 = {
			ja = 4.233,
			ko = 1.633,
			zh = 2.333,
			en = 3.7
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play113161031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.275

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(113161030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 11 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 11)

				if (11 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 11)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161030", "story_v_out_113161.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161030", "story_v_out_113161.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_113161", "113161030", "story_v_out_113161.awb")

						arg_124_1:RecordAudio("113161030", var_127_6)
						arg_124_1:RecordAudio("113161030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_113161", "113161030", "story_v_out_113161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_113161", "113161030", "story_v_out_113161.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play113161031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 113161031
		arg_128_1.duration_ = 3.63

		local var_128_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play113161032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_131_0 = arg_128_1.actors_["10006ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10006ui_story == nil then
				arg_128_1.var_.characterEffect10006ui_story = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_1 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 and not isNil(var_131_0) then
				if arg_128_1.var_.characterEffect10006ui_story and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect10006ui_story then
				arg_128_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_131_3 = 0
			local var_131_4 = 0.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_5 = arg_128_1:GetWordFromCfg(113161031)
				local var_131_6 = arg_128_1:FormatText(var_131_5.content)

				arg_128_1.text_.text = var_131_6

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_8 = 7 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_6) / 7)

				if (7 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_6) / 7)) > 0 and var_131_4 < var_131_8 then
					arg_128_1.talkMaxDuration = var_131_8

					if var_131_8 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_3
					end
				end

				arg_128_1.text_.text = var_131_6
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161031", "story_v_out_113161.awb") ~= 0 then
					local var_131_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161031", "story_v_out_113161.awb") / 1000

					if var_131_9 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_3
					end

					if var_131_5.prefab_name ~= "" and arg_128_1.actors_[var_131_5.prefab_name] ~= nil then
						local var_131_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_5.prefab_name].transform, "story_v_out_113161", "113161031", "story_v_out_113161.awb")

						arg_128_1:RecordAudio("113161031", var_131_10)
						arg_128_1:RecordAudio("113161031", var_131_10)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_113161", "113161031", "story_v_out_113161.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_113161", "113161031", "story_v_out_113161.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_4, arg_128_1.talkMaxDuration)

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_3) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_3 + var_131_11 and arg_128_1.time_ < var_131_3 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play113161032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 113161032
		arg_132_1.duration_ = 8.8

		local var_132_0 = {
			ja = 8.8,
			ko = 3.5,
			zh = 3.033,
			en = 3.666
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play113161033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10006ui_story"]) and arg_132_1.var_.characterEffect10006ui_story == nil then
				arg_132_1.var_.characterEffect10006ui_story = arg_132_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10006ui_story"]) then
				if arg_132_1.var_.characterEffect10006ui_story and not isNil(arg_132_1.actors_["10006ui_story"]) then
					arg_132_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10006ui_story"]) and arg_132_1.var_.characterEffect10006ui_story then
				arg_132_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.45

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(113161032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 17 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 17)

				if (17 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 17)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161032", "story_v_out_113161.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_113161", "113161032", "story_v_out_113161.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_113161", "113161032", "story_v_out_113161.awb")

						arg_132_1:RecordAudio("113161032", var_135_8)
						arg_132_1:RecordAudio("113161032", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_113161", "113161032", "story_v_out_113161.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_113161", "113161032", "story_v_out_113161.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play113161033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 113161033
		arg_136_1.duration_ = 5.33

		local var_136_0 = {
			ja = 5.333,
			ko = 3.8,
			zh = 3.366,
			en = 2.2
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play113161034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10006ui_story"]) and arg_136_1.var_.characterEffect10006ui_story == nil then
				arg_136_1.var_.characterEffect10006ui_story = arg_136_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10006ui_story"]) then
				if arg_136_1.var_.characterEffect10006ui_story and not isNil(arg_136_1.actors_["10006ui_story"]) then
					arg_136_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10006ui_story"]) and arg_136_1.var_.characterEffect10006ui_story then
				arg_136_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_139_2 = 0
			local var_139_3 = 0.375

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(113161033)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 15 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 15)

				if (15 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 15)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161033", "story_v_out_113161.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161033", "story_v_out_113161.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_out_113161", "113161033", "story_v_out_113161.awb")

						arg_136_1:RecordAudio("113161033", var_139_9)
						arg_136_1:RecordAudio("113161033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_113161", "113161033", "story_v_out_113161.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_113161", "113161033", "story_v_out_113161.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play113161034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 113161034
		arg_140_1.duration_ = 12.13

		local var_140_0 = {
			ja = 12.133,
			ko = 7.466,
			zh = 8.1,
			en = 10.566
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play113161035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10006ui_story"]) and arg_140_1.var_.characterEffect10006ui_story == nil then
				arg_140_1.var_.characterEffect10006ui_story = arg_140_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10006ui_story"]) then
				if arg_140_1.var_.characterEffect10006ui_story and not isNil(arg_140_1.actors_["10006ui_story"]) then
					arg_140_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10006ui_story"]) and arg_140_1.var_.characterEffect10006ui_story then
				arg_140_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 1

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(113161034)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 40 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 40)

				if (40 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 40)) > 0 and var_143_2 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161034", "story_v_out_113161.awb") ~= 0 then
					local var_143_7 = manager.audio:GetVoiceLength("story_v_out_113161", "113161034", "story_v_out_113161.awb") / 1000

					if var_143_7 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_1
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_113161", "113161034", "story_v_out_113161.awb")

						arg_140_1:RecordAudio("113161034", var_143_8)
						arg_140_1:RecordAudio("113161034", var_143_8)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_113161", "113161034", "story_v_out_113161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_113161", "113161034", "story_v_out_113161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_9 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_9 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_9

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_9 and arg_140_1.time_ < var_143_1 + var_143_9 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play113161035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 113161035
		arg_144_1.duration_ = 3.67

		local var_144_0 = {
			ja = 3.033,
			ko = 3.666,
			zh = 2.933,
			en = 1.833
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play113161036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10006ui_story"]) and arg_144_1.var_.characterEffect10006ui_story == nil then
				arg_144_1.var_.characterEffect10006ui_story = arg_144_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10006ui_story"]) then
				if arg_144_1.var_.characterEffect10006ui_story and not isNil(arg_144_1.actors_["10006ui_story"]) then
					arg_144_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10006ui_story"]) and arg_144_1.var_.characterEffect10006ui_story then
				arg_144_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_147_2 = 0
			local var_147_3 = 0.3

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(113161035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)

				if (12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161035", "story_v_out_113161.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_113161", "113161035", "story_v_out_113161.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_113161", "113161035", "story_v_out_113161.awb")

						arg_144_1:RecordAudio("113161035", var_147_9)
						arg_144_1:RecordAudio("113161035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_113161", "113161035", "story_v_out_113161.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_113161", "113161035", "story_v_out_113161.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play113161036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 113161036
		arg_148_1.duration_ = 9.57

		local var_148_0 = {
			ja = 9.566,
			ko = 5.833,
			zh = 5.6,
			en = 6.333
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play113161037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10006ui_story"]) and arg_148_1.var_.characterEffect10006ui_story == nil then
				arg_148_1.var_.characterEffect10006ui_story = arg_148_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10006ui_story"]) then
				if arg_148_1.var_.characterEffect10006ui_story and not isNil(arg_148_1.actors_["10006ui_story"]) then
					arg_148_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10006ui_story"]) and arg_148_1.var_.characterEffect10006ui_story then
				arg_148_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_151_1 = 0
			local var_151_2 = 0.825

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(113161036)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 33 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 33)

				if (33 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_4) / 33)) > 0 and var_151_2 < var_151_6 then
					arg_148_1.talkMaxDuration = var_151_6

					if var_151_6 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161036", "story_v_out_113161.awb") ~= 0 then
					local var_151_7 = manager.audio:GetVoiceLength("story_v_out_113161", "113161036", "story_v_out_113161.awb") / 1000

					if var_151_7 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_1
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_113161", "113161036", "story_v_out_113161.awb")

						arg_148_1:RecordAudio("113161036", var_151_8)
						arg_148_1:RecordAudio("113161036", var_151_8)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_113161", "113161036", "story_v_out_113161.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_113161", "113161036", "story_v_out_113161.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_9 and arg_148_1.time_ < var_151_1 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play113161037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 113161037
		arg_152_1.duration_ = 7.8

		local var_152_0 = {
			ja = 6.966,
			ko = 5.4,
			zh = 5.866,
			en = 7.8
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play113161038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.875

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(113161037)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 35 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 35)

				if (35 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 35)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161037", "story_v_out_113161.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161037", "story_v_out_113161.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_113161", "113161037", "story_v_out_113161.awb")

						arg_152_1:RecordAudio("113161037", var_155_6)
						arg_152_1:RecordAudio("113161037", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_113161", "113161037", "story_v_out_113161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_113161", "113161037", "story_v_out_113161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play113161038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 113161038
		arg_156_1.duration_ = 2.7

		local var_156_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.1
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play113161039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_159_0 = arg_156_1.actors_["1041ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1041ui_story == nil then
				arg_156_1.var_.characterEffect1041ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_1 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 and not isNil(var_159_0) then
				if arg_156_1.var_.characterEffect1041ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1041ui_story then
				arg_156_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_159_3 = 0
			local var_159_4 = 0.125

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:GetWordFromCfg(113161038)
				local var_159_6 = arg_156_1:FormatText(var_159_5.content)

				arg_156_1.text_.text = var_159_6

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_8 = 5 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_6) / 5)

				if (5 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_6) / 5)) > 0 and var_159_4 < var_159_8 then
					arg_156_1.talkMaxDuration = var_159_8

					if var_159_8 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_3
					end
				end

				arg_156_1.text_.text = var_159_6
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161038", "story_v_out_113161.awb") ~= 0 then
					local var_159_9 = manager.audio:GetVoiceLength("story_v_out_113161", "113161038", "story_v_out_113161.awb") / 1000

					if var_159_9 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_3
					end

					if var_159_5.prefab_name ~= "" and arg_156_1.actors_[var_159_5.prefab_name] ~= nil then
						local var_159_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_5.prefab_name].transform, "story_v_out_113161", "113161038", "story_v_out_113161.awb")

						arg_156_1:RecordAudio("113161038", var_159_10)
						arg_156_1:RecordAudio("113161038", var_159_10)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_113161", "113161038", "story_v_out_113161.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_113161", "113161038", "story_v_out_113161.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_4, arg_156_1.talkMaxDuration)

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_3) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_3 + var_159_11 and arg_156_1.time_ < var_159_3 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play113161039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 113161039
		arg_160_1.duration_ = 9.9

		local var_160_0 = {
			ja = 9.9,
			ko = 6.766,
			zh = 6.733,
			en = 8.5
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play113161040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10006ui_story = arg_160_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).z)
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles = arg_160_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["10006ui_story"].transform.position).z)
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["10006ui_story"].transform.localEulerAngles = arg_160_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["1041ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1041ui_story = var_163_1.localPosition
			end

			local var_163_2 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_2)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0, 100, 0)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			local var_163_3 = arg_160_1.bgs_.F03a.transform

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				arg_160_1.var_.shakeOldPosF03a = var_163_3.localPosition
			end

			local var_163_4 = 1

			if 2 <= arg_160_1.time_ and arg_160_1.time_ < 2 + var_163_4 then
				local var_163_5, var_163_6 = math.modf((arg_160_1.time_ - 2) / 0.066)

				var_163_3.localPosition = Vector3.New(var_163_6 * 0.1, var_163_6 * 0.1, var_163_6 * 0) + arg_160_1.var_.shakeOldPosF03a
			end

			if arg_160_1.time_ >= 2 + var_163_4 and arg_160_1.time_ < 2 + var_163_4 + arg_163_0 then
				var_163_3.localPosition = arg_160_1.var_.shakeOldPosF03a
			end

			local var_163_7 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_7 + 1 and arg_160_1.time_ < var_163_7 + 1 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_8 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_9 = 2

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_9 then
				local var_163_10 = Color.New(1, 1, 1)

				var_163_10.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_8) / var_163_9)
				arg_160_1.mask_.color = var_163_10
			end

			if arg_160_1.time_ >= var_163_8 + var_163_9 and arg_160_1.time_ < var_163_8 + var_163_9 + arg_163_0 then
				local var_163_11 = Color.New(1, 1, 1)

				arg_160_1.mask_.enabled = false
				var_163_11.a = 0
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_12 = 2
			local var_163_13 = 0.375

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_14 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_14:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_15 = arg_160_1:GetWordFromCfg(113161039)
				local var_163_16 = arg_160_1:FormatText(var_163_15.content)

				arg_160_1.text_.text = var_163_16

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_18 = 15 <= 0 and var_163_13 or var_163_13 * (utf8.len(var_163_16) / 15)

				if (15 <= 0 and var_163_13 or var_163_13 * (utf8.len(var_163_16) / 15)) > 0 and var_163_13 < var_163_18 then
					arg_160_1.talkMaxDuration = var_163_18
					var_163_12 = var_163_12 + 0.3

					if var_163_18 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_12
					end
				end

				arg_160_1.text_.text = var_163_16
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161039", "story_v_out_113161.awb") ~= 0 then
					local var_163_19 = manager.audio:GetVoiceLength("story_v_out_113161", "113161039", "story_v_out_113161.awb") / 1000

					if var_163_19 + var_163_12 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_12
					end

					if var_163_15.prefab_name ~= "" and arg_160_1.actors_[var_163_15.prefab_name] ~= nil then
						local var_163_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_15.prefab_name].transform, "story_v_out_113161", "113161039", "story_v_out_113161.awb")

						arg_160_1:RecordAudio("113161039", var_163_20)
						arg_160_1:RecordAudio("113161039", var_163_20)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113161", "113161039", "story_v_out_113161.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113161", "113161039", "story_v_out_113161.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_21 = var_163_12 + 0.3
			local var_163_22 = math.max(var_163_13, arg_160_1.talkMaxDuration)

			if var_163_12 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_21 + var_163_22 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_21) / var_163_22

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_21 + var_163_22 and arg_160_1.time_ < var_163_21 + var_163_22 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play113161040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 113161040
		arg_166_1.duration_ = 3.5

		local var_166_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 2.8,
			en = 3.5
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play113161041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.actors_["10006_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10006_tpose"))) then
				local var_169_0 = Object.Instantiate(Asset.Load("Char/" .. "10006_tpose"), arg_166_1.stage_.transform)

				var_169_0.name = "10006_tpose"
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["10006_tpose"] = var_169_0

				local var_169_1 = var_169_0:GetComponentInChildren(typeof(CharacterEffect))

				var_169_1.enabled = true

				local var_169_2 = GameObjectTools.GetOrAddComponent(var_169_0, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(false)
				end

				arg_166_1:ShowWeapon(var_169_1.transform, false)

				arg_166_1.var_["10006_tpose" .. "Animator"] = var_169_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_166_1.var_["10006_tpose" .. "Animator"].applyRootMotion = true
				arg_166_1.var_["10006_tpose" .. "LipSync"] = var_169_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_169_3 = arg_166_1.actors_["10006_tpose"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect10006_tpose == nil then
				arg_166_1.var_.characterEffect10006_tpose = var_169_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_4 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 and not isNil(var_169_3) then
				if arg_166_1.var_.characterEffect10006_tpose and not isNil(var_169_3) then
					arg_166_1.var_.characterEffect10006_tpose.fillFlat = true
					arg_166_1.var_.characterEffect10006_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_4)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect10006_tpose then
				arg_166_1.var_.characterEffect10006_tpose.fillFlat = true
				arg_166_1.var_.characterEffect10006_tpose.fillRatio = 0.5
			end

			local var_169_5 = arg_166_1.actors_["1041ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1041ui_story == nil then
				arg_166_1.var_.characterEffect1041ui_story = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 and not isNil(var_169_5) then
				if arg_166_1.var_.characterEffect1041ui_story and not isNil(var_169_5) then
					arg_166_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1041ui_story then
				arg_166_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_169_8 = arg_166_1.actors_["1041ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1041ui_story = var_169_8.localPosition
			end

			local var_169_9 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_9 then
				var_169_8.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_166_1.time_ - 0) / var_169_9)
				var_169_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_8.position).x, (manager.ui.mainCamera.transform.position - var_169_8.position).y, (manager.ui.mainCamera.transform.position - var_169_8.position).z)
				var_169_8.localEulerAngles.z = 0
				var_169_8.localEulerAngles.x = 0
				var_169_8.localEulerAngles = var_169_8.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_9 and arg_166_1.time_ < 0 + var_169_9 + arg_169_0 then
				var_169_8.localPosition = Vector3.New(0, -1.11, -5.9)
				var_169_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_8.position).x, (manager.ui.mainCamera.transform.position - var_169_8.position).y, (manager.ui.mainCamera.transform.position - var_169_8.position).z)
				var_169_8.localEulerAngles.z = 0
				var_169_8.localEulerAngles.x = 0
				var_169_8.localEulerAngles = var_169_8.localEulerAngles
			end

			local var_169_10 = 0
			local var_169_11 = 0.2

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_12 = arg_166_1:GetWordFromCfg(113161040)
				local var_169_13 = arg_166_1:FormatText(var_169_12.content)

				arg_166_1.text_.text = var_169_13

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 8 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 8)

				if (8 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 8)) > 0 and var_169_11 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15

					if var_169_15 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_13
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161040", "story_v_out_113161.awb") ~= 0 then
					local var_169_16 = manager.audio:GetVoiceLength("story_v_out_113161", "113161040", "story_v_out_113161.awb") / 1000

					if var_169_16 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_16 + var_169_10
					end

					if var_169_12.prefab_name ~= "" and arg_166_1.actors_[var_169_12.prefab_name] ~= nil then
						local var_169_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_12.prefab_name].transform, "story_v_out_113161", "113161040", "story_v_out_113161.awb")

						arg_166_1:RecordAudio("113161040", var_169_17)
						arg_166_1:RecordAudio("113161040", var_169_17)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_113161", "113161040", "story_v_out_113161.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_113161", "113161040", "story_v_out_113161.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_18 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_18 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_10) / var_169_18

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_10 + var_169_18 and arg_166_1.time_ < var_169_10 + var_169_18 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play113161041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 113161041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play113161042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1041ui_story = arg_170_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).z)
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles = arg_170_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1041ui_story"].transform.position).z)
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1041ui_story"].transform.localEulerAngles = arg_170_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_173_1 = 0
			local var_173_2 = 1.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(113161041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 42 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 42)

				if (42 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 42)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play113161042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 113161042
		arg_174_1.duration_ = 13.9

		local var_174_0 = {
			ja = 13.9,
			ko = 7.9,
			zh = 6.933,
			en = 8.066
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play113161043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.625

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:GetWordFromCfg(113161042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 25 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 25)

				if (25 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 25)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161042", "story_v_out_113161.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161042", "story_v_out_113161.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_113161", "113161042", "story_v_out_113161.awb")

						arg_174_1:RecordAudio("113161042", var_177_6)
						arg_174_1:RecordAudio("113161042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_113161", "113161042", "story_v_out_113161.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_113161", "113161042", "story_v_out_113161.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play113161043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 113161043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play113161044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:AudioAction("play", "effect", "se_story_10", "se_story_10_fog", "")
			end

			local var_181_1 = 0
			local var_181_2 = 0.8

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(113161043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 32 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 32)

				if (32 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 32)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play113161044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 113161044
		arg_182_1.duration_ = 4.33

		local var_182_0 = {
			ja = 4.333,
			ko = 1.999999999999,
			zh = 2.866,
			en = 1.999999999999
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play113161045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1041ui_story = arg_182_1.actors_["1041ui_story"].transform.localPosition

				arg_182_1:ShowWeapon(arg_182_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).z)
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles = arg_182_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_182_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1041ui_story"].transform.position).z)
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1041ui_story"].transform.localEulerAngles = arg_182_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_185_1 = arg_182_1.actors_["1041ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1041ui_story == nil then
				arg_182_1.var_.characterEffect1041ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1041ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1041ui_story then
				arg_182_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_185_4 = 0
			local var_185_5 = 0.1

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(113161044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 4 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 4)

				if (4 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 4)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161044", "story_v_out_113161.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_113161", "113161044", "story_v_out_113161.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_113161", "113161044", "story_v_out_113161.awb")

						arg_182_1:RecordAudio("113161044", var_185_11)
						arg_182_1:RecordAudio("113161044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_113161", "113161044", "story_v_out_113161.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_113161", "113161044", "story_v_out_113161.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play113161045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 113161045
		arg_186_1.duration_ = 9

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play113161046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_0 = 2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				local var_189_1 = Color.New(0, 0, 0)

				var_189_1.a = Mathf.Lerp(0, 1, (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.mask_.color = var_189_1
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				local var_189_2 = Color.New(0, 0, 0)

				var_189_2.a = 1
				arg_186_1.mask_.color = var_189_2
			end

			local var_189_3 = 2

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 then
				arg_186_1.mask_.enabled = true
				arg_186_1.mask_.raycastTarget = true

				arg_186_1:SetGaussion(false)
			end

			local var_189_4 = 2

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_4 then
				local var_189_5 = Color.New(0, 0, 0)

				var_189_5.a = Mathf.Lerp(1, 0, (arg_186_1.time_ - var_189_3) / var_189_4)
				arg_186_1.mask_.color = var_189_5
			end

			if arg_186_1.time_ >= var_189_3 + var_189_4 and arg_186_1.time_ < var_189_3 + var_189_4 + arg_189_0 then
				local var_189_6 = Color.New(0, 0, 0)

				arg_186_1.mask_.enabled = false
				var_189_6.a = 0
				arg_186_1.mask_.color = var_189_6
			end

			local var_189_7 = "OM0103"

			if arg_186_1.bgs_.OM0103 == nil then
				local var_189_8 = Object.Instantiate(arg_186_1.paintGo_)

				var_189_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_189_7)
				var_189_8.name = var_189_7
				var_189_8.transform.parent = arg_186_1.stage_.transform
				var_189_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.bgs_[var_189_7] = var_189_8
			end

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				local var_189_9 = arg_186_1.bgs_.OM0103

				arg_186_1.bgs_.OM0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_189_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_189_10 = var_189_9:GetComponent("SpriteRenderer")

				if var_189_10 and var_189_10.sprite then
					local var_189_11 = 2 * (var_189_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_189_9.transform.localScale = Vector3.New(var_189_11 / var_189_10.sprite.bounds.size.y < var_189_11 * manager.ui.mainCameraCom_.aspect / var_189_10.sprite.bounds.size.x and var_189_11 * manager.ui.mainCameraCom_.aspect / var_189_10.sprite.bounds.size.x or var_189_11 / var_189_10.sprite.bounds.size.y, var_189_11 / var_189_10.sprite.bounds.size.y < var_189_11 * manager.ui.mainCameraCom_.aspect / var_189_10.sprite.bounds.size.x and var_189_11 * manager.ui.mainCameraCom_.aspect / var_189_10.sprite.bounds.size.x or var_189_11 / var_189_10.sprite.bounds.size.y, 0)
				end

				for iter_189_0, iter_189_1 in pairs(arg_186_1.bgs_) do
					if iter_189_0 ~= "OM0103" then
						iter_189_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_189_12 = arg_186_1.actors_["1041ui_story"].transform

			if 1.966 < arg_186_1.time_ and arg_186_1.time_ <= 1.966 + arg_189_0 then
				arg_186_1.var_.moveOldPos1041ui_story = var_189_12.localPosition

				arg_186_1:ShowWeapon(arg_186_1.var_["1041ui_story" .. "Animator"].transform, false)
			end

			local var_189_13 = 0.001

			if 1.966 <= arg_186_1.time_ and arg_186_1.time_ < 1.966 + var_189_13 then
				var_189_12.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 1.966) / var_189_13)
				var_189_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_12.position).x, (manager.ui.mainCamera.transform.position - var_189_12.position).y, (manager.ui.mainCamera.transform.position - var_189_12.position).z)
				var_189_12.localEulerAngles.z = 0
				var_189_12.localEulerAngles.x = 0
				var_189_12.localEulerAngles = var_189_12.localEulerAngles
			end

			if arg_186_1.time_ >= 1.966 + var_189_13 and arg_186_1.time_ < 1.966 + var_189_13 + arg_189_0 then
				var_189_12.localPosition = Vector3.New(0, 100, 0)
				var_189_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_12.position).x, (manager.ui.mainCamera.transform.position - var_189_12.position).y, (manager.ui.mainCamera.transform.position - var_189_12.position).z)
				var_189_12.localEulerAngles.z = 0
				var_189_12.localEulerAngles.x = 0
				var_189_12.localEulerAngles = var_189_12.localEulerAngles
			end

			local var_189_14 = arg_186_1.bgs_.OM0103.transform

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= 2 + arg_189_0 then
				arg_186_1.var_.moveOldPosOM0103 = var_189_14.localPosition
			end

			local var_189_15 = 0.001

			if 2 <= arg_186_1.time_ and arg_186_1.time_ < 2 + var_189_15 then
				var_189_14.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPosOM0103, Vector3.New(-1.6, 0.5, 1.01), (arg_186_1.time_ - 2) / var_189_15)
			end

			if arg_186_1.time_ >= 2 + var_189_15 and arg_186_1.time_ < 2 + var_189_15 + arg_189_0 then
				var_189_14.localPosition = Vector3.New(-1.6, 0.5, 1.01)
			end

			local var_189_16 = arg_186_1.bgs_.OM0103.transform

			if 2.01666666666667 < arg_186_1.time_ and arg_186_1.time_ <= 2.01666666666667 + arg_189_0 then
				arg_186_1.var_.moveOldPosOM0103 = var_189_16.localPosition
			end

			local var_189_17 = 4

			if 2.01666666666667 <= arg_186_1.time_ and arg_186_1.time_ < 2.01666666666667 + var_189_17 then
				var_189_16.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPosOM0103, Vector3.New(-1.6, 0.2, 1.01), (arg_186_1.time_ - 2.01666666666667) / var_189_17)
			end

			if arg_186_1.time_ >= 2.01666666666667 + var_189_17 and arg_186_1.time_ < 2.01666666666667 + var_189_17 + arg_189_0 then
				var_189_16.localPosition = Vector3.New(-1.6, 0.2, 1.01)
			end

			local var_189_18 = 2

			if 2 < arg_186_1.time_ and arg_186_1.time_ <= var_189_18 + arg_189_0 then
				arg_186_1.allBtn_.enabled = false
			end

			if arg_186_1.time_ >= var_189_18 + 4.01666666666667 and arg_186_1.time_ < var_189_18 + 4.01666666666667 + arg_189_0 then
				arg_186_1.allBtn_.enabled = true
			end

			if arg_186_1.frameCnt_ <= 1 then
				arg_186_1.dialog_:SetActive(false)
			end

			local var_189_19 = 4
			local var_189_20 = 1.025

			if 4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_19 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_21 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_21:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_22 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(113161045).content)

				arg_186_1.text_.text = var_189_22

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_24 = 41 <= 0 and var_189_20 or var_189_20 * (utf8.len(var_189_22) / 41)

				if (41 <= 0 and var_189_20 or var_189_20 * (utf8.len(var_189_22) / 41)) > 0 and var_189_20 < var_189_24 then
					arg_186_1.talkMaxDuration = var_189_24
					var_189_19 = var_189_19 + 0.3

					if var_189_24 + var_189_19 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_24 + var_189_19
					end
				end

				arg_186_1.text_.text = var_189_22
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_25 = var_189_19 + 0.3
			local var_189_26 = math.max(var_189_20, arg_186_1.talkMaxDuration)

			if var_189_19 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_25 + var_189_26 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_25) / var_189_26

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_25 + var_189_26 and arg_186_1.time_ < var_189_25 + var_189_26 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play113161046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 113161046
		arg_192_1.duration_ = 5.07

		local var_192_0 = {
			ja = 5,
			ko = 3.266,
			zh = 4.433,
			en = 5.066
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play113161047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.25

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:GetWordFromCfg(113161046)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 10 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 10)

				if (10 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 10)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161046", "story_v_out_113161.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161046", "story_v_out_113161.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_113161", "113161046", "story_v_out_113161.awb")

						arg_192_1:RecordAudio("113161046", var_195_6)
						arg_192_1:RecordAudio("113161046", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_113161", "113161046", "story_v_out_113161.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_113161", "113161046", "story_v_out_113161.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play113161047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 113161047
		arg_196_1.duration_ = 12.2

		local var_196_0 = {
			ja = 10.6,
			ko = 8.533,
			zh = 11.4,
			en = 12.2
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play113161048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_0 = 2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				local var_199_1 = Color.New(0, 0, 0)

				var_199_1.a = Mathf.Lerp(0, 1, (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.mask_.color = var_199_1
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				local var_199_2 = Color.New(0, 0, 0)

				var_199_2.a = 1
				arg_196_1.mask_.color = var_199_2
			end

			local var_199_3 = 2

			if 2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_4 = 2

			if var_199_3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_3 + var_199_4 then
				local var_199_5 = Color.New(0, 0, 0)

				var_199_5.a = Mathf.Lerp(1, 0, (arg_196_1.time_ - var_199_3) / var_199_4)
				arg_196_1.mask_.color = var_199_5
			end

			if arg_196_1.time_ >= var_199_3 + var_199_4 and arg_196_1.time_ < var_199_3 + var_199_4 + arg_199_0 then
				local var_199_6 = Color.New(0, 0, 0)

				arg_196_1.mask_.enabled = false
				var_199_6.a = 0
				arg_196_1.mask_.color = var_199_6
			end

			local var_199_7 = arg_196_1.bgs_.OM0103.transform

			if 2 < arg_196_1.time_ and arg_196_1.time_ <= 2 + arg_199_0 then
				arg_196_1.var_.moveOldPosOM0103 = var_199_7.localPosition
			end

			local var_199_8 = 0.001

			if 2 <= arg_196_1.time_ and arg_196_1.time_ < 2 + var_199_8 then
				var_199_7.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosOM0103, Vector3.New(0, 1, 9.5), (arg_196_1.time_ - 2) / var_199_8)
			end

			if arg_196_1.time_ >= 2 + var_199_8 and arg_196_1.time_ < 2 + var_199_8 + arg_199_0 then
				var_199_7.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_199_9 = arg_196_1.bgs_.OM0103.transform

			if 2.01666666666667 < arg_196_1.time_ and arg_196_1.time_ <= 2.01666666666667 + arg_199_0 then
				arg_196_1.var_.moveOldPosOM0103 = var_199_9.localPosition
			end

			local var_199_10 = 3

			if 2.01666666666667 <= arg_196_1.time_ and arg_196_1.time_ < 2.01666666666667 + var_199_10 then
				var_199_9.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPosOM0103, Vector3.New(0, 1, 10), (arg_196_1.time_ - 2.01666666666667) / var_199_10)
			end

			if arg_196_1.time_ >= 2.01666666666667 + var_199_10 and arg_196_1.time_ < 2.01666666666667 + var_199_10 + arg_199_0 then
				var_199_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_199_11 = 4

			if 4 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			if arg_196_1.time_ >= var_199_11 + 1.01666666666667 and arg_196_1.time_ < var_199_11 + 1.01666666666667 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_12 = 4.2
			local var_199_13 = 0.45

			if 4.2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_14 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_14:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:GetWordFromCfg(113161047)
				local var_199_16 = arg_196_1:FormatText(var_199_15.content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_18 = 18 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_16) / 18)

				if (18 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_16) / 18)) > 0 and var_199_13 < var_199_18 then
					arg_196_1.talkMaxDuration = var_199_18
					var_199_12 = var_199_12 + 0.3

					if var_199_18 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_18 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161047", "story_v_out_113161.awb") ~= 0 then
					local var_199_19 = manager.audio:GetVoiceLength("story_v_out_113161", "113161047", "story_v_out_113161.awb") / 1000

					if var_199_19 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_12
					end

					if var_199_15.prefab_name ~= "" and arg_196_1.actors_[var_199_15.prefab_name] ~= nil then
						local var_199_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_15.prefab_name].transform, "story_v_out_113161", "113161047", "story_v_out_113161.awb")

						arg_196_1:RecordAudio("113161047", var_199_20)
						arg_196_1:RecordAudio("113161047", var_199_20)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_113161", "113161047", "story_v_out_113161.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_113161", "113161047", "story_v_out_113161.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_21 = var_199_12 + 0.3
			local var_199_22 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 + 0.3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_21 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_21) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_21 + var_199_22 and arg_196_1.time_ < var_199_21 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play113161048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 113161048
		arg_202_1.duration_ = 8.6

		local var_202_0 = {
			ja = 8.6,
			ko = 7.566,
			zh = 8.2,
			en = 8.133
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play113161049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.875

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(113161048)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 35 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 35)

				if (35 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 35)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161048", "story_v_out_113161.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161048", "story_v_out_113161.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_out_113161", "113161048", "story_v_out_113161.awb")

						arg_202_1:RecordAudio("113161048", var_205_6)
						arg_202_1:RecordAudio("113161048", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_113161", "113161048", "story_v_out_113161.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_113161", "113161048", "story_v_out_113161.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play113161049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 113161049
		arg_206_1.duration_ = 8.47

		local var_206_0 = {
			ja = 6.9,
			ko = 7,
			zh = 6.8,
			en = 8.466
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play113161050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.725

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(113161049)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 29 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 29)

				if (29 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 29)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161049", "story_v_out_113161.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161049", "story_v_out_113161.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_113161", "113161049", "story_v_out_113161.awb")

						arg_206_1:RecordAudio("113161049", var_209_6)
						arg_206_1:RecordAudio("113161049", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_113161", "113161049", "story_v_out_113161.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_113161", "113161049", "story_v_out_113161.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play113161050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 113161050
		arg_210_1.duration_ = 9.5

		local var_210_0 = {
			ja = 6,
			ko = 4.666,
			zh = 6.5,
			en = 9.5
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
			arg_210_1.auto_ = false
		end

		function arg_210_1.playNext_(arg_212_0)
			arg_210_1.onStoryFinished_()
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.475

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:GetWordFromCfg(113161050)
				local var_213_2 = arg_210_1:FormatText(var_213_1.content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 19 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 19)

				if (19 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_2) / 19)) > 0 and var_213_0 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + 0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113161", "113161050", "story_v_out_113161.awb") ~= 0 then
					local var_213_5 = manager.audio:GetVoiceLength("story_v_out_113161", "113161050", "story_v_out_113161.awb") / 1000

					if var_213_5 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + 0
					end

					if var_213_1.prefab_name ~= "" and arg_210_1.actors_[var_213_1.prefab_name] ~= nil then
						local var_213_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_1.prefab_name].transform, "story_v_out_113161", "113161050", "story_v_out_113161.awb")

						arg_210_1:RecordAudio("113161050", var_213_6)
						arg_210_1:RecordAudio("113161050", var_213_6)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_113161", "113161050", "story_v_out_113161.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_113161", "113161050", "story_v_out_113161.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_7 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_7

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/F03a",
		"TextureConfig/Background/OM0103"
	},
	voices = {
		"story_v_out_113161.awb"
	}
}
