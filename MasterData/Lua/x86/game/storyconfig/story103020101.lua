return {
	Play302011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 302011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play302011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_4_0.name = "ST01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST01

				arg_1_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST01" then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 1.025

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(302011001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 41 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 41)

				if (41 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 41)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play302011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 302011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play302011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0.2 < arg_8_1.time_ and arg_8_1.time_ <= 0.2 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_knock", "")
			end

			local var_11_1 = 0
			local var_11_2 = 1.775

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(302011002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 71 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 71)

				if (71 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 71)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play302011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 302011003
		arg_12_1.duration_ = 4.1

		local var_12_0 = {
			zh = 3.7,
			ja = 4.1
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play302011004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.675

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(302011003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 27 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 27)

				if (27 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 27)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011003", "story_v_out_302011.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011003", "story_v_out_302011.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_302011", "302011003", "story_v_out_302011.awb")

						arg_12_1:RecordAudio("302011003", var_15_6)
						arg_12_1:RecordAudio("302011003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_302011", "302011003", "story_v_out_302011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_302011", "302011003", "story_v_out_302011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play302011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 302011004
		arg_16_1.duration_ = 1

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"

			SetActive(arg_16_1.choicesGo_, true)

			for iter_17_0, iter_17_1 in ipairs(arg_16_1.choices_) do
				SetActive(iter_17_1.go, iter_17_0 <= 1)
			end

			arg_16_1.choices_[1].txt.text = arg_16_1:FormatText(StoryChoiceCfg[1731].name)
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play302011005(arg_16_1)
			end

			arg_16_1:RecordChoiceLog(302011004, 1731)
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= 0 + 0.566666666666667 and arg_16_1.time_ < 0 + 0.566666666666667 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play302011005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 302011005
		arg_20_1.duration_ = 10.8

		local var_20_0 = {
			zh = 6.633,
			ja = 10.8
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
				arg_20_0:Play302011006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1047ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1047ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1047ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1047ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1047ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1047ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["1047ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1047ui_story == nil then
				arg_20_1.var_.characterEffect1047ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1047ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1047ui_story then
				arg_20_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_8 = 0
			local var_23_9 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(302011005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 31 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 31)

				if (31 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 31)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011005", "story_v_out_302011.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_302011", "302011005", "story_v_out_302011.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_302011", "302011005", "story_v_out_302011.awb")

						arg_20_1:RecordAudio("302011005", var_23_15)
						arg_20_1:RecordAudio("302011005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_302011", "302011005", "story_v_out_302011.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_302011", "302011005", "story_v_out_302011.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play302011006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 302011006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play302011007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) and arg_24_1.var_.characterEffect1047ui_story == nil then
				arg_24_1.var_.characterEffect1047ui_story = arg_24_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) then
				if arg_24_1.var_.characterEffect1047ui_story and not isNil(arg_24_1.actors_["1047ui_story"]) then
					arg_24_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1047ui_story"]) and arg_24_1.var_.characterEffect1047ui_story then
				arg_24_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.375

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(302011006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 15 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 15)

				if (15 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 15)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play302011007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 302011007
		arg_28_1.duration_ = 7.37

		local var_28_0 = {
			zh = 7.366,
			ja = 7.3
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play302011008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story == nil then
				arg_28_1.var_.characterEffect1047ui_story = arg_28_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) then
				if arg_28_1.var_.characterEffect1047ui_story and not isNil(arg_28_1.actors_["1047ui_story"]) then
					arg_28_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1047ui_story"]) and arg_28_1.var_.characterEffect1047ui_story then
				arg_28_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_31_2 = 0
			local var_31_3 = 0.85

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(302011007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 34 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 34)

				if (34 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 34)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011007", "story_v_out_302011.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011007", "story_v_out_302011.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_302011", "302011007", "story_v_out_302011.awb")

						arg_28_1:RecordAudio("302011007", var_31_9)
						arg_28_1:RecordAudio("302011007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_302011", "302011007", "story_v_out_302011.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_302011", "302011007", "story_v_out_302011.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play302011008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 302011008
		arg_32_1.duration_ = 7.93

		local var_32_0 = {
			zh = 7.933,
			ja = 7.733
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
				arg_32_0:Play302011009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_35_0 = 0
			local var_35_1 = 0.725

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(302011008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 29 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 29)

				if (29 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 29)) > 0 and var_35_1 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011008", "story_v_out_302011.awb") ~= 0 then
					local var_35_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011008", "story_v_out_302011.awb") / 1000

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end

					if var_35_2.prefab_name ~= "" and arg_32_1.actors_[var_35_2.prefab_name] ~= nil then
						local var_35_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_2.prefab_name].transform, "story_v_out_302011", "302011008", "story_v_out_302011.awb")

						arg_32_1:RecordAudio("302011008", var_35_7)
						arg_32_1:RecordAudio("302011008", var_35_7)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_302011", "302011008", "story_v_out_302011.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_302011", "302011008", "story_v_out_302011.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play302011009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 302011009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play302011010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) and arg_36_1.var_.characterEffect1047ui_story == nil then
				arg_36_1.var_.characterEffect1047ui_story = arg_36_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) then
				if arg_36_1.var_.characterEffect1047ui_story and not isNil(arg_36_1.actors_["1047ui_story"]) then
					arg_36_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1047ui_story"]) and arg_36_1.var_.characterEffect1047ui_story then
				arg_36_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 1.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(302011009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 55 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 55)

				if (55 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 55)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play302011010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 302011010
		arg_40_1.duration_ = 6.8

		local var_40_0 = {
			zh = 6.8,
			ja = 6
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
				arg_40_0:Play302011011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story == nil then
				arg_40_1.var_.characterEffect1047ui_story = arg_40_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) then
				if arg_40_1.var_.characterEffect1047ui_story and not isNil(arg_40_1.actors_["1047ui_story"]) then
					arg_40_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1047ui_story"]) and arg_40_1.var_.characterEffect1047ui_story then
				arg_40_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_43_2 = 0
			local var_43_3 = 0.6

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_4 = arg_40_1:GetWordFromCfg(302011010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 24 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 24)

				if (24 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 24)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011010", "story_v_out_302011.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011010", "story_v_out_302011.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_302011", "302011010", "story_v_out_302011.awb")

						arg_40_1:RecordAudio("302011010", var_43_9)
						arg_40_1:RecordAudio("302011010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_302011", "302011010", "story_v_out_302011.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_302011", "302011010", "story_v_out_302011.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play302011011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 302011011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play302011012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) and arg_44_1.var_.characterEffect1047ui_story == nil then
				arg_44_1.var_.characterEffect1047ui_story = arg_44_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) then
				if arg_44_1.var_.characterEffect1047ui_story and not isNil(arg_44_1.actors_["1047ui_story"]) then
					arg_44_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1047ui_story"]) and arg_44_1.var_.characterEffect1047ui_story then
				arg_44_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(302011011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 5 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 5)

				if (5 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 5)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play302011012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 302011012
		arg_48_1.duration_ = 9.2

		local var_48_0 = {
			zh = 6.5,
			ja = 9.2
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
				arg_48_0:Play302011013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) and arg_48_1.var_.characterEffect1047ui_story == nil then
				arg_48_1.var_.characterEffect1047ui_story = arg_48_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) then
				if arg_48_1.var_.characterEffect1047ui_story and not isNil(arg_48_1.actors_["1047ui_story"]) then
					arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1047ui_story"]) and arg_48_1.var_.characterEffect1047ui_story then
				arg_48_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(302011012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 23 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 23)

				if (23 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 23)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011012", "story_v_out_302011.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011012", "story_v_out_302011.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_302011", "302011012", "story_v_out_302011.awb")

						arg_48_1:RecordAudio("302011012", var_51_9)
						arg_48_1:RecordAudio("302011012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_302011", "302011012", "story_v_out_302011.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_302011", "302011012", "story_v_out_302011.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play302011013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 302011013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play302011014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1047ui_story = arg_52_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).z)
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles = arg_52_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1047ui_story"].transform.position).z)
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1047ui_story"].transform.localEulerAngles = arg_52_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1047ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1047ui_story == nil then
				arg_52_1.var_.characterEffect1047ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1047ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_2)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1047ui_story then
				arg_52_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_55_3 = 0
			local var_55_4 = 0.85

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_5 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(302011013).content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 34 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_5) / 34)

				if (34 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_5) / 34)) > 0 and var_55_4 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_3
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_4, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_3) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_8 and arg_52_1.time_ < var_55_3 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play302011014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 302011014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play302011015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.15

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(302011014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 6 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 6)

				if (6 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 6)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play302011015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 302011015
		arg_60_1.duration_ = 3.5

		local var_60_0 = {
			zh = 2.466,
			ja = 3.5
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
				arg_60_0:Play302011016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1047ui_story = arg_60_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).z)
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles = arg_60_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_60_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1047ui_story"].transform.position).z)
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1047ui_story"].transform.localEulerAngles = arg_60_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1047ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1047ui_story == nil then
				arg_60_1.var_.characterEffect1047ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect1047ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1047ui_story then
				arg_60_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.3

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(302011015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 12 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 12)

				if (12 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 12)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011015", "story_v_out_302011.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011015", "story_v_out_302011.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_302011", "302011015", "story_v_out_302011.awb")

						arg_60_1:RecordAudio("302011015", var_63_11)
						arg_60_1:RecordAudio("302011015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_302011", "302011015", "story_v_out_302011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_302011", "302011015", "story_v_out_302011.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play302011016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 302011016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play302011017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story == nil then
				arg_64_1.var_.characterEffect1047ui_story = arg_64_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) then
				if arg_64_1.var_.characterEffect1047ui_story and not isNil(arg_64_1.actors_["1047ui_story"]) then
					arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1047ui_story"]) and arg_64_1.var_.characterEffect1047ui_story then
				arg_64_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.45

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(302011016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)

				if (18 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 18)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play302011017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 302011017
		arg_68_1.duration_ = 7.23

		local var_68_0 = {
			zh = 4.5,
			ja = 7.233
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play302011018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story == nil then
				arg_68_1.var_.characterEffect1047ui_story = arg_68_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) then
				if arg_68_1.var_.characterEffect1047ui_story and not isNil(arg_68_1.actors_["1047ui_story"]) then
					arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1047ui_story"]) and arg_68_1.var_.characterEffect1047ui_story then
				arg_68_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_71_2 = 0
			local var_71_3 = 0.525

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(302011017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 21 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 21)

				if (21 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 21)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011017", "story_v_out_302011.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011017", "story_v_out_302011.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_302011", "302011017", "story_v_out_302011.awb")

						arg_68_1:RecordAudio("302011017", var_71_9)
						arg_68_1:RecordAudio("302011017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_302011", "302011017", "story_v_out_302011.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_302011", "302011017", "story_v_out_302011.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play302011018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 302011018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play302011019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1047ui_story"]) and arg_72_1.var_.characterEffect1047ui_story == nil then
				arg_72_1.var_.characterEffect1047ui_story = arg_72_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1047ui_story"]) then
				if arg_72_1.var_.characterEffect1047ui_story and not isNil(arg_72_1.actors_["1047ui_story"]) then
					arg_72_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1047ui_story"]) and arg_72_1.var_.characterEffect1047ui_story then
				arg_72_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.575

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(302011018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 23 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 23)

				if (23 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 23)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play302011019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 302011019
		arg_76_1.duration_ = 7.77

		local var_76_0 = {
			zh = 7.766,
			ja = 7.7
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
				arg_76_0:Play302011020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) and arg_76_1.var_.characterEffect1047ui_story == nil then
				arg_76_1.var_.characterEffect1047ui_story = arg_76_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) then
				if arg_76_1.var_.characterEffect1047ui_story and not isNil(arg_76_1.actors_["1047ui_story"]) then
					arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1047ui_story"]) and arg_76_1.var_.characterEffect1047ui_story then
				arg_76_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_2 = 0
			local var_79_3 = 0.85

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(302011019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 34 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 34)

				if (34 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 34)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011019", "story_v_out_302011.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011019", "story_v_out_302011.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_302011", "302011019", "story_v_out_302011.awb")

						arg_76_1:RecordAudio("302011019", var_79_9)
						arg_76_1:RecordAudio("302011019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_302011", "302011019", "story_v_out_302011.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_302011", "302011019", "story_v_out_302011.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play302011020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 302011020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play302011021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) and arg_80_1.var_.characterEffect1047ui_story == nil then
				arg_80_1.var_.characterEffect1047ui_story = arg_80_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) then
				if arg_80_1.var_.characterEffect1047ui_story and not isNil(arg_80_1.actors_["1047ui_story"]) then
					arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1047ui_story"]) and arg_80_1.var_.characterEffect1047ui_story then
				arg_80_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.45

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(302011020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 18 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 18)

				if (18 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 18)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play302011021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 302011021
		arg_84_1.duration_ = 6.07

		local var_84_0 = {
			zh = 6.066,
			ja = 5.733
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
				arg_84_0:Play302011022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1047ui_story"]) and arg_84_1.var_.characterEffect1047ui_story == nil then
				arg_84_1.var_.characterEffect1047ui_story = arg_84_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1047ui_story"]) then
				if arg_84_1.var_.characterEffect1047ui_story and not isNil(arg_84_1.actors_["1047ui_story"]) then
					arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1047ui_story"]) and arg_84_1.var_.characterEffect1047ui_story then
				arg_84_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_2 = 0
			local var_87_3 = 0.65

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(302011021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 25 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 25)

				if (25 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 25)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011021", "story_v_out_302011.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011021", "story_v_out_302011.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_302011", "302011021", "story_v_out_302011.awb")

						arg_84_1:RecordAudio("302011021", var_87_9)
						arg_84_1:RecordAudio("302011021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_302011", "302011021", "story_v_out_302011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_302011", "302011021", "story_v_out_302011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play302011022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 302011022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play302011023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1047ui_story = arg_88_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).z)
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles = arg_88_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1047ui_story"].transform.position).z)
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1047ui_story"].transform.localEulerAngles = arg_88_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1047ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1047ui_story == nil then
				arg_88_1.var_.characterEffect1047ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1047ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_2)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1047ui_story then
				arg_88_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_91_3 = 0
			local var_91_4 = 1.175

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(302011022).content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 47 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 47)

				if (47 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_5) / 47)) > 0 and var_91_4 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_8 and arg_88_1.time_ < var_91_3 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play302011023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 302011023
		arg_92_1.duration_ = 8.17

		local var_92_0 = {
			zh = 6.433,
			ja = 8.166
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
				arg_92_0:Play302011024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1047ui_story = arg_92_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).z)
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles = arg_92_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_92_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1047ui_story"].transform.position).z)
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1047ui_story"].transform.localEulerAngles = arg_92_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["1047ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1047ui_story == nil then
				arg_92_1.var_.characterEffect1047ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1047ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1047ui_story then
				arg_92_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_95_4 = 0
			local var_95_5 = 0.85

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_6 = arg_92_1:GetWordFromCfg(302011023)
				local var_95_7 = arg_92_1:FormatText(var_95_6.content)

				arg_92_1.text_.text = var_95_7

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_9 = 34 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 34)

				if (34 <= 0 and var_95_5 or var_95_5 * (utf8.len(var_95_7) / 34)) > 0 and var_95_5 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_4
					end
				end

				arg_92_1.text_.text = var_95_7
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011023", "story_v_out_302011.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011023", "story_v_out_302011.awb") / 1000

					if var_95_10 + var_95_4 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_4
					end

					if var_95_6.prefab_name ~= "" and arg_92_1.actors_[var_95_6.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_6.prefab_name].transform, "story_v_out_302011", "302011023", "story_v_out_302011.awb")

						arg_92_1:RecordAudio("302011023", var_95_11)
						arg_92_1:RecordAudio("302011023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_302011", "302011023", "story_v_out_302011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_302011", "302011023", "story_v_out_302011.awb")
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

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play302011024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 302011024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play302011025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) and arg_96_1.var_.characterEffect1047ui_story == nil then
				arg_96_1.var_.characterEffect1047ui_story = arg_96_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) then
				if arg_96_1.var_.characterEffect1047ui_story and not isNil(arg_96_1.actors_["1047ui_story"]) then
					arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1047ui_story"]) and arg_96_1.var_.characterEffect1047ui_story then
				arg_96_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(302011024).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 9)

				if (9 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 9)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play302011025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 302011025
		arg_100_1.duration_ = 16.37

		local var_100_0 = {
			zh = 13.8,
			ja = 16.366
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play302011026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story == nil then
				arg_100_1.var_.characterEffect1047ui_story = arg_100_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) then
				if arg_100_1.var_.characterEffect1047ui_story and not isNil(arg_100_1.actors_["1047ui_story"]) then
					arg_100_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1047ui_story"]) and arg_100_1.var_.characterEffect1047ui_story then
				arg_100_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 1.475

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(302011025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 59 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 59)

				if (59 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 59)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011025", "story_v_out_302011.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011025", "story_v_out_302011.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_302011", "302011025", "story_v_out_302011.awb")

						arg_100_1:RecordAudio("302011025", var_103_9)
						arg_100_1:RecordAudio("302011025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_302011", "302011025", "story_v_out_302011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_302011", "302011025", "story_v_out_302011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play302011026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 302011026
		arg_104_1.duration_ = 14.13

		local var_104_0 = {
			zh = 8.666,
			ja = 14.133
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play302011027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.95

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:GetWordFromCfg(302011026)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 38 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 38)

				if (38 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 38)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011026", "story_v_out_302011.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011026", "story_v_out_302011.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_302011", "302011026", "story_v_out_302011.awb")

						arg_104_1:RecordAudio("302011026", var_107_6)
						arg_104_1:RecordAudio("302011026", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_302011", "302011026", "story_v_out_302011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_302011", "302011026", "story_v_out_302011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play302011027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 302011027
		arg_108_1.duration_ = 4.33

		local var_108_0 = {
			zh = 3.166,
			ja = 4.333
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play302011028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action473")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_111_0 = 0
			local var_111_1 = 0.325

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(302011027)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 13 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 13)

				if (13 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 13)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011027", "story_v_out_302011.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011027", "story_v_out_302011.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_302011", "302011027", "story_v_out_302011.awb")

						arg_108_1:RecordAudio("302011027", var_111_7)
						arg_108_1:RecordAudio("302011027", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_302011", "302011027", "story_v_out_302011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_302011", "302011027", "story_v_out_302011.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play302011028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 302011028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play302011029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story == nil then
				arg_112_1.var_.characterEffect1047ui_story = arg_112_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) then
				if arg_112_1.var_.characterEffect1047ui_story and not isNil(arg_112_1.actors_["1047ui_story"]) then
					arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1047ui_story"]) and arg_112_1.var_.characterEffect1047ui_story then
				arg_112_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_115_1 = arg_112_1.actors_["1047ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1047ui_story = var_115_1.localPosition
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0, 100, 0)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_115_4 = 0
			local var_115_5 = 1.55

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(302011028).content)

				arg_112_1.text_.text = var_115_6

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_8 = 62 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_6) / 62)

				if (62 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_6) / 62)) > 0 and var_115_5 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_6
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_9 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_9 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_9

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_9 and arg_112_1.time_ < var_115_4 + var_115_9 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play302011029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 302011029
		arg_116_1.duration_ = 10.37

		local var_116_0 = {
			zh = 9.166,
			ja = 10.366
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
				arg_116_0:Play302011030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if arg_116_1.bgs_.ST10 == nil then
				local var_119_0 = Object.Instantiate(arg_116_1.paintGo_)

				var_119_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_119_0.name = "ST10"
				var_119_0.transform.parent = arg_116_1.stage_.transform
				var_119_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.bgs_.ST10 = var_119_0
			end

			if 2 < arg_116_1.time_ and arg_116_1.time_ <= 2 + arg_119_0 then
				local var_119_1 = arg_116_1.bgs_.ST10

				arg_116_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_2 = var_119_1:GetComponent("SpriteRenderer")

				if var_119_2 and var_119_2.sprite then
					local var_119_3 = 2 * (var_119_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_1.transform.localScale = Vector3.New(var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, var_119_3 / var_119_2.sprite.bounds.size.y < var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x and var_119_3 * manager.ui.mainCameraCom_.aspect / var_119_2.sprite.bounds.size.x or var_119_3 / var_119_2.sprite.bounds.size.y, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "ST10" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_4 = 4.00000000298023

			if 4.00000000298023 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_4 + 0.3 and arg_116_1.time_ < var_119_4 + 0.3 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_5 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_6 = 2

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_6 then
				local var_119_7 = Color.New(0, 0, 0)

				var_119_7.a = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_5) / var_119_6)
				arg_116_1.mask_.color = var_119_7
			end

			if arg_116_1.time_ >= var_119_5 + var_119_6 and arg_116_1.time_ < var_119_5 + var_119_6 + arg_119_0 then
				local var_119_8 = Color.New(0, 0, 0)

				var_119_8.a = 1
				arg_116_1.mask_.color = var_119_8
			end

			local var_119_9 = 2

			if 2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_9 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_10 = 2

			if var_119_9 <= arg_116_1.time_ and arg_116_1.time_ < var_119_9 + var_119_10 then
				local var_119_11 = Color.New(0, 0, 0)

				var_119_11.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_9) / var_119_10)
				arg_116_1.mask_.color = var_119_11
			end

			if arg_116_1.time_ >= var_119_9 + var_119_10 and arg_116_1.time_ < var_119_9 + var_119_10 + arg_119_0 then
				local var_119_12 = Color.New(0, 0, 0)

				arg_116_1.mask_.enabled = false
				var_119_12.a = 0
				arg_116_1.mask_.color = var_119_12
			end

			local var_119_13 = arg_116_1.actors_["1047ui_story"].transform

			if 3.8 < arg_116_1.time_ and arg_116_1.time_ <= 3.8 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047ui_story = var_119_13.localPosition
			end

			local var_119_14 = 0.001

			if 3.8 <= arg_116_1.time_ and arg_116_1.time_ < 3.8 + var_119_14 then
				var_119_13.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_116_1.time_ - 3.8) / var_119_14)
				var_119_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_13.position).x, (manager.ui.mainCamera.transform.position - var_119_13.position).y, (manager.ui.mainCamera.transform.position - var_119_13.position).z)
				var_119_13.localEulerAngles.z = 0
				var_119_13.localEulerAngles.x = 0
				var_119_13.localEulerAngles = var_119_13.localEulerAngles
			end

			if arg_116_1.time_ >= 3.8 + var_119_14 and arg_116_1.time_ < 3.8 + var_119_14 + arg_119_0 then
				var_119_13.localPosition = Vector3.New(0, -1.13, -6.2)
				var_119_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_13.position).x, (manager.ui.mainCamera.transform.position - var_119_13.position).y, (manager.ui.mainCamera.transform.position - var_119_13.position).z)
				var_119_13.localEulerAngles.z = 0
				var_119_13.localEulerAngles.x = 0
				var_119_13.localEulerAngles = var_119_13.localEulerAngles
			end

			local var_119_15 = arg_116_1.actors_["1047ui_story"]

			if 3.8 < arg_116_1.time_ and arg_116_1.time_ <= 3.8 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect1047ui_story == nil then
				arg_116_1.var_.characterEffect1047ui_story = var_119_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_16 = 0.200000002980232

			if 3.8 <= arg_116_1.time_ and arg_116_1.time_ < 3.8 + var_119_16 and not isNil(var_119_15) then
				if arg_116_1.var_.characterEffect1047ui_story and not isNil(var_119_15) then
					arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 3.8 + var_119_16 and arg_116_1.time_ < 3.8 + var_119_16 + arg_119_0 and not isNil(var_119_15) and arg_116_1.var_.characterEffect1047ui_story then
				arg_116_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.8 < arg_116_1.time_ and arg_116_1.time_ <= 3.8 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 3.8 < arg_116_1.time_ and arg_116_1.time_ <= 3.8 + arg_119_0 then
				arg_116_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_116_1.time_ and arg_116_1.time_ <= 1.2 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0.2 < arg_116_1.time_ and arg_116_1.time_ <= 0.2 + arg_119_0 then
				arg_116_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 1 < arg_116_1.time_ and arg_116_1.time_ <= 1 + arg_119_0 then
				arg_116_1:AudioAction("play", "music", "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily.awb")

				local var_119_22 = manager.audio:GetAudioName("bgm_activity_5_2_story_remake_daily", "bgm_activity_5_2_story_remake_daily")

				if "" ~= "" then
					if arg_116_1.bgmTxt_.text ~= var_119_22 and arg_116_1.bgmTxt_.text ~= "" then
						if arg_116_1.bgmTxt2_.text ~= "" then
							arg_116_1.bgmTxt_.text = arg_116_1.bgmTxt2_.text
						end

						arg_116_1.bgmTxt2_.text = var_119_22

						arg_116_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_116_1.bgmTxt_.text = var_119_22
						arg_116_1.bgmTxt2_.text = var_119_22
					end

					if arg_116_1.bgmTimer then
						arg_116_1.bgmTimer:Stop()

						arg_116_1.bgmTimer = nil
					end

					if arg_116_1.settingData.show_music_name == 1 then
						arg_116_1.musicController:SetSelectedState("show")
						arg_116_1.musicAnimator_:Play("open", 0, 0)

						if arg_116_1.settingData.music_time ~= 0 then
							arg_116_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_116_1.settingData.music_time), function()
								if arg_116_1 == nil or isNil(arg_116_1.bgmTxt_) then
									return
								end

								arg_116_1.musicController:SetSelectedState("hide")
								arg_116_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_23 = 4
			local var_119_24 = 0.475

			if 4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_23 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_25 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_25:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_116_1.dialogCg_.alpha = arg_121_0
				end))
				var_119_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_26 = arg_116_1:GetWordFromCfg(302011029)
				local var_119_27 = arg_116_1:FormatText(var_119_26.content)

				arg_116_1.text_.text = var_119_27

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_29 = 19 <= 0 and var_119_24 or var_119_24 * (utf8.len(var_119_27) / 19)

				if (19 <= 0 and var_119_24 or var_119_24 * (utf8.len(var_119_27) / 19)) > 0 and var_119_24 < var_119_29 then
					arg_116_1.talkMaxDuration = var_119_29
					var_119_23 = var_119_23 + 0.3

					if var_119_29 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_29 + var_119_23
					end
				end

				arg_116_1.text_.text = var_119_27
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011029", "story_v_out_302011.awb") ~= 0 then
					local var_119_30 = manager.audio:GetVoiceLength("story_v_out_302011", "302011029", "story_v_out_302011.awb") / 1000

					if var_119_30 + var_119_23 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_23
					end

					if var_119_26.prefab_name ~= "" and arg_116_1.actors_[var_119_26.prefab_name] ~= nil then
						local var_119_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_26.prefab_name].transform, "story_v_out_302011", "302011029", "story_v_out_302011.awb")

						arg_116_1:RecordAudio("302011029", var_119_31)
						arg_116_1:RecordAudio("302011029", var_119_31)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_302011", "302011029", "story_v_out_302011.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_302011", "302011029", "story_v_out_302011.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_32 = var_119_23 + 0.3
			local var_119_33 = math.max(var_119_24, arg_116_1.talkMaxDuration)

			if var_119_23 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_32 + var_119_33 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_32) / var_119_33

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_32 + var_119_33 and arg_116_1.time_ < var_119_32 + var_119_33 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play302011030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 302011030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play302011031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1047ui_story = arg_123_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).z)
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles = arg_123_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1047ui_story"].transform.position).z)
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1047ui_story"].transform.localEulerAngles = arg_123_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1047ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1047ui_story == nil then
				arg_123_1.var_.characterEffect1047ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1047ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_2)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1047ui_story then
				arg_123_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_126_3 = 0
			local var_126_4 = 1.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_3 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_5 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(302011030).content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 64 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 64)

				if (64 <= 0 and var_126_4 or var_126_4 * (utf8.len(var_126_5) / 64)) > 0 and var_126_4 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_3 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_3
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_8 = math.max(var_126_4, arg_123_1.talkMaxDuration)

			if var_126_3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_3 + var_126_8 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_3) / var_126_8

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_3 + var_126_8 and arg_123_1.time_ < var_126_3 + var_126_8 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play302011031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 302011031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play302011032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(302011031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 20 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 20)

				if (20 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 20)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play302011032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 302011032
		arg_131_1.duration_ = 7.73

		local var_131_0 = {
			zh = 7.066,
			ja = 7.733
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play302011033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1047ui_story = arg_131_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).z)
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles = arg_131_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_131_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1047ui_story"].transform.position).z)
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1047ui_story"].transform.localEulerAngles = arg_131_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1047ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1047ui_story == nil then
				arg_131_1.var_.characterEffect1047ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1047ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1047ui_story then
				arg_131_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_134_4 = 0
			local var_134_5 = 0.675

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(302011032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 27 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 27)

				if (27 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 27)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011032", "story_v_out_302011.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011032", "story_v_out_302011.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_302011", "302011032", "story_v_out_302011.awb")

						arg_131_1:RecordAudio("302011032", var_134_11)
						arg_131_1:RecordAudio("302011032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_302011", "302011032", "story_v_out_302011.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_302011", "302011032", "story_v_out_302011.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play302011033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 302011033
		arg_135_1.duration_ = 6.03

		local var_135_0 = {
			zh = 4.8,
			ja = 6.033
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play302011034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_138_0 = 0
			local var_138_1 = 0.525

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(302011033)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 21 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 21)

				if (21 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_3) / 21)) > 0 and var_138_1 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011033", "story_v_out_302011.awb") ~= 0 then
					local var_138_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011033", "story_v_out_302011.awb") / 1000

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end

					if var_138_2.prefab_name ~= "" and arg_135_1.actors_[var_138_2.prefab_name] ~= nil then
						local var_138_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_2.prefab_name].transform, "story_v_out_302011", "302011033", "story_v_out_302011.awb")

						arg_135_1:RecordAudio("302011033", var_138_7)
						arg_135_1:RecordAudio("302011033", var_138_7)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_302011", "302011033", "story_v_out_302011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_302011", "302011033", "story_v_out_302011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_8 and arg_135_1.time_ < var_138_0 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play302011034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 302011034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play302011035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1047ui_story"]) and arg_139_1.var_.characterEffect1047ui_story == nil then
				arg_139_1.var_.characterEffect1047ui_story = arg_139_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1047ui_story"]) then
				if arg_139_1.var_.characterEffect1047ui_story and not isNil(arg_139_1.actors_["1047ui_story"]) then
					arg_139_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1047ui_story"]) and arg_139_1.var_.characterEffect1047ui_story then
				arg_139_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(302011034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 8 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 8)

				if (8 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 8)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play302011035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 302011035
		arg_143_1.duration_ = 10.17

		local var_143_0 = {
			zh = 6.8,
			ja = 10.166
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play302011036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story == nil then
				arg_143_1.var_.characterEffect1047ui_story = arg_143_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) then
				if arg_143_1.var_.characterEffect1047ui_story and not isNil(arg_143_1.actors_["1047ui_story"]) then
					arg_143_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story then
				arg_143_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_146_2 = 0
			local var_146_3 = 0.725

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(302011035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 29 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 29)

				if (29 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 29)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011035", "story_v_out_302011.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011035", "story_v_out_302011.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_302011", "302011035", "story_v_out_302011.awb")

						arg_143_1:RecordAudio("302011035", var_146_9)
						arg_143_1:RecordAudio("302011035", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_302011", "302011035", "story_v_out_302011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_302011", "302011035", "story_v_out_302011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play302011036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 302011036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play302011037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = arg_147_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1047ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1047ui_story == nil then
				arg_147_1.var_.characterEffect1047ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1047ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_2)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1047ui_story then
				arg_147_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_150_3 = 0
			local var_150_4 = 1.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_5 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(302011036).content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 51 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 51)

				if (51 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 51)) > 0 and var_150_4 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_3
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_4, arg_147_1.talkMaxDuration)

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_3) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_3 + var_150_8 and arg_147_1.time_ < var_150_3 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play302011037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 302011037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play302011038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.675

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(302011037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 67 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 67)

				if (67 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 67)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play302011038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 302011038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play302011039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.35

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(302011038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 14 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 14)

				if (14 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 14)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play302011039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 302011039
		arg_159_1.duration_ = 5.37

		local var_159_0 = {
			zh = 5.366,
			ja = 1.333
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play302011040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if arg_159_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_162_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_159_1.stage_.transform)

				var_162_0.name = "1066ui_story"
				var_162_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["1066ui_story"] = var_162_0

				local var_162_1 = var_162_0:GetComponentInChildren(typeof(CharacterEffect))

				var_162_1.enabled = true

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_1.transform, false)

				arg_159_1.var_["1066ui_story" .. "Animator"] = var_162_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_159_1.var_["1066ui_story" .. "LipSync"] = var_162_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_162_3 = arg_159_1.actors_["1066ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1066ui_story = var_162_3.localPosition
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_159_1.time_ - 0) / var_162_4)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, -0.77, -6.1)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			local var_162_5 = arg_159_1.actors_["1066ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1066ui_story == nil then
				arg_159_1.var_.characterEffect1066ui_story = var_162_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.characterEffect1066ui_story and not isNil(var_162_5) then
					arg_159_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1066ui_story then
				arg_159_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_162_8 = 0
			local var_162_9 = 0.625

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(302011039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 25 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 25)

				if (25 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 25)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011039", "story_v_out_302011.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_302011", "302011039", "story_v_out_302011.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_302011", "302011039", "story_v_out_302011.awb")

						arg_159_1:RecordAudio("302011039", var_162_15)
						arg_159_1:RecordAudio("302011039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_302011", "302011039", "story_v_out_302011.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_302011", "302011039", "story_v_out_302011.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play302011040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 302011040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play302011041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1066ui_story"]) and arg_163_1.var_.characterEffect1066ui_story == nil then
				arg_163_1.var_.characterEffect1066ui_story = arg_163_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1066ui_story"]) then
				if arg_163_1.var_.characterEffect1066ui_story and not isNil(arg_163_1.actors_["1066ui_story"]) then
					arg_163_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1066ui_story"]) and arg_163_1.var_.characterEffect1066ui_story then
				arg_163_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(302011040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 8 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 8)

				if (8 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 8)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play302011041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 302011041
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 3.233,
			ja = 1.999999999999
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
				arg_167_0:Play302011042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1066ui_story"]) and arg_167_1.var_.characterEffect1066ui_story == nil then
				arg_167_1.var_.characterEffect1066ui_story = arg_167_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1066ui_story"]) then
				if arg_167_1.var_.characterEffect1066ui_story and not isNil(arg_167_1.actors_["1066ui_story"]) then
					arg_167_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1066ui_story"]) and arg_167_1.var_.characterEffect1066ui_story then
				arg_167_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_170_2 = 0
			local var_170_3 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(302011041)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 14 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 14)

				if (14 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 14)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011041", "story_v_out_302011.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011041", "story_v_out_302011.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_302011", "302011041", "story_v_out_302011.awb")

						arg_167_1:RecordAudio("302011041", var_170_9)
						arg_167_1:RecordAudio("302011041", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_302011", "302011041", "story_v_out_302011.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_302011", "302011041", "story_v_out_302011.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play302011042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 302011042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play302011043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1066ui_story = arg_171_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).z)
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles = arg_171_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1066ui_story"].transform.position).z)
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1066ui_story"].transform.localEulerAngles = arg_171_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1066ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1066ui_story == nil then
				arg_171_1.var_.characterEffect1066ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1066ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_2)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1066ui_story then
				arg_171_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_174_3 = 0
			local var_174_4 = 1.4

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(302011042).content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 56 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 56)

				if (56 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 56)) > 0 and var_174_4 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_8 and arg_171_1.time_ < var_174_3 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play302011043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 302011043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play302011044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.125

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(302011043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 5 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 5)

				if (5 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 5)) > 0 and var_178_0 < var_178_3 then
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
	Play302011044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 302011044
		arg_179_1.duration_ = 4

		local var_179_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play302011045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1066ui_story = arg_179_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).z)
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles = arg_179_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_179_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1066ui_story"].transform.position).z)
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1066ui_story"].transform.localEulerAngles = arg_179_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1066ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1066ui_story == nil then
				arg_179_1.var_.characterEffect1066ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1066ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1066ui_story then
				arg_179_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_4 = 0
			local var_182_5 = 0.475

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(302011044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 19 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 19)

				if (19 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 19)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011044", "story_v_out_302011.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011044", "story_v_out_302011.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_302011", "302011044", "story_v_out_302011.awb")

						arg_179_1:RecordAudio("302011044", var_182_11)
						arg_179_1:RecordAudio("302011044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_302011", "302011044", "story_v_out_302011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_302011", "302011044", "story_v_out_302011.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play302011045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 302011045
		arg_183_1.duration_ = 7.2

		local var_183_0 = {
			zh = 7.2,
			ja = 1.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play302011046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.925

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(302011045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 37 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 37)

				if (37 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 37)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011045", "story_v_out_302011.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011045", "story_v_out_302011.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_302011", "302011045", "story_v_out_302011.awb")

						arg_183_1:RecordAudio("302011045", var_186_6)
						arg_183_1:RecordAudio("302011045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_302011", "302011045", "story_v_out_302011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_302011", "302011045", "story_v_out_302011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play302011046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 302011046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play302011047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) and arg_187_1.var_.characterEffect1066ui_story == nil then
				arg_187_1.var_.characterEffect1066ui_story = arg_187_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) then
				if arg_187_1.var_.characterEffect1066ui_story and not isNil(arg_187_1.actors_["1066ui_story"]) then
					arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1066ui_story"]) and arg_187_1.var_.characterEffect1066ui_story then
				arg_187_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.2

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(302011046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 8 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 8)

				if (8 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 8)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play302011047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 302011047
		arg_191_1.duration_ = 6.3

		local var_191_0 = {
			zh = 6.3,
			ja = 1.333
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play302011048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1066ui_story"]) and arg_191_1.var_.characterEffect1066ui_story == nil then
				arg_191_1.var_.characterEffect1066ui_story = arg_191_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1066ui_story"]) then
				if arg_191_1.var_.characterEffect1066ui_story and not isNil(arg_191_1.actors_["1066ui_story"]) then
					arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1066ui_story"]) and arg_191_1.var_.characterEffect1066ui_story then
				arg_191_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_194_2 = 0
			local var_194_3 = 0.625

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(302011047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 25 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 25)

				if (25 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 25)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011047", "story_v_out_302011.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011047", "story_v_out_302011.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_302011", "302011047", "story_v_out_302011.awb")

						arg_191_1:RecordAudio("302011047", var_194_9)
						arg_191_1:RecordAudio("302011047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_302011", "302011047", "story_v_out_302011.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_302011", "302011047", "story_v_out_302011.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play302011048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 302011048
		arg_195_1.duration_ = 16

		local var_195_0 = {
			zh = 10.433,
			ja = 16
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play302011049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if arg_195_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_198_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_195_1.stage_.transform)

				var_198_0.name = "1033ui_story"
				var_198_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1033ui_story"] = var_198_0

				local var_198_1 = var_198_0:GetComponentInChildren(typeof(CharacterEffect))

				var_198_1.enabled = true

				local var_198_2 = GameObjectTools.GetOrAddComponent(var_198_0, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(false)
				end

				arg_195_1:ShowWeapon(var_198_1.transform, false)

				arg_195_1.var_["1033ui_story" .. "Animator"] = var_198_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_195_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_195_1.var_["1033ui_story" .. "LipSync"] = var_198_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_198_3 = arg_195_1.actors_["1033ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1033ui_story = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = arg_195_1.actors_["1066ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1066ui_story = var_198_5.localPosition
			end

			local var_198_6 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_195_1.time_ - 0) / var_198_6)
				var_198_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_5.position).x, (manager.ui.mainCamera.transform.position - var_198_5.position).y, (manager.ui.mainCamera.transform.position - var_198_5.position).z)
				var_198_5.localEulerAngles.z = 0
				var_198_5.localEulerAngles.x = 0
				var_198_5.localEulerAngles = var_198_5.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_198_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_5.position).x, (manager.ui.mainCamera.transform.position - var_198_5.position).y, (manager.ui.mainCamera.transform.position - var_198_5.position).z)
				var_198_5.localEulerAngles.z = 0
				var_198_5.localEulerAngles.x = 0
				var_198_5.localEulerAngles = var_198_5.localEulerAngles
			end

			local var_198_7 = arg_195_1.actors_["1033ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.characterEffect1033ui_story == nil then
				arg_195_1.var_.characterEffect1033ui_story = var_198_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_8 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_8 and not isNil(var_198_7) then
				if arg_195_1.var_.characterEffect1033ui_story and not isNil(var_198_7) then
					arg_195_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_8 and arg_195_1.time_ < 0 + var_198_8 + arg_198_0 and not isNil(var_198_7) and arg_195_1.var_.characterEffect1033ui_story then
				arg_195_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_198_10 = arg_195_1.actors_["1066ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_10) and arg_195_1.var_.characterEffect1066ui_story == nil then
				arg_195_1.var_.characterEffect1066ui_story = var_198_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_11 and not isNil(var_198_10) then
				if arg_195_1.var_.characterEffect1066ui_story and not isNil(var_198_10) then
					arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_11)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_11 and arg_195_1.time_ < 0 + var_198_11 + arg_198_0 and not isNil(var_198_10) and arg_195_1.var_.characterEffect1066ui_story then
				arg_195_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_198_12 = 0
			local var_198_13 = 1.2

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_14 = arg_195_1:GetWordFromCfg(302011048)
				local var_198_15 = arg_195_1:FormatText(var_198_14.content)

				arg_195_1.text_.text = var_198_15

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_17 = 48 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 48)

				if (48 <= 0 and var_198_13 or var_198_13 * (utf8.len(var_198_15) / 48)) > 0 and var_198_13 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17

					if var_198_17 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_12
					end
				end

				arg_195_1.text_.text = var_198_15
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011048", "story_v_out_302011.awb") ~= 0 then
					local var_198_18 = manager.audio:GetVoiceLength("story_v_out_302011", "302011048", "story_v_out_302011.awb") / 1000

					if var_198_18 + var_198_12 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_12
					end

					if var_198_14.prefab_name ~= "" and arg_195_1.actors_[var_198_14.prefab_name] ~= nil then
						local var_198_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_14.prefab_name].transform, "story_v_out_302011", "302011048", "story_v_out_302011.awb")

						arg_195_1:RecordAudio("302011048", var_198_19)
						arg_195_1:RecordAudio("302011048", var_198_19)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_302011", "302011048", "story_v_out_302011.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_302011", "302011048", "story_v_out_302011.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_13, arg_195_1.talkMaxDuration)

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_12) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_12 + var_198_20 and arg_195_1.time_ < var_198_12 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play302011049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 302011049
		arg_199_1.duration_ = 9.5

		local var_199_0 = {
			zh = 8.566,
			ja = 9.5
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play302011050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.075

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(302011049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 43)

				if (43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 43)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011049", "story_v_out_302011.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011049", "story_v_out_302011.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_302011", "302011049", "story_v_out_302011.awb")

						arg_199_1:RecordAudio("302011049", var_202_6)
						arg_199_1:RecordAudio("302011049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_302011", "302011049", "story_v_out_302011.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_302011", "302011049", "story_v_out_302011.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play302011050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 302011050
		arg_203_1.duration_ = 4.3

		local var_203_0 = {
			zh = 4.3,
			ja = 1.999999999999
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play302011051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1066ui_story"]) and arg_203_1.var_.characterEffect1066ui_story == nil then
				arg_203_1.var_.characterEffect1066ui_story = arg_203_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1066ui_story"]) then
				if arg_203_1.var_.characterEffect1066ui_story and not isNil(arg_203_1.actors_["1066ui_story"]) then
					arg_203_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1066ui_story"]) and arg_203_1.var_.characterEffect1066ui_story then
				arg_203_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_206_2 = arg_203_1.actors_["1033ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1033ui_story == nil then
				arg_203_1.var_.characterEffect1033ui_story = var_206_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_3 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.characterEffect1033ui_story and not isNil(var_206_2) then
					arg_203_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_3)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.characterEffect1033ui_story then
				arg_203_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_206_4 = 0
			local var_206_5 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(302011050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 20 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 20)

				if (20 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 20)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011050", "story_v_out_302011.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011050", "story_v_out_302011.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_302011", "302011050", "story_v_out_302011.awb")

						arg_203_1:RecordAudio("302011050", var_206_11)
						arg_203_1:RecordAudio("302011050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_302011", "302011050", "story_v_out_302011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_302011", "302011050", "story_v_out_302011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play302011051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 302011051
		arg_207_1.duration_ = 10.57

		local var_207_0 = {
			zh = 6.366,
			ja = 10.566
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play302011052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1033ui_story"]) and arg_207_1.var_.characterEffect1033ui_story == nil then
				arg_207_1.var_.characterEffect1033ui_story = arg_207_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1033ui_story"]) then
				if arg_207_1.var_.characterEffect1033ui_story and not isNil(arg_207_1.actors_["1033ui_story"]) then
					arg_207_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1033ui_story"]) and arg_207_1.var_.characterEffect1033ui_story then
				arg_207_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_210_2 = arg_207_1.actors_["1066ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1066ui_story == nil then
				arg_207_1.var_.characterEffect1066ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect1066ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1066ui_story then
				arg_207_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_210_4 = 0
			local var_210_5 = 0.825

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(302011051)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 33 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 33)

				if (33 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 33)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011051", "story_v_out_302011.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011051", "story_v_out_302011.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_302011", "302011051", "story_v_out_302011.awb")

						arg_207_1:RecordAudio("302011051", var_210_11)
						arg_207_1:RecordAudio("302011051", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_302011", "302011051", "story_v_out_302011.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_302011", "302011051", "story_v_out_302011.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play302011052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 302011052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play302011053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1033ui_story = arg_211_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).z)
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles = arg_211_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1033ui_story"].transform.position).z)
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1033ui_story"].transform.localEulerAngles = arg_211_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1066ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1066ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, 100, 0)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = arg_211_1.actors_["1033ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1033ui_story == nil then
				arg_211_1.var_.characterEffect1033ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect1033ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_4)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1033ui_story then
				arg_211_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_214_5 = 0
			local var_214_6 = 1.075

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(302011052).content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 43 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 43)

				if (43 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 43)) > 0 and var_214_6 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_10 and arg_211_1.time_ < var_214_5 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play302011053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 302011053
		arg_215_1.duration_ = 6.97

		local var_215_0 = {
			zh = 6.966,
			ja = 1.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play302011054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1066ui_story = arg_215_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).z)
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles = arg_215_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_215_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1066ui_story"].transform.position).z)
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1066ui_story"].transform.localEulerAngles = arg_215_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1066ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1066ui_story == nil then
				arg_215_1.var_.characterEffect1066ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1066ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1066ui_story then
				arg_215_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 0.85

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(302011053)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 34 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 34)

				if (34 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 34)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011053", "story_v_out_302011.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011053", "story_v_out_302011.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_302011", "302011053", "story_v_out_302011.awb")

						arg_215_1:RecordAudio("302011053", var_218_11)
						arg_215_1:RecordAudio("302011053", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_302011", "302011053", "story_v_out_302011.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_302011", "302011053", "story_v_out_302011.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play302011054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 302011054
		arg_219_1.duration_ = 3.37

		local var_219_0 = {
			zh = 3.366,
			ja = 1.999999999999
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play302011055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_222_0 = 0
			local var_222_1 = 0.375

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(302011054)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 15 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 15)

				if (15 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 15)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011054", "story_v_out_302011.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011054", "story_v_out_302011.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_302011", "302011054", "story_v_out_302011.awb")

						arg_219_1:RecordAudio("302011054", var_222_7)
						arg_219_1:RecordAudio("302011054", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_302011", "302011054", "story_v_out_302011.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_302011", "302011054", "story_v_out_302011.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play302011055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 302011055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play302011056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1066ui_story"]) and arg_223_1.var_.characterEffect1066ui_story == nil then
				arg_223_1.var_.characterEffect1066ui_story = arg_223_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1066ui_story"]) then
				if arg_223_1.var_.characterEffect1066ui_story and not isNil(arg_223_1.actors_["1066ui_story"]) then
					arg_223_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1066ui_story"]) and arg_223_1.var_.characterEffect1066ui_story then
				arg_223_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.475

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(302011055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 19 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 19)

				if (19 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 19)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play302011056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 302011056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play302011057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.325

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(302011056).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 13)

				if (13 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 13)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play302011057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 302011057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play302011058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1066ui_story = arg_231_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).z)
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles = arg_231_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1066ui_story"].transform.position).z)
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1066ui_story"].transform.localEulerAngles = arg_231_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_234_1 = 0
			local var_234_2 = 1.35

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(302011057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 54 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 54)

				if (54 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 54)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play302011058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 302011058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play302011059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.475

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(302011058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 19 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 19)

				if (19 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 19)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play302011059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 302011059
		arg_239_1.duration_ = 3.3

		local var_239_0 = {
			zh = 3.3,
			ja = 1.999999999999
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play302011060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1066ui_story = arg_239_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).z)
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles = arg_239_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_239_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1066ui_story"].transform.position).z)
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1066ui_story"].transform.localEulerAngles = arg_239_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1066ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1066ui_story == nil then
				arg_239_1.var_.characterEffect1066ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1066ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1066ui_story then
				arg_239_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_242_4 = 0
			local var_242_5 = 0.3

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(302011059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 12 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 12)

				if (12 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 12)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011059", "story_v_out_302011.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011059", "story_v_out_302011.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_302011", "302011059", "story_v_out_302011.awb")

						arg_239_1:RecordAudio("302011059", var_242_11)
						arg_239_1:RecordAudio("302011059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_302011", "302011059", "story_v_out_302011.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_302011", "302011059", "story_v_out_302011.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play302011060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 302011060
		arg_243_1.duration_ = 7.1

		local var_243_0 = {
			zh = 7.1,
			ja = 1.333
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play302011061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.725

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(302011060)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 29 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 29)

				if (29 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 29)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011060", "story_v_out_302011.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011060", "story_v_out_302011.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_302011", "302011060", "story_v_out_302011.awb")

						arg_243_1:RecordAudio("302011060", var_246_6)
						arg_243_1:RecordAudio("302011060", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_302011", "302011060", "story_v_out_302011.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_302011", "302011060", "story_v_out_302011.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play302011061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 302011061
		arg_247_1.duration_ = 3.67

		local var_247_0 = {
			zh = 3.666,
			ja = 1.999999999999
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play302011062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_0 = 0
			local var_250_1 = 0.4

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(302011061)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 16 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 16)

				if (16 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 16)) > 0 and var_250_1 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011061", "story_v_out_302011.awb") ~= 0 then
					local var_250_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011061", "story_v_out_302011.awb") / 1000

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end

					if var_250_2.prefab_name ~= "" and arg_247_1.actors_[var_250_2.prefab_name] ~= nil then
						local var_250_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_2.prefab_name].transform, "story_v_out_302011", "302011061", "story_v_out_302011.awb")

						arg_247_1:RecordAudio("302011061", var_250_7)
						arg_247_1:RecordAudio("302011061", var_250_7)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_302011", "302011061", "story_v_out_302011.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_302011", "302011061", "story_v_out_302011.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play302011062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 302011062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play302011063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1066ui_story"]) and arg_251_1.var_.characterEffect1066ui_story == nil then
				arg_251_1.var_.characterEffect1066ui_story = arg_251_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1066ui_story"]) then
				if arg_251_1.var_.characterEffect1066ui_story and not isNil(arg_251_1.actors_["1066ui_story"]) then
					arg_251_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1066ui_story"]) and arg_251_1.var_.characterEffect1066ui_story then
				arg_251_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.85

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(302011062).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 34 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 34)

				if (34 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 34)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play302011063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 302011063
		arg_255_1.duration_ = 6.03

		local var_255_0 = {
			zh = 6.033,
			ja = 1.999999999999
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play302011064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1066ui_story"]) and arg_255_1.var_.characterEffect1066ui_story == nil then
				arg_255_1.var_.characterEffect1066ui_story = arg_255_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1066ui_story"]) then
				if arg_255_1.var_.characterEffect1066ui_story and not isNil(arg_255_1.actors_["1066ui_story"]) then
					arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1066ui_story"]) and arg_255_1.var_.characterEffect1066ui_story then
				arg_255_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_2 = 0
			local var_258_3 = 0.575

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(302011063)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 23 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 23)

				if (23 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 23)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011063", "story_v_out_302011.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011063", "story_v_out_302011.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_302011", "302011063", "story_v_out_302011.awb")

						arg_255_1:RecordAudio("302011063", var_258_9)
						arg_255_1:RecordAudio("302011063", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_302011", "302011063", "story_v_out_302011.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_302011", "302011063", "story_v_out_302011.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play302011064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 302011064
		arg_259_1.duration_ = 3.07

		local var_259_0 = {
			zh = 3.066,
			ja = 1.333
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play302011065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.325

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(302011064)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 13)

				if (13 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 13)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011064", "story_v_out_302011.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011064", "story_v_out_302011.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_302011", "302011064", "story_v_out_302011.awb")

						arg_259_1:RecordAudio("302011064", var_262_6)
						arg_259_1:RecordAudio("302011064", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_302011", "302011064", "story_v_out_302011.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_302011", "302011064", "story_v_out_302011.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play302011065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 302011065
		arg_263_1.duration_ = 9

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play302011066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_9000

			if arg_263_1.bgs_.MS0201 == nil then
				local var_266_0 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS0201")
				var_266_0.name = "MS0201"
				var_266_0.transform.parent = arg_263_1.stage_.transform
				var_266_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_.MS0201 = var_266_0
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_1 = arg_263_1.bgs_.MS0201

				arg_263_1.bgs_.MS0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_2 = var_266_1:GetComponent("SpriteRenderer")

				if var_266_2 and var_266_2.sprite then
					local var_266_3 = 2 * (var_266_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_1.transform.localScale = Vector3.New(var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "MS0201" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_4 = 3.999999999999

			if 3.999999999999 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_4 + 0.3 and arg_263_1.time_ < var_266_4 + 0.3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_5 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_6 = 2

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_6 then
				local var_266_7 = Color.New(0, 0, 0)

				var_266_7.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_5) / var_266_6)
				arg_263_1.mask_.color = var_266_7
			end

			if arg_263_1.time_ >= var_266_5 + var_266_6 and arg_263_1.time_ < var_266_5 + var_266_6 + arg_266_0 then
				local var_266_8 = Color.New(0, 0, 0)

				var_266_8.a = 1
				arg_263_1.mask_.color = var_266_8
			end

			local var_266_9 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_10 = 2

			if var_266_9 <= arg_263_1.time_ and arg_263_1.time_ < var_266_9 + var_266_10 then
				local var_266_11 = Color.New(0, 0, 0)

				var_266_11.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_9) / var_266_10)
				arg_263_1.mask_.color = var_266_11
			end

			if arg_263_1.time_ >= var_266_9 + var_266_10 and arg_263_1.time_ < var_266_9 + var_266_10 + arg_266_0 then
				local var_266_12 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_12.a = 0
				arg_263_1.mask_.color = var_266_12
			end

			local var_266_13 = arg_263_1.actors_["1066ui_story"].transform

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				arg_263_1.var_.moveOldPos1066ui_story = var_266_13.localPosition
			end

			local var_266_14 = 0.001

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_14 then
				var_266_13.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 1.96599999815226) / var_266_14)
				var_266_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_13.position).x, (manager.ui.mainCamera.transform.position - var_266_13.position).y, (manager.ui.mainCamera.transform.position - var_266_13.position).z)
				var_266_13.localEulerAngles.z = 0
				var_266_13.localEulerAngles.x = 0
				var_266_13.localEulerAngles = var_266_13.localEulerAngles
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_14 and arg_263_1.time_ < 1.96599999815226 + var_266_14 + arg_266_0 then
				var_266_13.localPosition = Vector3.New(0, 100, 0)
				var_266_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_13.position).x, (manager.ui.mainCamera.transform.position - var_266_13.position).y, (manager.ui.mainCamera.transform.position - var_266_13.position).z)
				var_266_13.localEulerAngles.z = 0
				var_266_13.localEulerAngles.x = 0
				var_266_13.localEulerAngles = var_266_13.localEulerAngles
			end

			local var_266_15 = arg_263_1.actors_["1066ui_story"]

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.characterEffect1066ui_story == nil then
				arg_263_1.var_.characterEffect1066ui_story = var_266_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_16 = 0.034000001847744

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_16 and not isNil(var_266_15) then
				if arg_263_1.var_.characterEffect1066ui_story and not isNil(var_266_15) then
					arg_263_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 1.96599999815226) / var_266_16)
				end
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_16 and arg_263_1.time_ < 1.96599999815226 + var_266_16 + arg_266_0 and not isNil(var_266_15) and arg_263_1.var_.characterEffect1066ui_story then
				arg_263_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_17 = arg_263_1.var_.effectsaomiaojiankang1

				if not arg_263_1.var_.effectsaomiaojiankang1 then
					var_266_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_266_17.name = "saomiaojiankang1"
					arg_263_1.var_.effectsaomiaojiankang1 = var_266_17
				else
					var_266_17.transform:SetParent(var_266_9000)
				end

				var_266_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_266_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_266_19 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_266_17.transform.localScale = Vector3.New(var_266_17.transform.localScale.x * var_266_19, var_266_17.transform.localScale.y * var_266_19, var_266_17.transform.localScale.z * var_266_19)
			end

			if 6.66666666666667 < arg_263_1.time_ and arg_263_1.time_ <= 6.66666666666667 + arg_266_0 then
				if arg_263_1.var_.effectsaomiaojiankang1 then
					Object.Destroy(arg_263_1.var_.effectsaomiaojiankang1)

					arg_263_1.var_.effectsaomiaojiankang1 = nil
				end
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_21 = 4
			local var_266_22 = 2.05

			if 4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_23 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_23:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_24 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(302011065).content)

				arg_263_1.text_.text = var_266_24

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_26 = 82 <= 0 and var_266_22 or var_266_22 * (utf8.len(var_266_24) / 82)

				if (82 <= 0 and var_266_22 or var_266_22 * (utf8.len(var_266_24) / 82)) > 0 and var_266_22 < var_266_26 then
					arg_263_1.talkMaxDuration = var_266_26
					var_266_21 = var_266_21 + 0.3

					if var_266_26 + var_266_21 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_26 + var_266_21
					end
				end

				arg_263_1.text_.text = var_266_24
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_27 = var_266_21 + 0.3
			local var_266_28 = math.max(var_266_22, arg_263_1.talkMaxDuration)

			if var_266_21 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_27 + var_266_28 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_27) / var_266_28

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_27 + var_266_28 and arg_263_1.time_ < var_266_27 + var_266_28 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play302011066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 302011066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play302011067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.575

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(302011066).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 63 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 63)

				if (63 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 63)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play302011067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 302011067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play302011068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.45

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(302011067).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 18 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 18)

				if (18 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 18)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play302011068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 302011068
		arg_277_1.duration_ = 5.23

		local var_277_0 = {
			zh = 4.59933333333333,
			ja = 5.23333333333333
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play302011069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_280_0 = 0.6

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				local var_280_1, var_280_2 = math.modf((arg_277_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_280_2 * 0.13, var_280_2 * 0.13, var_280_2 * 0.13) + arg_277_1.var_.shakeOldPos
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				manager.ui.mainCamera.transform.localPosition = arg_277_1.var_.shakeOldPos
			end

			local var_280_3 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_3 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= var_280_3 + 0.6 and arg_277_1.time_ < var_280_3 + 0.6 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end

			if arg_277_1.frameCnt_ <= 1 then
				arg_277_1.dialog_:SetActive(false)
			end

			local var_280_4 = 0.433333333333333
			local var_280_5 = 0.45

			if 0.433333333333333 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0

				arg_277_1.dialog_:SetActive(true)

				arg_277_1.dialogCg_.alpha = 0

				local var_280_6 = LeanTween.value(arg_277_1.dialog_, 0, 1, 0.3)

				var_280_6:setOnUpdate(LuaHelper.FloatAction(function(arg_281_0)
					arg_277_1.dialogCg_.alpha = arg_281_0
				end))
				var_280_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_277_1.dialog_)
					var_280_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_277_1.duration_ = arg_277_1.duration_ + 0.3

				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_7 = arg_277_1:GetWordFromCfg(302011068)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 18 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_8) / 18)

				if (18 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_8) / 18)) > 0 and var_280_5 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10
					var_280_4 = var_280_4 + 0.3

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011068", "story_v_out_302011.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_302011", "302011068", "story_v_out_302011.awb") / 1000

					if var_280_11 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_4
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_302011", "302011068", "story_v_out_302011.awb")

						arg_277_1:RecordAudio("302011068", var_280_12)
						arg_277_1:RecordAudio("302011068", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_302011", "302011068", "story_v_out_302011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_302011", "302011068", "story_v_out_302011.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = var_280_4 + 0.3
			local var_280_14 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 + 0.3 <= arg_277_1.time_ and arg_277_1.time_ < var_280_13 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_13) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_13 + var_280_14 and arg_277_1.time_ < var_280_13 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play302011069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 302011069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play302011070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.55

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(302011069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 22 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 22)

				if (22 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 22)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play302011070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 302011070
		arg_287_1.duration_ = 15.97

		local var_287_0 = {
			zh = 12.3,
			ja = 15.966
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play302011071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.55

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_1")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(302011070)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 62 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 62)

				if (62 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 62)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011070", "story_v_out_302011.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011070", "story_v_out_302011.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_302011", "302011070", "story_v_out_302011.awb")

						arg_287_1:RecordAudio("302011070", var_290_6)
						arg_287_1:RecordAudio("302011070", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_302011", "302011070", "story_v_out_302011.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_302011", "302011070", "story_v_out_302011.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play302011071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 302011071
		arg_291_1.duration_ = 6.17

		local var_291_0 = {
			zh = 6.166,
			ja = 1.333
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play302011072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.8

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(302011071)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 32 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 32)

				if (32 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 32)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011071", "story_v_out_302011.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011071", "story_v_out_302011.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_302011", "302011071", "story_v_out_302011.awb")

						arg_291_1:RecordAudio("302011071", var_294_6)
						arg_291_1:RecordAudio("302011071", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_302011", "302011071", "story_v_out_302011.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_302011", "302011071", "story_v_out_302011.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play302011072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 302011072
		arg_295_1.duration_ = 10.03

		local var_295_0 = {
			zh = 10.033,
			ja = 8.033
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play302011073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["1066ui_story"]) and arg_295_1.var_.characterEffect1066ui_story == nil then
				arg_295_1.var_.characterEffect1066ui_story = arg_295_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["1066ui_story"]) then
				if arg_295_1.var_.characterEffect1066ui_story and not isNil(arg_295_1.actors_["1066ui_story"]) then
					arg_295_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["1066ui_story"]) and arg_295_1.var_.characterEffect1066ui_story then
				arg_295_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 1.225

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:GetWordFromCfg(302011072)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_6 = 49 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_4) / 49)

				if (49 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_4) / 49)) > 0 and var_298_2 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011072", "story_v_out_302011.awb") ~= 0 then
					local var_298_7 = manager.audio:GetVoiceLength("story_v_out_302011", "302011072", "story_v_out_302011.awb") / 1000

					if var_298_7 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_1
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_302011", "302011072", "story_v_out_302011.awb")

						arg_295_1:RecordAudio("302011072", var_298_8)
						arg_295_1:RecordAudio("302011072", var_298_8)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_302011", "302011072", "story_v_out_302011.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_302011", "302011072", "story_v_out_302011.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_9 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_9 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_9

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_9 and arg_295_1.time_ < var_298_1 + var_298_9 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play302011073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 302011073
		arg_299_1.duration_ = 3.9

		local var_299_0 = {
			zh = 3.9,
			ja = 1.333
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play302011074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.475

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(302011073)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 19 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 19)

				if (19 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 19)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011073", "story_v_out_302011.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011073", "story_v_out_302011.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_302011", "302011073", "story_v_out_302011.awb")

						arg_299_1:RecordAudio("302011073", var_302_6)
						arg_299_1:RecordAudio("302011073", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_302011", "302011073", "story_v_out_302011.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_302011", "302011073", "story_v_out_302011.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play302011074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 302011074
		arg_303_1.duration_ = 4.7

		local var_303_0 = {
			zh = 3.766,
			ja = 4.7
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play302011075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) and arg_303_1.var_.characterEffect1066ui_story == nil then
				arg_303_1.var_.characterEffect1066ui_story = arg_303_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) then
				if arg_303_1.var_.characterEffect1066ui_story and not isNil(arg_303_1.actors_["1066ui_story"]) then
					arg_303_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1066ui_story"]) and arg_303_1.var_.characterEffect1066ui_story then
				arg_303_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.35

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:GetWordFromCfg(302011074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_6 = 14 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 14)

				if (14 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_4) / 14)) > 0 and var_306_2 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011074", "story_v_out_302011.awb") ~= 0 then
					local var_306_7 = manager.audio:GetVoiceLength("story_v_out_302011", "302011074", "story_v_out_302011.awb") / 1000

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_302011", "302011074", "story_v_out_302011.awb")

						arg_303_1:RecordAudio("302011074", var_306_8)
						arg_303_1:RecordAudio("302011074", var_306_8)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_302011", "302011074", "story_v_out_302011.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_302011", "302011074", "story_v_out_302011.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_9 and arg_303_1.time_ < var_306_1 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play302011075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 302011075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play302011076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1066ui_story = arg_307_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).z)
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles = arg_307_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1066ui_story"].transform.position).z)
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1066ui_story"].transform.localEulerAngles = arg_307_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1033ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1033ui_story = var_310_1.localPosition
			end

			local var_310_2 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 then
				var_310_1.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_2)
				var_310_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_1.position).x, (manager.ui.mainCamera.transform.position - var_310_1.position).y, (manager.ui.mainCamera.transform.position - var_310_1.position).z)
				var_310_1.localEulerAngles.z = 0
				var_310_1.localEulerAngles.x = 0
				var_310_1.localEulerAngles = var_310_1.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 then
				var_310_1.localPosition = Vector3.New(0, 100, 0)
				var_310_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_1.position).x, (manager.ui.mainCamera.transform.position - var_310_1.position).y, (manager.ui.mainCamera.transform.position - var_310_1.position).z)
				var_310_1.localEulerAngles.z = 0
				var_310_1.localEulerAngles.x = 0
				var_310_1.localEulerAngles = var_310_1.localEulerAngles
			end

			local var_310_3 = 0
			local var_310_4 = 1.475

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_5 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(302011075).content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 59 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 59)

				if (59 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_5) / 59)) > 0 and var_310_4 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_3) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_8 and arg_307_1.time_ < var_310_3 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play302011076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 302011076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play302011077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 1.425

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(302011076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 57 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 57)

				if (57 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 57)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play302011077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 302011077
		arg_315_1.duration_ = 8.33

		local var_315_0 = {
			zh = 6.533,
			ja = 8.333
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play302011078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.725

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:GetWordFromCfg(302011077)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 29 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 29)

				if (29 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 29)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011077", "story_v_out_302011.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011077", "story_v_out_302011.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_302011", "302011077", "story_v_out_302011.awb")

						arg_315_1:RecordAudio("302011077", var_318_6)
						arg_315_1:RecordAudio("302011077", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_302011", "302011077", "story_v_out_302011.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_302011", "302011077", "story_v_out_302011.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play302011078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 302011078
		arg_319_1.duration_ = 10.5

		local var_319_0 = {
			zh = 10.5,
			ja = 9.166
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play302011079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.05

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(302011078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 42 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 42)

				if (42 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 42)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011078", "story_v_out_302011.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011078", "story_v_out_302011.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_302011", "302011078", "story_v_out_302011.awb")

						arg_319_1:RecordAudio("302011078", var_322_6)
						arg_319_1:RecordAudio("302011078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_302011", "302011078", "story_v_out_302011.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_302011", "302011078", "story_v_out_302011.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play302011079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 302011079
		arg_323_1.duration_ = 2.53

		local var_323_0 = {
			zh = 2.533,
			ja = 1.333
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play302011080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1066ui_story"]) and arg_323_1.var_.characterEffect1066ui_story == nil then
				arg_323_1.var_.characterEffect1066ui_story = arg_323_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1066ui_story"]) then
				if arg_323_1.var_.characterEffect1066ui_story and not isNil(arg_323_1.actors_["1066ui_story"]) then
					arg_323_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1066ui_story"]) and arg_323_1.var_.characterEffect1066ui_story then
				arg_323_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_326_2 = 0
			local var_326_3 = 0.2

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(302011079)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 8 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 8)

				if (8 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 8)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011079", "story_v_out_302011.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011079", "story_v_out_302011.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_out_302011", "302011079", "story_v_out_302011.awb")

						arg_323_1:RecordAudio("302011079", var_326_9)
						arg_323_1:RecordAudio("302011079", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_302011", "302011079", "story_v_out_302011.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_302011", "302011079", "story_v_out_302011.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play302011080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 302011080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play302011081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1066ui_story"]) and arg_327_1.var_.characterEffect1066ui_story == nil then
				arg_327_1.var_.characterEffect1066ui_story = arg_327_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1066ui_story"]) then
				if arg_327_1.var_.characterEffect1066ui_story and not isNil(arg_327_1.actors_["1066ui_story"]) then
					arg_327_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1066ui_story"]) and arg_327_1.var_.characterEffect1066ui_story then
				arg_327_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 1

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(302011080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 40 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 40)

				if (40 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 40)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play302011081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 302011081
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play302011082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.35

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(302011081).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 54 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 54)

				if (54 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 54)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play302011082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 302011082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play302011083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.3

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(302011082).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 12 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 12)

				if (12 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 12)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play302011083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 302011083
		arg_339_1.duration_ = 5.13

		local var_339_0 = {
			zh = 5.133,
			ja = 1.333
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play302011084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.475

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(302011083)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 19 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 19)

				if (19 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 19)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011083", "story_v_out_302011.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011083", "story_v_out_302011.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_302011", "302011083", "story_v_out_302011.awb")

						arg_339_1:RecordAudio("302011083", var_342_6)
						arg_339_1:RecordAudio("302011083", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_302011", "302011083", "story_v_out_302011.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_302011", "302011083", "story_v_out_302011.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play302011084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 302011084
		arg_343_1.duration_ = 11.23

		local var_343_0 = {
			zh = 8.933,
			ja = 11.233
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play302011085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1066ui_story"]) and arg_343_1.var_.characterEffect1066ui_story == nil then
				arg_343_1.var_.characterEffect1066ui_story = arg_343_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1066ui_story"]) then
				if arg_343_1.var_.characterEffect1066ui_story and not isNil(arg_343_1.actors_["1066ui_story"]) then
					arg_343_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1066ui_story"]) and arg_343_1.var_.characterEffect1066ui_story then
				arg_343_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.825

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(302011084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 33 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 33)

				if (33 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 33)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011084", "story_v_out_302011.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_302011", "302011084", "story_v_out_302011.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_302011", "302011084", "story_v_out_302011.awb")

						arg_343_1:RecordAudio("302011084", var_346_8)
						arg_343_1:RecordAudio("302011084", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_302011", "302011084", "story_v_out_302011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_302011", "302011084", "story_v_out_302011.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play302011085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 302011085
		arg_347_1.duration_ = 2.53

		local var_347_0 = {
			zh = 2.533,
			ja = 1.333
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play302011086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.25

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(302011085)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 10 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 10)

				if (10 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 10)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011085", "story_v_out_302011.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011085", "story_v_out_302011.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_302011", "302011085", "story_v_out_302011.awb")

						arg_347_1:RecordAudio("302011085", var_350_6)
						arg_347_1:RecordAudio("302011085", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_302011", "302011085", "story_v_out_302011.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_302011", "302011085", "story_v_out_302011.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play302011086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 302011086
		arg_351_1.duration_ = 2.27

		local var_351_0 = {
			zh = 1.866,
			ja = 2.266
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play302011087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1066ui_story"]) and arg_351_1.var_.characterEffect1066ui_story == nil then
				arg_351_1.var_.characterEffect1066ui_story = arg_351_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1066ui_story"]) then
				if arg_351_1.var_.characterEffect1066ui_story and not isNil(arg_351_1.actors_["1066ui_story"]) then
					arg_351_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1066ui_story"]) and arg_351_1.var_.characterEffect1066ui_story then
				arg_351_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.175

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(302011086)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 7 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 7)

				if (7 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 7)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011086", "story_v_out_302011.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_302011", "302011086", "story_v_out_302011.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_302011", "302011086", "story_v_out_302011.awb")

						arg_351_1:RecordAudio("302011086", var_354_8)
						arg_351_1:RecordAudio("302011086", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_302011", "302011086", "story_v_out_302011.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_302011", "302011086", "story_v_out_302011.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play302011087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 302011087
		arg_355_1.duration_ = 11.03

		local var_355_0 = {
			zh = 6.366,
			ja = 11.033
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play302011088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.875

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:GetWordFromCfg(302011087)
				local var_358_2 = arg_355_1:FormatText(var_358_1.content)

				arg_355_1.text_.text = var_358_2

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_4 = 35 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 35)

				if (35 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_2) / 35)) > 0 and var_358_0 < var_358_4 then
					arg_355_1.talkMaxDuration = var_358_4

					if var_358_4 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_4 + 0
					end
				end

				arg_355_1.text_.text = var_358_2
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011087", "story_v_out_302011.awb") ~= 0 then
					local var_358_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011087", "story_v_out_302011.awb") / 1000

					if var_358_5 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + 0
					end

					if var_358_1.prefab_name ~= "" and arg_355_1.actors_[var_358_1.prefab_name] ~= nil then
						local var_358_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_1.prefab_name].transform, "story_v_out_302011", "302011087", "story_v_out_302011.awb")

						arg_355_1:RecordAudio("302011087", var_358_6)
						arg_355_1:RecordAudio("302011087", var_358_6)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_302011", "302011087", "story_v_out_302011.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_302011", "302011087", "story_v_out_302011.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play302011088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 302011088
		arg_359_1.duration_ = 8.3

		local var_359_0 = {
			zh = 0.999999999999,
			ja = 8.3
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play302011089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.075

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_5")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:GetWordFromCfg(302011088)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 3 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 3)

				if (3 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 3)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011088", "story_v_out_302011.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011088", "story_v_out_302011.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_302011", "302011088", "story_v_out_302011.awb")

						arg_359_1:RecordAudio("302011088", var_362_6)
						arg_359_1:RecordAudio("302011088", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_302011", "302011088", "story_v_out_302011.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_302011", "302011088", "story_v_out_302011.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play302011089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 302011089
		arg_363_1.duration_ = 7

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play302011090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_9000

			if arg_363_1.bgs_.MS0201a == nil then
				local var_366_0 = Object.Instantiate(arg_363_1.paintGo_)

				var_366_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS0201a")
				var_366_0.name = "MS0201a"
				var_366_0.transform.parent = arg_363_1.stage_.transform
				var_366_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.bgs_.MS0201a = var_366_0
			end

			if 0.666666666666667 < arg_363_1.time_ and arg_363_1.time_ <= 0.666666666666667 + arg_366_0 then
				local var_366_1 = arg_363_1.bgs_.MS0201a

				arg_363_1.bgs_.MS0201a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_366_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_366_2 = var_366_1:GetComponent("SpriteRenderer")

				if var_366_2 and var_366_2.sprite then
					local var_366_3 = 2 * (var_366_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_366_1.transform.localScale = Vector3.New(var_366_3 / var_366_2.sprite.bounds.size.y < var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x and var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x or var_366_3 / var_366_2.sprite.bounds.size.y, var_366_3 / var_366_2.sprite.bounds.size.y < var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x and var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x or var_366_3 / var_366_2.sprite.bounds.size.y, 0)
				end

				for iter_366_0, iter_366_1 in pairs(arg_363_1.bgs_) do
					if iter_366_0 ~= "MS0201a" then
						iter_366_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_366_4 = 2

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			if arg_363_1.time_ >= var_366_4 + 0.3 and arg_363_1.time_ < var_366_4 + 0.3 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				local var_366_5 = arg_363_1.var_.effectchongguolai1

				if not arg_363_1.var_.effectchongguolai1 then
					var_366_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_366_5.name = "chongguolai1"
					arg_363_1.var_.effectchongguolai1 = var_366_5
				else
					var_366_5.transform:SetParent(var_366_9000)
				end

				var_366_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_366_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_366_5.transform.localScale = Vector3.New(var_366_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_366_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_366_5.transform.localScale.z)
			end

			local var_366_7 = arg_363_1.bgs_.MS0201a.transform

			if 0.666666666666667 < arg_363_1.time_ and arg_363_1.time_ <= 0.666666666666667 + arg_366_0 then
				arg_363_1.var_.moveOldPosMS0201a = var_366_7.localPosition
			end

			local var_366_8 = 2

			if 0.666666666666667 <= arg_363_1.time_ and arg_363_1.time_ < 0.666666666666667 + var_366_8 then
				var_366_7.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPosMS0201a, Vector3.New(0, 0.5, 5), (arg_363_1.time_ - 0.666666666666667) / var_366_8)
			end

			if arg_363_1.time_ >= 0.666666666666667 + var_366_8 and arg_363_1.time_ < 0.666666666666667 + var_366_8 + arg_366_0 then
				var_366_7.localPosition = Vector3.New(0, 0.5, 5)
			end

			local var_366_9 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_9 + arg_366_0 then
				arg_363_1.allBtn_.enabled = false
			end

			if arg_363_1.time_ >= var_366_9 + 2.66666666666667 and arg_363_1.time_ < var_366_9 + 2.66666666666667 + arg_366_0 then
				arg_363_1.allBtn_.enabled = true
			end

			if arg_363_1.frameCnt_ <= 1 then
				arg_363_1.dialog_:SetActive(false)
			end

			local var_366_10 = 2
			local var_366_11 = 1.475

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				arg_363_1.dialog_:SetActive(true)

				arg_363_1.dialogCg_.alpha = 0

				local var_366_12 = LeanTween.value(arg_363_1.dialog_, 0, 1, 0.3)

				var_366_12:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_363_1.dialogCg_.alpha = arg_367_0
				end))
				var_366_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_363_1.dialog_)
					var_366_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_363_1.duration_ = arg_363_1.duration_ + 0.3

				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_13 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(302011089).content)

				arg_363_1.text_.text = var_366_13

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_15 = 59 <= 0 and var_366_11 or var_366_11 * (utf8.len(var_366_13) / 59)

				if (59 <= 0 and var_366_11 or var_366_11 * (utf8.len(var_366_13) / 59)) > 0 and var_366_11 < var_366_15 then
					arg_363_1.talkMaxDuration = var_366_15
					var_366_10 = var_366_10 + 0.3

					if var_366_15 + var_366_10 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_15 + var_366_10
					end
				end

				arg_363_1.text_.text = var_366_13
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = var_366_10 + 0.3
			local var_366_17 = math.max(var_366_11, arg_363_1.talkMaxDuration)

			if var_366_10 + 0.3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_16 + var_366_17 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_16) / var_366_17

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_16 + var_366_17 and arg_363_1.time_ < var_366_16 + var_366_17 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0201a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7),
					endPos = Vector3.New(0, 0.5, 5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play302011090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 302011090
		arg_369_1.duration_ = 6.8

		local var_369_0 = {
			zh = 5,
			ja = 6.8
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play302011091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1033ui_story"]) and arg_369_1.var_.characterEffect1033ui_story == nil then
				arg_369_1.var_.characterEffect1033ui_story = arg_369_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1033ui_story"]) then
				if arg_369_1.var_.characterEffect1033ui_story and not isNil(arg_369_1.actors_["1033ui_story"]) then
					arg_369_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1033ui_story"]) and arg_369_1.var_.characterEffect1033ui_story then
				arg_369_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_372_2 = 0
			local var_372_3 = 0.675

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_6")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_4 = arg_369_1:GetWordFromCfg(302011090)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 27 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 27)

				if (27 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 27)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011090", "story_v_out_302011.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011090", "story_v_out_302011.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_302011", "302011090", "story_v_out_302011.awb")

						arg_369_1:RecordAudio("302011090", var_372_9)
						arg_369_1:RecordAudio("302011090", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_302011", "302011090", "story_v_out_302011.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_302011", "302011090", "story_v_out_302011.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_10 and arg_369_1.time_ < var_372_2 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play302011091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 302011091
		arg_373_1.duration_ = 11.8

		local var_373_0 = {
			zh = 3.5,
			ja = 11.8
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play302011092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.425

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_5")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(302011091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 17 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 17)

				if (17 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 17)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011091", "story_v_out_302011.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011091", "story_v_out_302011.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_302011", "302011091", "story_v_out_302011.awb")

						arg_373_1:RecordAudio("302011091", var_376_6)
						arg_373_1:RecordAudio("302011091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_302011", "302011091", "story_v_out_302011.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_302011", "302011091", "story_v_out_302011.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play302011092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 302011092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play302011093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1033ui_story"]) and arg_377_1.var_.characterEffect1033ui_story == nil then
				arg_377_1.var_.characterEffect1033ui_story = arg_377_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1033ui_story"]) then
				if arg_377_1.var_.characterEffect1033ui_story and not isNil(arg_377_1.actors_["1033ui_story"]) then
					arg_377_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1033ui_story"]) and arg_377_1.var_.characterEffect1033ui_story then
				arg_377_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 0.675

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(302011092).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 27 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 27)

				if (27 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 27)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play302011093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 302011093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play302011094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.525

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(302011093).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 21 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 21)

				if (21 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 21)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play302011094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 302011094
		arg_385_1.duration_ = 7.7

		local var_385_0 = {
			zh = 7.7,
			ja = 1.333
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play302011095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 1

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(302011094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 40 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 40)

				if (40 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 40)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011094", "story_v_out_302011.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011094", "story_v_out_302011.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_302011", "302011094", "story_v_out_302011.awb")

						arg_385_1:RecordAudio("302011094", var_388_6)
						arg_385_1:RecordAudio("302011094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_302011", "302011094", "story_v_out_302011.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_302011", "302011094", "story_v_out_302011.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play302011095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 302011095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play302011096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.25

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(302011095).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 10 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 10)

				if (10 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 10)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play302011096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 302011096
		arg_393_1.duration_ = 3.3

		local var_393_0 = {
			zh = 3.3,
			ja = 1.333
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play302011097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.375

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(302011096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 15)

				if (15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 15)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011096", "story_v_out_302011.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011096", "story_v_out_302011.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_302011", "302011096", "story_v_out_302011.awb")

						arg_393_1:RecordAudio("302011096", var_396_6)
						arg_393_1:RecordAudio("302011096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_302011", "302011096", "story_v_out_302011.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_302011", "302011096", "story_v_out_302011.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play302011097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 302011097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play302011098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.625

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(302011097).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 25 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 25)

				if (25 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 25)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play302011098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 302011098
		arg_401_1.duration_ = 3.9

		local var_401_0 = {
			zh = 3.9,
			ja = 1.333
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play302011099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.425

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(302011098)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 17 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 17)

				if (17 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 17)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011098", "story_v_out_302011.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011098", "story_v_out_302011.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_302011", "302011098", "story_v_out_302011.awb")

						arg_401_1:RecordAudio("302011098", var_404_6)
						arg_401_1:RecordAudio("302011098", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_302011", "302011098", "story_v_out_302011.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_302011", "302011098", "story_v_out_302011.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play302011099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 302011099
		arg_405_1.duration_ = 7.93

		local var_405_0 = {
			zh = 7.933,
			ja = 1.333
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play302011100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.975

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(302011099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 39 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 39)

				if (39 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 39)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011099", "story_v_out_302011.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011099", "story_v_out_302011.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_302011", "302011099", "story_v_out_302011.awb")

						arg_405_1:RecordAudio("302011099", var_408_6)
						arg_405_1:RecordAudio("302011099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_302011", "302011099", "story_v_out_302011.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_302011", "302011099", "story_v_out_302011.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play302011100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 302011100
		arg_409_1.duration_ = 10.2

		local var_409_0 = {
			zh = 9.533,
			ja = 10.2
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play302011101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1033ui_story"]) and arg_409_1.var_.characterEffect1033ui_story == nil then
				arg_409_1.var_.characterEffect1033ui_story = arg_409_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1033ui_story"]) then
				if arg_409_1.var_.characterEffect1033ui_story and not isNil(arg_409_1.actors_["1033ui_story"]) then
					arg_409_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1033ui_story"]) and arg_409_1.var_.characterEffect1033ui_story then
				arg_409_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_412_2 = 0
			local var_412_3 = 1.2

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_2 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:GetWordFromCfg(302011100)
				local var_412_5 = arg_409_1:FormatText(var_412_4.content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 47 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 47)

				if (47 <= 0 and var_412_3 or var_412_3 * (utf8.len(var_412_5) / 47)) > 0 and var_412_3 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_2
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011100", "story_v_out_302011.awb") ~= 0 then
					local var_412_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011100", "story_v_out_302011.awb") / 1000

					if var_412_8 + var_412_2 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_2
					end

					if var_412_4.prefab_name ~= "" and arg_409_1.actors_[var_412_4.prefab_name] ~= nil then
						local var_412_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_4.prefab_name].transform, "story_v_out_302011", "302011100", "story_v_out_302011.awb")

						arg_409_1:RecordAudio("302011100", var_412_9)
						arg_409_1:RecordAudio("302011100", var_412_9)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_302011", "302011100", "story_v_out_302011.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_302011", "302011100", "story_v_out_302011.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_10 = math.max(var_412_3, arg_409_1.talkMaxDuration)

			if var_412_2 <= arg_409_1.time_ and arg_409_1.time_ < var_412_2 + var_412_10 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_2) / var_412_10

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_2 + var_412_10 and arg_409_1.time_ < var_412_2 + var_412_10 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play302011101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 302011101
		arg_413_1.duration_ = 13.03

		local var_413_0 = {
			zh = 9.733,
			ja = 13.033
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play302011102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 1.1

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:GetWordFromCfg(302011101)
				local var_416_2 = arg_413_1:FormatText(var_416_1.content)

				arg_413_1.text_.text = var_416_2

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 44 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 44)

				if (44 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 44)) > 0 and var_416_0 < var_416_4 then
					arg_413_1.talkMaxDuration = var_416_4

					if var_416_4 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_4 + 0
					end
				end

				arg_413_1.text_.text = var_416_2
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011101", "story_v_out_302011.awb") ~= 0 then
					local var_416_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011101", "story_v_out_302011.awb") / 1000

					if var_416_5 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + 0
					end

					if var_416_1.prefab_name ~= "" and arg_413_1.actors_[var_416_1.prefab_name] ~= nil then
						local var_416_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_1.prefab_name].transform, "story_v_out_302011", "302011101", "story_v_out_302011.awb")

						arg_413_1:RecordAudio("302011101", var_416_6)
						arg_413_1:RecordAudio("302011101", var_416_6)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_302011", "302011101", "story_v_out_302011.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_302011", "302011101", "story_v_out_302011.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play302011102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 302011102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play302011103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1033ui_story"]) and arg_417_1.var_.characterEffect1033ui_story == nil then
				arg_417_1.var_.characterEffect1033ui_story = arg_417_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1033ui_story"]) then
				if arg_417_1.var_.characterEffect1033ui_story and not isNil(arg_417_1.actors_["1033ui_story"]) then
					arg_417_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1033ui_story"]) and arg_417_1.var_.characterEffect1033ui_story then
				arg_417_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.5

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(302011102).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 20 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 20)

				if (20 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 20)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play302011103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 302011103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play302011104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.275

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(302011103).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 11 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 11)

				if (11 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 11)) > 0 and var_424_0 < var_424_3 then
					arg_421_1.talkMaxDuration = var_424_3

					if var_424_3 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_3 + 0
					end
				end

				arg_421_1.text_.text = var_424_1
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_4 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_4

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play302011104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 302011104
		arg_425_1.duration_ = 5.8

		local var_425_0 = {
			zh = 5.8,
			ja = 1.333
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play302011105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.725

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:GetWordFromCfg(302011104)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 29 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 29)

				if (29 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 29)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011104", "story_v_out_302011.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011104", "story_v_out_302011.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_302011", "302011104", "story_v_out_302011.awb")

						arg_425_1:RecordAudio("302011104", var_428_6)
						arg_425_1:RecordAudio("302011104", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_302011", "302011104", "story_v_out_302011.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_302011", "302011104", "story_v_out_302011.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play302011105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 302011105
		arg_429_1.duration_ = 5.23

		local var_429_0 = {
			zh = 5.233,
			ja = 1.333
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play302011106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.575

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:GetWordFromCfg(302011105)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 23 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 23)

				if (23 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 23)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011105", "story_v_out_302011.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011105", "story_v_out_302011.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_out_302011", "302011105", "story_v_out_302011.awb")

						arg_429_1:RecordAudio("302011105", var_432_6)
						arg_429_1:RecordAudio("302011105", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_302011", "302011105", "story_v_out_302011.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_302011", "302011105", "story_v_out_302011.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play302011106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 302011106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play302011107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.575

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(302011106).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 23 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 23)

				if (23 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 23)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play302011107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 302011107
		arg_437_1.duration_ = 5.48

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play302011108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPosMS0201a = arg_437_1.bgs_.MS0201a.transform.localPosition
			end

			local var_440_0 = 2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.bgs_.MS0201a.transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPosMS0201a, Vector3.New(2.73, -0.2, 4), (arg_437_1.time_ - 0) / var_440_0)
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.bgs_.MS0201a.transform.localPosition = Vector3.New(2.73, -0.2, 4)
			end

			local var_440_1 = 0

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			if arg_437_1.time_ >= var_440_1 + 2 and arg_437_1.time_ < var_440_1 + 2 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			if arg_437_1.frameCnt_ <= 1 then
				arg_437_1.dialog_:SetActive(false)
			end

			local var_440_2 = 0.475
			local var_440_3 = 1.525

			if 0.475 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0

				arg_437_1.dialog_:SetActive(true)

				arg_437_1.dialogCg_.alpha = 0

				local var_440_4 = LeanTween.value(arg_437_1.dialog_, 0, 1, 0.3)

				var_440_4:setOnUpdate(LuaHelper.FloatAction(function(arg_441_0)
					arg_437_1.dialogCg_.alpha = arg_441_0
				end))
				var_440_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_437_1.dialog_)
					var_440_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_437_1.duration_ = arg_437_1.duration_ + 0.3

				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_5 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(302011107).content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 61 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 61)

				if (61 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 61)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7
					var_440_2 = var_440_2 + 0.3

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = var_440_2 + 0.3
			local var_440_9 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 + 0.3 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_9 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_9

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_9 and arg_437_1.time_ < var_440_8 + var_440_9 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0201a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 5),
					endPos = Vector3.New(2.73, -0.2, 4),
					easeType = LeanTweenType.easeOutCubic
				}
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play302011108 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 302011108
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play302011109(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.6

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_443_1.callingController_:SetSelectedState("normal")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(302011108).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 24 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 24)

				if (24 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 24)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play302011109 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 302011109
		arg_447_1.duration_ = 3.42

		local var_447_0 = {
			zh = 3.425,
			ja = 3.158
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play302011110(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPosMS0201a = arg_447_1.bgs_.MS0201a.transform.localPosition
			end

			local var_450_0 = 2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.bgs_.MS0201a.transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPosMS0201a, Vector3.New(0, 1, 6), (arg_447_1.time_ - 0) / var_450_0)
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.bgs_.MS0201a.transform.localPosition = Vector3.New(0, 1, 6)
			end

			local var_450_1 = 0

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			if arg_447_1.time_ >= var_450_1 + 2 and arg_447_1.time_ < var_450_1 + 2 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_2 = 1.825
			local var_450_3 = 0.175

			if 1.825 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_4 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_4:setOnUpdate(LuaHelper.FloatAction(function(arg_451_0)
					arg_447_1.dialogCg_.alpha = arg_451_0
				end))
				var_450_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_5 = arg_447_1:GetWordFromCfg(302011109)
				local var_450_6 = arg_447_1:FormatText(var_450_5.content)

				arg_447_1.text_.text = var_450_6

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_8 = 7 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_6) / 7)

				if (7 <= 0 and var_450_3 or var_450_3 * (utf8.len(var_450_6) / 7)) > 0 and var_450_3 < var_450_8 then
					arg_447_1.talkMaxDuration = var_450_8
					var_450_2 = var_450_2 + 0.3

					if var_450_8 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_2
					end
				end

				arg_447_1.text_.text = var_450_6
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011109", "story_v_out_302011.awb") ~= 0 then
					local var_450_9 = manager.audio:GetVoiceLength("story_v_out_302011", "302011109", "story_v_out_302011.awb") / 1000

					if var_450_9 + var_450_2 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_9 + var_450_2
					end

					if var_450_5.prefab_name ~= "" and arg_447_1.actors_[var_450_5.prefab_name] ~= nil then
						local var_450_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_5.prefab_name].transform, "story_v_out_302011", "302011109", "story_v_out_302011.awb")

						arg_447_1:RecordAudio("302011109", var_450_10)
						arg_447_1:RecordAudio("302011109", var_450_10)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_302011", "302011109", "story_v_out_302011.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_302011", "302011109", "story_v_out_302011.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_11 = var_450_2 + 0.3
			local var_450_12 = math.max(var_450_3, arg_447_1.talkMaxDuration)

			if var_450_2 + 0.3 <= arg_447_1.time_ and arg_447_1.time_ < var_450_11 + var_450_12 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_11) / var_450_12

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_11 + var_450_12 and arg_447_1.time_ < var_450_11 + var_450_12 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS0201a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(2.73, -0.2, 4),
					endPos = Vector3.New(0, 1, 6),
					easeType = LeanTweenType.easeOutCubic
				}
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play302011110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 302011110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play302011111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.05

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(302011110).content)

				arg_453_1.text_.text = var_456_1

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_3 = 2 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 2)

				if (2 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_1) / 2)) > 0 and var_456_0 < var_456_3 then
					arg_453_1.talkMaxDuration = var_456_3

					if var_456_3 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_3 + 0
					end
				end

				arg_453_1.text_.text = var_456_1
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_4 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_4 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_4

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_4 and arg_453_1.time_ < 0 + var_456_4 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play302011111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 302011111
		arg_457_1.duration_ = 6.2

		local var_457_0 = {
			zh = 6.2,
			ja = 1.333
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play302011112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.725

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(302011111)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 29 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 29)

				if (29 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 29)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011111", "story_v_out_302011.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011111", "story_v_out_302011.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_302011", "302011111", "story_v_out_302011.awb")

						arg_457_1:RecordAudio("302011111", var_460_6)
						arg_457_1:RecordAudio("302011111", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_302011", "302011111", "story_v_out_302011.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_302011", "302011111", "story_v_out_302011.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play302011112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 302011112
		arg_461_1.duration_ = 5.5

		local var_461_0 = {
			zh = 5.5,
			ja = 1.333
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play302011113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.7

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:GetWordFromCfg(302011112)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 28 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 28)

				if (28 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 28)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011112", "story_v_out_302011.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011112", "story_v_out_302011.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_302011", "302011112", "story_v_out_302011.awb")

						arg_461_1:RecordAudio("302011112", var_464_6)
						arg_461_1:RecordAudio("302011112", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_302011", "302011112", "story_v_out_302011.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_302011", "302011112", "story_v_out_302011.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play302011113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 302011113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play302011114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.5

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(302011113).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 20 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 20)

				if (20 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 20)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play302011114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 302011114
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play302011115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.775

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(302011114).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 31 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 31)

				if (31 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 31)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play302011115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 302011115
		arg_473_1.duration_ = 2.9

		local var_473_0 = {
			zh = 2.9,
			ja = 1.333
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play302011116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.325

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(302011115)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 13 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 13)

				if (13 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 13)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011115", "story_v_out_302011.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011115", "story_v_out_302011.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_302011", "302011115", "story_v_out_302011.awb")

						arg_473_1:RecordAudio("302011115", var_476_6)
						arg_473_1:RecordAudio("302011115", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_302011", "302011115", "story_v_out_302011.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_302011", "302011115", "story_v_out_302011.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play302011116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 302011116
		arg_477_1.duration_ = 4.8

		local var_477_0 = {
			zh = 4.8,
			ja = 1.333
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play302011117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.575

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:GetWordFromCfg(302011116)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 23 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 23)

				if (23 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 23)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011116", "story_v_out_302011.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011116", "story_v_out_302011.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_302011", "302011116", "story_v_out_302011.awb")

						arg_477_1:RecordAudio("302011116", var_480_6)
						arg_477_1:RecordAudio("302011116", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_302011", "302011116", "story_v_out_302011.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_302011", "302011116", "story_v_out_302011.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play302011117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 302011117
		arg_481_1.duration_ = 10.43

		local var_481_0 = {
			zh = 10.433,
			ja = 1.333
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play302011118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 1.1

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(302011117)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 44 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 44)

				if (44 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 44)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011117", "story_v_out_302011.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011117", "story_v_out_302011.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_302011", "302011117", "story_v_out_302011.awb")

						arg_481_1:RecordAudio("302011117", var_484_6)
						arg_481_1:RecordAudio("302011117", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_302011", "302011117", "story_v_out_302011.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_302011", "302011117", "story_v_out_302011.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play302011118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 302011118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play302011119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.2

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(302011118).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 8 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 8)

				if (8 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 8)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play302011119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 302011119
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play302011120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				local var_492_0 = arg_489_1.bgs_.ST10

				arg_489_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_1 = var_492_0:GetComponent("SpriteRenderer")

				if var_492_1 and var_492_1.sprite then
					local var_492_2 = 2 * (var_492_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_0.transform.localScale = Vector3.New(var_492_2 / var_492_1.sprite.bounds.size.y < var_492_2 * manager.ui.mainCameraCom_.aspect / var_492_1.sprite.bounds.size.x and var_492_2 * manager.ui.mainCameraCom_.aspect / var_492_1.sprite.bounds.size.x or var_492_2 / var_492_1.sprite.bounds.size.y, var_492_2 / var_492_1.sprite.bounds.size.y < var_492_2 * manager.ui.mainCameraCom_.aspect / var_492_1.sprite.bounds.size.x and var_492_2 * manager.ui.mainCameraCom_.aspect / var_492_1.sprite.bounds.size.x or var_492_2 / var_492_1.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "ST10" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_3 = 4

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_3 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			if arg_489_1.time_ >= var_492_3 + 0.3 and arg_489_1.time_ < var_492_3 + 0.3 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_4 = 0

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_5 = 2

			if var_492_4 <= arg_489_1.time_ and arg_489_1.time_ < var_492_4 + var_492_5 then
				local var_492_6 = Color.New(0, 0, 0)

				var_492_6.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_4) / var_492_5)
				arg_489_1.mask_.color = var_492_6
			end

			if arg_489_1.time_ >= var_492_4 + var_492_5 and arg_489_1.time_ < var_492_4 + var_492_5 + arg_492_0 then
				local var_492_7 = Color.New(0, 0, 0)

				var_492_7.a = 1
				arg_489_1.mask_.color = var_492_7
			end

			local var_492_8 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_8 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_9 = 2

			if var_492_8 <= arg_489_1.time_ and arg_489_1.time_ < var_492_8 + var_492_9 then
				local var_492_10 = Color.New(0, 0, 0)

				var_492_10.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_8) / var_492_9)
				arg_489_1.mask_.color = var_492_10
			end

			if arg_489_1.time_ >= var_492_8 + var_492_9 and arg_489_1.time_ < var_492_8 + var_492_9 + arg_492_0 then
				local var_492_11 = Color.New(0, 0, 0)

				arg_489_1.mask_.enabled = false
				var_492_11.a = 0
				arg_489_1.mask_.color = var_492_11
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_12 = 4
			local var_492_13 = 1.375

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_12 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_14 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_14:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_15 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(302011119).content)

				arg_489_1.text_.text = var_492_15

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_17 = 55 <= 0 and var_492_13 or var_492_13 * (utf8.len(var_492_15) / 55)

				if (55 <= 0 and var_492_13 or var_492_13 * (utf8.len(var_492_15) / 55)) > 0 and var_492_13 < var_492_17 then
					arg_489_1.talkMaxDuration = var_492_17
					var_492_12 = var_492_12 + 0.3

					if var_492_17 + var_492_12 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_17 + var_492_12
					end
				end

				arg_489_1.text_.text = var_492_15
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_18 = var_492_12 + 0.3
			local var_492_19 = math.max(var_492_13, arg_489_1.talkMaxDuration)

			if var_492_12 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_18 + var_492_19 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_18) / var_492_19

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_18 + var_492_19 and arg_489_1.time_ < var_492_18 + var_492_19 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play302011120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 302011120
		arg_495_1.duration_ = 2

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play302011121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos1066ui_story = arg_495_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_498_0 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 then
				arg_495_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_495_1.time_ - 0) / var_498_0)
				arg_495_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).z)
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles = arg_495_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 then
				arg_495_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_495_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_495_1.actors_["1066ui_story"].transform.position).z)
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_495_1.actors_["1066ui_story"].transform.localEulerAngles = arg_495_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_498_1 = arg_495_1.actors_["1066ui_story"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1066ui_story == nil then
				arg_495_1.var_.characterEffect1066ui_story = var_498_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_2 and not isNil(var_498_1) then
				if arg_495_1.var_.characterEffect1066ui_story and not isNil(var_498_1) then
					arg_495_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_2 and arg_495_1.time_ < 0 + var_498_2 + arg_498_0 and not isNil(var_498_1) and arg_495_1.var_.characterEffect1066ui_story then
				arg_495_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_498_4 = 0
			local var_498_5 = 0.15

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_6 = arg_495_1:GetWordFromCfg(302011120)
				local var_498_7 = arg_495_1:FormatText(var_498_6.content)

				arg_495_1.text_.text = var_498_7

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_9 = 6 <= 0 and var_498_5 or var_498_5 * (utf8.len(var_498_7) / 6)

				if (6 <= 0 and var_498_5 or var_498_5 * (utf8.len(var_498_7) / 6)) > 0 and var_498_5 < var_498_9 then
					arg_495_1.talkMaxDuration = var_498_9

					if var_498_9 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_9 + var_498_4
					end
				end

				arg_495_1.text_.text = var_498_7
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011120", "story_v_out_302011.awb") ~= 0 then
					local var_498_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011120", "story_v_out_302011.awb") / 1000

					if var_498_10 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_10 + var_498_4
					end

					if var_498_6.prefab_name ~= "" and arg_495_1.actors_[var_498_6.prefab_name] ~= nil then
						local var_498_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_6.prefab_name].transform, "story_v_out_302011", "302011120", "story_v_out_302011.awb")

						arg_495_1:RecordAudio("302011120", var_498_11)
						arg_495_1:RecordAudio("302011120", var_498_11)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_302011", "302011120", "story_v_out_302011.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_302011", "302011120", "story_v_out_302011.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_12 = math.max(var_498_5, arg_495_1.talkMaxDuration)

			if var_498_4 <= arg_495_1.time_ and arg_495_1.time_ < var_498_4 + var_498_12 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_4) / var_498_12

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_4 + var_498_12 and arg_495_1.time_ < var_498_4 + var_498_12 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play302011121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 302011121
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play302011122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1066ui_story"]) and arg_499_1.var_.characterEffect1066ui_story == nil then
				arg_499_1.var_.characterEffect1066ui_story = arg_499_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1066ui_story"]) then
				if arg_499_1.var_.characterEffect1066ui_story and not isNil(arg_499_1.actors_["1066ui_story"]) then
					arg_499_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_0)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1066ui_story"]) and arg_499_1.var_.characterEffect1066ui_story then
				arg_499_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_502_1 = 0
			local var_502_2 = 0.375

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_3 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(302011121).content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 15 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 15)

				if (15 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 15)) > 0 and var_502_2 < var_502_5 then
					arg_499_1.talkMaxDuration = var_502_5

					if var_502_5 + var_502_1 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + var_502_1
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_6 = math.max(var_502_2, arg_499_1.talkMaxDuration)

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_6 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_1) / var_502_6

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_1 + var_502_6 and arg_499_1.time_ < var_502_1 + var_502_6 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play302011122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 302011122
		arg_503_1.duration_ = 3.9

		local var_503_0 = {
			zh = 3.9,
			ja = 1.999999999999
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play302011123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1066ui_story"]) and arg_503_1.var_.characterEffect1066ui_story == nil then
				arg_503_1.var_.characterEffect1066ui_story = arg_503_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1066ui_story"]) then
				if arg_503_1.var_.characterEffect1066ui_story and not isNil(arg_503_1.actors_["1066ui_story"]) then
					arg_503_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1066ui_story"]) and arg_503_1.var_.characterEffect1066ui_story then
				arg_503_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action432")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_506_2 = 0
			local var_506_3 = 0.5

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_4 = arg_503_1:GetWordFromCfg(302011122)
				local var_506_5 = arg_503_1:FormatText(var_506_4.content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 20 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 20)

				if (20 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 20)) > 0 and var_506_3 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011122", "story_v_out_302011.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011122", "story_v_out_302011.awb") / 1000

					if var_506_8 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_2
					end

					if var_506_4.prefab_name ~= "" and arg_503_1.actors_[var_506_4.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_4.prefab_name].transform, "story_v_out_302011", "302011122", "story_v_out_302011.awb")

						arg_503_1:RecordAudio("302011122", var_506_9)
						arg_503_1:RecordAudio("302011122", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_302011", "302011122", "story_v_out_302011.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_302011", "302011122", "story_v_out_302011.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_2) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_2 + var_506_10 and arg_503_1.time_ < var_506_2 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play302011123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 302011123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play302011124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["1066ui_story"]) and arg_507_1.var_.characterEffect1066ui_story == nil then
				arg_507_1.var_.characterEffect1066ui_story = arg_507_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["1066ui_story"]) then
				if arg_507_1.var_.characterEffect1066ui_story and not isNil(arg_507_1.actors_["1066ui_story"]) then
					arg_507_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_0)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["1066ui_story"]) and arg_507_1.var_.characterEffect1066ui_story then
				arg_507_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_510_1 = 0
			local var_510_2 = 0.45

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(302011123).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 18 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 18)

				if (18 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 18)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play302011124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 302011124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play302011125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.35

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(302011124).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 14 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 14)

				if (14 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 14)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play302011125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 302011125
		arg_515_1.duration_ = 6.6

		local var_515_0 = {
			zh = 6.6,
			ja = 1.999999999999
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play302011126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1066ui_story"]) and arg_515_1.var_.characterEffect1066ui_story == nil then
				arg_515_1.var_.characterEffect1066ui_story = arg_515_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1066ui_story"]) then
				if arg_515_1.var_.characterEffect1066ui_story and not isNil(arg_515_1.actors_["1066ui_story"]) then
					arg_515_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1066ui_story"]) and arg_515_1.var_.characterEffect1066ui_story then
				arg_515_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_518_2 = 0
			local var_518_3 = 0.8

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_2 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_4 = arg_515_1:GetWordFromCfg(302011125)
				local var_518_5 = arg_515_1:FormatText(var_518_4.content)

				arg_515_1.text_.text = var_518_5

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_7 = 32 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 32)

				if (32 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 32)) > 0 and var_518_3 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_2
					end
				end

				arg_515_1.text_.text = var_518_5
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011125", "story_v_out_302011.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011125", "story_v_out_302011.awb") / 1000

					if var_518_8 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_2
					end

					if var_518_4.prefab_name ~= "" and arg_515_1.actors_[var_518_4.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_4.prefab_name].transform, "story_v_out_302011", "302011125", "story_v_out_302011.awb")

						arg_515_1:RecordAudio("302011125", var_518_9)
						arg_515_1:RecordAudio("302011125", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_302011", "302011125", "story_v_out_302011.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_302011", "302011125", "story_v_out_302011.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_3, arg_515_1.talkMaxDuration)

			if var_518_2 <= arg_515_1.time_ and arg_515_1.time_ < var_518_2 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_2) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_2 + var_518_10 and arg_515_1.time_ < var_518_2 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play302011126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 302011126
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play302011127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1066ui_story = arg_519_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).z)
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles = arg_519_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_519_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1066ui_story"].transform.position).z)
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1066ui_story"].transform.localEulerAngles = arg_519_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1066ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1066ui_story == nil then
				arg_519_1.var_.characterEffect1066ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1066ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_2)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1066ui_story then
				arg_519_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_522_3 = 0
			local var_522_4 = 1

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_3 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_5 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(302011126).content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 40 <= 0 and var_522_4 or var_522_4 * (utf8.len(var_522_5) / 40)

				if (40 <= 0 and var_522_4 or var_522_4 * (utf8.len(var_522_5) / 40)) > 0 and var_522_4 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_3 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_3
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_4, arg_519_1.talkMaxDuration)

			if var_522_3 <= arg_519_1.time_ and arg_519_1.time_ < var_522_3 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_3) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_3 + var_522_8 and arg_519_1.time_ < var_522_3 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play302011127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 302011127
		arg_523_1.duration_ = 4.7

		local var_523_0 = {
			zh = 4.7,
			ja = 1.999999999999
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play302011128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1066ui_story"]) and arg_523_1.var_.characterEffect1066ui_story == nil then
				arg_523_1.var_.characterEffect1066ui_story = arg_523_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1066ui_story"]) then
				if arg_523_1.var_.characterEffect1066ui_story and not isNil(arg_523_1.actors_["1066ui_story"]) then
					arg_523_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1066ui_story"]) and arg_523_1.var_.characterEffect1066ui_story then
				arg_523_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_526_2 = arg_523_1.actors_["1066ui_story"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1066ui_story = var_526_2.localPosition
			end

			local var_526_3 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_3 then
				var_526_2.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_523_1.time_ - 0) / var_526_3)
				var_526_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_2.position).x, (manager.ui.mainCamera.transform.position - var_526_2.position).y, (manager.ui.mainCamera.transform.position - var_526_2.position).z)
				var_526_2.localEulerAngles.z = 0
				var_526_2.localEulerAngles.x = 0
				var_526_2.localEulerAngles = var_526_2.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_3 and arg_523_1.time_ < 0 + var_526_3 + arg_526_0 then
				var_526_2.localPosition = Vector3.New(0, -0.77, -6.1)
				var_526_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_2.position).x, (manager.ui.mainCamera.transform.position - var_526_2.position).y, (manager.ui.mainCamera.transform.position - var_526_2.position).z)
				var_526_2.localEulerAngles.z = 0
				var_526_2.localEulerAngles.x = 0
				var_526_2.localEulerAngles = var_526_2.localEulerAngles
			end

			local var_526_4 = 0
			local var_526_5 = 0.625

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_4 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_6 = arg_523_1:GetWordFromCfg(302011127)
				local var_526_7 = arg_523_1:FormatText(var_526_6.content)

				arg_523_1.text_.text = var_526_7

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_9 = 25 <= 0 and var_526_5 or var_526_5 * (utf8.len(var_526_7) / 25)

				if (25 <= 0 and var_526_5 or var_526_5 * (utf8.len(var_526_7) / 25)) > 0 and var_526_5 < var_526_9 then
					arg_523_1.talkMaxDuration = var_526_9

					if var_526_9 + var_526_4 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_9 + var_526_4
					end
				end

				arg_523_1.text_.text = var_526_7
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011127", "story_v_out_302011.awb") ~= 0 then
					local var_526_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011127", "story_v_out_302011.awb") / 1000

					if var_526_10 + var_526_4 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_10 + var_526_4
					end

					if var_526_6.prefab_name ~= "" and arg_523_1.actors_[var_526_6.prefab_name] ~= nil then
						local var_526_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_6.prefab_name].transform, "story_v_out_302011", "302011127", "story_v_out_302011.awb")

						arg_523_1:RecordAudio("302011127", var_526_11)
						arg_523_1:RecordAudio("302011127", var_526_11)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_302011", "302011127", "story_v_out_302011.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_302011", "302011127", "story_v_out_302011.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_12 = math.max(var_526_5, arg_523_1.talkMaxDuration)

			if var_526_4 <= arg_523_1.time_ and arg_523_1.time_ < var_526_4 + var_526_12 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_4) / var_526_12

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_4 + var_526_12 and arg_523_1.time_ < var_526_4 + var_526_12 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play302011128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 302011128
		arg_527_1.duration_ = 5.3

		local var_527_0 = {
			zh = 5.3,
			ja = 1.333
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play302011129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_530_0 = 0
			local var_530_1 = 0.65

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(302011128)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_5 = 26 <= 0 and var_530_1 or var_530_1 * (utf8.len(var_530_3) / 26)

				if (26 <= 0 and var_530_1 or var_530_1 * (utf8.len(var_530_3) / 26)) > 0 and var_530_1 < var_530_5 then
					arg_527_1.talkMaxDuration = var_530_5

					if var_530_5 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011128", "story_v_out_302011.awb") ~= 0 then
					local var_530_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011128", "story_v_out_302011.awb") / 1000

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end

					if var_530_2.prefab_name ~= "" and arg_527_1.actors_[var_530_2.prefab_name] ~= nil then
						local var_530_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_2.prefab_name].transform, "story_v_out_302011", "302011128", "story_v_out_302011.awb")

						arg_527_1:RecordAudio("302011128", var_530_7)
						arg_527_1:RecordAudio("302011128", var_530_7)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_302011", "302011128", "story_v_out_302011.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_302011", "302011128", "story_v_out_302011.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_8 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_8 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_8

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_8 and arg_527_1.time_ < var_530_0 + var_530_8 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play302011129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 302011129
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play302011130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["1066ui_story"]) and arg_531_1.var_.characterEffect1066ui_story == nil then
				arg_531_1.var_.characterEffect1066ui_story = arg_531_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_0 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["1066ui_story"]) then
				if arg_531_1.var_.characterEffect1066ui_story and not isNil(arg_531_1.actors_["1066ui_story"]) then
					arg_531_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_0)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["1066ui_story"]) and arg_531_1.var_.characterEffect1066ui_story then
				arg_531_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_534_1 = 0
			local var_534_2 = 0.425

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(302011129).content)

				arg_531_1.text_.text = var_534_3

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 17 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 17)

				if (17 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_3) / 17)) > 0 and var_534_2 < var_534_5 then
					arg_531_1.talkMaxDuration = var_534_5

					if var_534_5 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_3
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_6 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_6 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_6

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_6 and arg_531_1.time_ < var_534_1 + var_534_6 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play302011130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 302011130
		arg_535_1.duration_ = 5.93

		local var_535_0 = {
			zh = 5.933,
			ja = 1.999999999999
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play302011131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1066ui_story"]) and arg_535_1.var_.characterEffect1066ui_story == nil then
				arg_535_1.var_.characterEffect1066ui_story = arg_535_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1066ui_story"]) then
				if arg_535_1.var_.characterEffect1066ui_story and not isNil(arg_535_1.actors_["1066ui_story"]) then
					arg_535_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1066ui_story"]) and arg_535_1.var_.characterEffect1066ui_story then
				arg_535_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_538_2 = 0
			local var_538_3 = 0.675

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_4 = arg_535_1:GetWordFromCfg(302011130)
				local var_538_5 = arg_535_1:FormatText(var_538_4.content)

				arg_535_1.text_.text = var_538_5

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_7 = 27 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 27)

				if (27 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_5) / 27)) > 0 and var_538_3 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_2
					end
				end

				arg_535_1.text_.text = var_538_5
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011130", "story_v_out_302011.awb") ~= 0 then
					local var_538_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011130", "story_v_out_302011.awb") / 1000

					if var_538_8 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_8 + var_538_2
					end

					if var_538_4.prefab_name ~= "" and arg_535_1.actors_[var_538_4.prefab_name] ~= nil then
						local var_538_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_4.prefab_name].transform, "story_v_out_302011", "302011130", "story_v_out_302011.awb")

						arg_535_1:RecordAudio("302011130", var_538_9)
						arg_535_1:RecordAudio("302011130", var_538_9)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_302011", "302011130", "story_v_out_302011.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_302011", "302011130", "story_v_out_302011.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_10 = math.max(var_538_3, arg_535_1.talkMaxDuration)

			if var_538_2 <= arg_535_1.time_ and arg_535_1.time_ < var_538_2 + var_538_10 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_2) / var_538_10

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_2 + var_538_10 and arg_535_1.time_ < var_538_2 + var_538_10 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play302011131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 302011131
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play302011132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos1066ui_story = arg_539_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_542_0 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 then
				arg_539_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0) / var_542_0)
				arg_539_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).z)
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles = arg_539_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 then
				arg_539_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_539_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1066ui_story"].transform.position).z)
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1066ui_story"].transform.localEulerAngles = arg_539_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_542_1 = arg_539_1.actors_["1066ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect1066ui_story == nil then
				arg_539_1.var_.characterEffect1066ui_story = var_542_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_2 and not isNil(var_542_1) then
				if arg_539_1.var_.characterEffect1066ui_story and not isNil(var_542_1) then
					arg_539_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_2)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_2 and arg_539_1.time_ < 0 + var_542_2 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect1066ui_story then
				arg_539_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_542_3 = 0
			local var_542_4 = 0.75

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_3 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, false)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_5 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(302011131).content)

				arg_539_1.text_.text = var_542_5

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_7 = 30 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_5) / 30)

				if (30 <= 0 and var_542_4 or var_542_4 * (utf8.len(var_542_5) / 30)) > 0 and var_542_4 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_3 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_3
					end
				end

				arg_539_1.text_.text = var_542_5
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_4, arg_539_1.talkMaxDuration)

			if var_542_3 <= arg_539_1.time_ and arg_539_1.time_ < var_542_3 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_3) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_3 + var_542_8 and arg_539_1.time_ < var_542_3 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play302011132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 302011132
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play302011133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.075

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(302011132).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 3 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 3)

				if (3 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 3)) > 0 and var_546_0 < var_546_3 then
					arg_543_1.talkMaxDuration = var_546_3

					if var_546_3 + 0 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_3 + 0
					end
				end

				arg_543_1.text_.text = var_546_1
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)
				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_4 = math.max(var_546_0, arg_543_1.talkMaxDuration)

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - 0) / var_546_4

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play302011133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 302011133
		arg_547_1.duration_ = 3.57

		local var_547_0 = {
			zh = 3.566,
			ja = 1.999999999999
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play302011134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1066ui_story"]) and arg_547_1.var_.characterEffect1066ui_story == nil then
				arg_547_1.var_.characterEffect1066ui_story = arg_547_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1066ui_story"]) then
				if arg_547_1.var_.characterEffect1066ui_story and not isNil(arg_547_1.actors_["1066ui_story"]) then
					arg_547_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1066ui_story"]) and arg_547_1.var_.characterEffect1066ui_story then
				arg_547_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_550_2 = arg_547_1.actors_["1066ui_story"].transform

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.var_.moveOldPos1066ui_story = var_550_2.localPosition
			end

			local var_550_3 = 0.001

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_3 then
				var_550_2.localPosition = Vector3.Lerp(arg_547_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_547_1.time_ - 0) / var_550_3)
				var_550_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_550_2.position).x, (manager.ui.mainCamera.transform.position - var_550_2.position).y, (manager.ui.mainCamera.transform.position - var_550_2.position).z)
				var_550_2.localEulerAngles.z = 0
				var_550_2.localEulerAngles.x = 0
				var_550_2.localEulerAngles = var_550_2.localEulerAngles
			end

			if arg_547_1.time_ >= 0 + var_550_3 and arg_547_1.time_ < 0 + var_550_3 + arg_550_0 then
				var_550_2.localPosition = Vector3.New(0, -0.77, -6.1)
				var_550_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_550_2.position).x, (manager.ui.mainCamera.transform.position - var_550_2.position).y, (manager.ui.mainCamera.transform.position - var_550_2.position).z)
				var_550_2.localEulerAngles.z = 0
				var_550_2.localEulerAngles.x = 0
				var_550_2.localEulerAngles = var_550_2.localEulerAngles
			end

			local var_550_4 = 0
			local var_550_5 = 0.425

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_4 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_6 = arg_547_1:GetWordFromCfg(302011133)
				local var_550_7 = arg_547_1:FormatText(var_550_6.content)

				arg_547_1.text_.text = var_550_7

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_9 = 17 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 17)

				if (17 <= 0 and var_550_5 or var_550_5 * (utf8.len(var_550_7) / 17)) > 0 and var_550_5 < var_550_9 then
					arg_547_1.talkMaxDuration = var_550_9

					if var_550_9 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_9 + var_550_4
					end
				end

				arg_547_1.text_.text = var_550_7
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011133", "story_v_out_302011.awb") ~= 0 then
					local var_550_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011133", "story_v_out_302011.awb") / 1000

					if var_550_10 + var_550_4 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_10 + var_550_4
					end

					if var_550_6.prefab_name ~= "" and arg_547_1.actors_[var_550_6.prefab_name] ~= nil then
						local var_550_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_6.prefab_name].transform, "story_v_out_302011", "302011133", "story_v_out_302011.awb")

						arg_547_1:RecordAudio("302011133", var_550_11)
						arg_547_1:RecordAudio("302011133", var_550_11)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_302011", "302011133", "story_v_out_302011.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_302011", "302011133", "story_v_out_302011.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_12 = math.max(var_550_5, arg_547_1.talkMaxDuration)

			if var_550_4 <= arg_547_1.time_ and arg_547_1.time_ < var_550_4 + var_550_12 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_4) / var_550_12

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_4 + var_550_12 and arg_547_1.time_ < var_550_4 + var_550_12 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_547_1:InitPlayNodeList()
	end,
	Play302011134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 302011134
		arg_551_1.duration_ = 5.17

		local var_551_0 = {
			zh = 5.166,
			ja = 1.999999999999
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play302011135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action5_1")
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_554_0 = 0
			local var_554_1 = 0.575

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_2 = arg_551_1:GetWordFromCfg(302011134)
				local var_554_3 = arg_551_1:FormatText(var_554_2.content)

				arg_551_1.text_.text = var_554_3

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 23 <= 0 and var_554_1 or var_554_1 * (utf8.len(var_554_3) / 23)

				if (23 <= 0 and var_554_1 or var_554_1 * (utf8.len(var_554_3) / 23)) > 0 and var_554_1 < var_554_5 then
					arg_551_1.talkMaxDuration = var_554_5

					if var_554_5 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_3
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011134", "story_v_out_302011.awb") ~= 0 then
					local var_554_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011134", "story_v_out_302011.awb") / 1000

					if var_554_6 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_6 + var_554_0
					end

					if var_554_2.prefab_name ~= "" and arg_551_1.actors_[var_554_2.prefab_name] ~= nil then
						local var_554_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_2.prefab_name].transform, "story_v_out_302011", "302011134", "story_v_out_302011.awb")

						arg_551_1:RecordAudio("302011134", var_554_7)
						arg_551_1:RecordAudio("302011134", var_554_7)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_302011", "302011134", "story_v_out_302011.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_302011", "302011134", "story_v_out_302011.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_8 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_8 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_8

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_8 and arg_551_1.time_ < var_554_0 + var_554_8 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play302011135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 302011135
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play302011136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1066ui_story"]) and arg_555_1.var_.characterEffect1066ui_story == nil then
				arg_555_1.var_.characterEffect1066ui_story = arg_555_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1066ui_story"]) then
				if arg_555_1.var_.characterEffect1066ui_story and not isNil(arg_555_1.actors_["1066ui_story"]) then
					arg_555_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_555_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_555_1.time_ - 0) / var_558_0)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1066ui_story"]) and arg_555_1.var_.characterEffect1066ui_story then
				arg_555_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_555_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_558_1 = 0
			local var_558_2 = 0.45

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_3 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(302011135).content)

				arg_555_1.text_.text = var_558_3

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_5 = 18 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 18)

				if (18 <= 0 and var_558_2 or var_558_2 * (utf8.len(var_558_3) / 18)) > 0 and var_558_2 < var_558_5 then
					arg_555_1.talkMaxDuration = var_558_5

					if var_558_5 + var_558_1 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_5 + var_558_1
					end
				end

				arg_555_1.text_.text = var_558_3
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_6 = math.max(var_558_2, arg_555_1.talkMaxDuration)

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_6 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_1) / var_558_6

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_1 + var_558_6 and arg_555_1.time_ < var_558_1 + var_558_6 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play302011136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 302011136
		arg_559_1.duration_ = 4.1

		local var_559_0 = {
			zh = 4.1,
			ja = 1.999999999999
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play302011137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["1066ui_story"]) and arg_559_1.var_.characterEffect1066ui_story == nil then
				arg_559_1.var_.characterEffect1066ui_story = arg_559_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_0 = 0.200000002980232

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["1066ui_story"]) then
				if arg_559_1.var_.characterEffect1066ui_story and not isNil(arg_559_1.actors_["1066ui_story"]) then
					arg_559_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["1066ui_story"]) and arg_559_1.var_.characterEffect1066ui_story then
				arg_559_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action453")
			end

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_562_2 = 0
			local var_562_3 = 0.45

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_2 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_4 = arg_559_1:GetWordFromCfg(302011136)
				local var_562_5 = arg_559_1:FormatText(var_562_4.content)

				arg_559_1.text_.text = var_562_5

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_7 = 18 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 18)

				if (18 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_5) / 18)) > 0 and var_562_3 < var_562_7 then
					arg_559_1.talkMaxDuration = var_562_7

					if var_562_7 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_7 + var_562_2
					end
				end

				arg_559_1.text_.text = var_562_5
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011136", "story_v_out_302011.awb") ~= 0 then
					local var_562_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011136", "story_v_out_302011.awb") / 1000

					if var_562_8 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_8 + var_562_2
					end

					if var_562_4.prefab_name ~= "" and arg_559_1.actors_[var_562_4.prefab_name] ~= nil then
						local var_562_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_4.prefab_name].transform, "story_v_out_302011", "302011136", "story_v_out_302011.awb")

						arg_559_1:RecordAudio("302011136", var_562_9)
						arg_559_1:RecordAudio("302011136", var_562_9)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_302011", "302011136", "story_v_out_302011.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_302011", "302011136", "story_v_out_302011.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_10 = math.max(var_562_3, arg_559_1.talkMaxDuration)

			if var_562_2 <= arg_559_1.time_ and arg_559_1.time_ < var_562_2 + var_562_10 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_2) / var_562_10

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_2 + var_562_10 and arg_559_1.time_ < var_562_2 + var_562_10 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play302011137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 302011137
		arg_563_1.duration_ = 4.6

		local var_563_0 = {
			zh = 4.6,
			ja = 1.333
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play302011138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.45

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, false)
				arg_563_1.callingController_:SetSelectedState("normal")

				local var_566_1 = arg_563_1:GetWordFromCfg(302011137)
				local var_566_2 = arg_563_1:FormatText(var_566_1.content)

				arg_563_1.text_.text = var_566_2

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 18 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 18)

				if (18 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 18)) > 0 and var_566_0 < var_566_4 then
					arg_563_1.talkMaxDuration = var_566_4

					if var_566_4 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_4 + 0
					end
				end

				arg_563_1.text_.text = var_566_2
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011137", "story_v_out_302011.awb") ~= 0 then
					local var_566_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011137", "story_v_out_302011.awb") / 1000

					if var_566_5 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + 0
					end

					if var_566_1.prefab_name ~= "" and arg_563_1.actors_[var_566_1.prefab_name] ~= nil then
						local var_566_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_1.prefab_name].transform, "story_v_out_302011", "302011137", "story_v_out_302011.awb")

						arg_563_1:RecordAudio("302011137", var_566_6)
						arg_563_1:RecordAudio("302011137", var_566_6)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_302011", "302011137", "story_v_out_302011.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_302011", "302011137", "story_v_out_302011.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_7 and arg_563_1.time_ < 0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play302011138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 302011138
		arg_567_1.duration_ = 5

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play302011139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1066ui_story"]) and arg_567_1.var_.characterEffect1066ui_story == nil then
				arg_567_1.var_.characterEffect1066ui_story = arg_567_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1066ui_story"]) then
				if arg_567_1.var_.characterEffect1066ui_story and not isNil(arg_567_1.actors_["1066ui_story"]) then
					arg_567_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_567_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_567_1.time_ - 0) / var_570_0)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1066ui_story"]) and arg_567_1.var_.characterEffect1066ui_story then
				arg_567_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_567_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_570_1 = 0
			local var_570_2 = 0.275

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_1 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_3 = arg_567_1:FormatText(arg_567_1:GetWordFromCfg(302011138).content)

				arg_567_1.text_.text = var_570_3

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_5 = 11 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 11)

				if (11 <= 0 and var_570_2 or var_570_2 * (utf8.len(var_570_3) / 11)) > 0 and var_570_2 < var_570_5 then
					arg_567_1.talkMaxDuration = var_570_5

					if var_570_5 + var_570_1 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + var_570_1
					end
				end

				arg_567_1.text_.text = var_570_3
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)
				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_6 = math.max(var_570_2, arg_567_1.talkMaxDuration)

			if var_570_1 <= arg_567_1.time_ and arg_567_1.time_ < var_570_1 + var_570_6 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_1) / var_570_6

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_1 + var_570_6 and arg_567_1.time_ < var_570_1 + var_570_6 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play302011139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 302011139
		arg_571_1.duration_ = 3.17

		local var_571_0 = {
			zh = 3.166,
			ja = 1.999999999999
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play302011140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1066ui_story"]) and arg_571_1.var_.characterEffect1066ui_story == nil then
				arg_571_1.var_.characterEffect1066ui_story = arg_571_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1066ui_story"]) then
				if arg_571_1.var_.characterEffect1066ui_story and not isNil(arg_571_1.actors_["1066ui_story"]) then
					arg_571_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1066ui_story"]) and arg_571_1.var_.characterEffect1066ui_story then
				arg_571_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_574_2 = 0
			local var_574_3 = 0.325

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, false)
				arg_571_1.callingController_:SetSelectedState("normal")

				local var_574_4 = arg_571_1:GetWordFromCfg(302011139)
				local var_574_5 = arg_571_1:FormatText(var_574_4.content)

				arg_571_1.text_.text = var_574_5

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_7 = 13 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 13)

				if (13 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_5) / 13)) > 0 and var_574_3 < var_574_7 then
					arg_571_1.talkMaxDuration = var_574_7

					if var_574_7 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_5
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011139", "story_v_out_302011.awb") ~= 0 then
					local var_574_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011139", "story_v_out_302011.awb") / 1000

					if var_574_8 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_8 + var_574_2
					end

					if var_574_4.prefab_name ~= "" and arg_571_1.actors_[var_574_4.prefab_name] ~= nil then
						local var_574_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_4.prefab_name].transform, "story_v_out_302011", "302011139", "story_v_out_302011.awb")

						arg_571_1:RecordAudio("302011139", var_574_9)
						arg_571_1:RecordAudio("302011139", var_574_9)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_302011", "302011139", "story_v_out_302011.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_302011", "302011139", "story_v_out_302011.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_10 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_10 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_10

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_10 and arg_571_1.time_ < var_574_2 + var_574_10 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play302011140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 302011140
		arg_575_1.duration_ = 7.03

		local var_575_0 = {
			zh = 3.466,
			ja = 7.033
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play302011141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1033ui_story = arg_575_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).z)
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles = arg_575_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_575_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1033ui_story"].transform.position).z)
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1033ui_story"].transform.localEulerAngles = arg_575_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["1066ui_story"].transform

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1066ui_story = var_578_1.localPosition
			end

			local var_578_2 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 then
				var_578_1.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_575_1.time_ - 0) / var_578_2)
				var_578_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_578_1.position).x, (manager.ui.mainCamera.transform.position - var_578_1.position).y, (manager.ui.mainCamera.transform.position - var_578_1.position).z)
				var_578_1.localEulerAngles.z = 0
				var_578_1.localEulerAngles.x = 0
				var_578_1.localEulerAngles = var_578_1.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 then
				var_578_1.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_578_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_578_1.position).x, (manager.ui.mainCamera.transform.position - var_578_1.position).y, (manager.ui.mainCamera.transform.position - var_578_1.position).z)
				var_578_1.localEulerAngles.z = 0
				var_578_1.localEulerAngles.x = 0
				var_578_1.localEulerAngles = var_578_1.localEulerAngles
			end

			local var_578_3 = arg_575_1.actors_["1033ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_3) and arg_575_1.var_.characterEffect1033ui_story == nil then
				arg_575_1.var_.characterEffect1033ui_story = var_578_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_4 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 and not isNil(var_578_3) then
				if arg_575_1.var_.characterEffect1033ui_story and not isNil(var_578_3) then
					arg_575_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 and not isNil(var_578_3) and arg_575_1.var_.characterEffect1033ui_story then
				arg_575_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_578_6 = arg_575_1.actors_["1066ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_6) and arg_575_1.var_.characterEffect1066ui_story == nil then
				arg_575_1.var_.characterEffect1066ui_story = var_578_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_7 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 and not isNil(var_578_6) then
				if arg_575_1.var_.characterEffect1066ui_story and not isNil(var_578_6) then
					arg_575_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_575_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_575_1.time_ - 0) / var_578_7)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 and not isNil(var_578_6) and arg_575_1.var_.characterEffect1066ui_story then
				arg_575_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_575_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action1_1")
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_578_8 = 0
			local var_578_9 = 0.425

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_8 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_10 = arg_575_1:GetWordFromCfg(302011140)
				local var_578_11 = arg_575_1:FormatText(var_578_10.content)

				arg_575_1.text_.text = var_578_11

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_13 = 17 <= 0 and var_578_9 or var_578_9 * (utf8.len(var_578_11) / 17)

				if (17 <= 0 and var_578_9 or var_578_9 * (utf8.len(var_578_11) / 17)) > 0 and var_578_9 < var_578_13 then
					arg_575_1.talkMaxDuration = var_578_13

					if var_578_13 + var_578_8 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_13 + var_578_8
					end
				end

				arg_575_1.text_.text = var_578_11
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011140", "story_v_out_302011.awb") ~= 0 then
					local var_578_14 = manager.audio:GetVoiceLength("story_v_out_302011", "302011140", "story_v_out_302011.awb") / 1000

					if var_578_14 + var_578_8 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_14 + var_578_8
					end

					if var_578_10.prefab_name ~= "" and arg_575_1.actors_[var_578_10.prefab_name] ~= nil then
						local var_578_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_10.prefab_name].transform, "story_v_out_302011", "302011140", "story_v_out_302011.awb")

						arg_575_1:RecordAudio("302011140", var_578_15)
						arg_575_1:RecordAudio("302011140", var_578_15)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_302011", "302011140", "story_v_out_302011.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_302011", "302011140", "story_v_out_302011.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_16 = math.max(var_578_9, arg_575_1.talkMaxDuration)

			if var_578_8 <= arg_575_1.time_ and arg_575_1.time_ < var_578_8 + var_578_16 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_8) / var_578_16

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_8 + var_578_16 and arg_575_1.time_ < var_578_8 + var_578_16 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play302011141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 302011141
		arg_579_1.duration_ = 3.3

		local var_579_0 = {
			zh = 3.3,
			ja = 1.333
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play302011142(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1066ui_story"]) and arg_579_1.var_.characterEffect1066ui_story == nil then
				arg_579_1.var_.characterEffect1066ui_story = arg_579_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1066ui_story"]) then
				if arg_579_1.var_.characterEffect1066ui_story and not isNil(arg_579_1.actors_["1066ui_story"]) then
					arg_579_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1066ui_story"]) and arg_579_1.var_.characterEffect1066ui_story then
				arg_579_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_582_2 = arg_579_1.actors_["1033ui_story"]

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(var_582_2) and arg_579_1.var_.characterEffect1033ui_story == nil then
				arg_579_1.var_.characterEffect1033ui_story = var_582_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_3 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_3 and not isNil(var_582_2) then
				if arg_579_1.var_.characterEffect1033ui_story and not isNil(var_582_2) then
					arg_579_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_3)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_3 and arg_579_1.time_ < 0 + var_582_3 + arg_582_0 and not isNil(var_582_2) and arg_579_1.var_.characterEffect1033ui_story then
				arg_579_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_582_4 = 0
			local var_582_5 = 0.4

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_6 = arg_579_1:GetWordFromCfg(302011141)
				local var_582_7 = arg_579_1:FormatText(var_582_6.content)

				arg_579_1.text_.text = var_582_7

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_9 = 16 <= 0 and var_582_5 or var_582_5 * (utf8.len(var_582_7) / 16)

				if (16 <= 0 and var_582_5 or var_582_5 * (utf8.len(var_582_7) / 16)) > 0 and var_582_5 < var_582_9 then
					arg_579_1.talkMaxDuration = var_582_9

					if var_582_9 + var_582_4 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_9 + var_582_4
					end
				end

				arg_579_1.text_.text = var_582_7
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011141", "story_v_out_302011.awb") ~= 0 then
					local var_582_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011141", "story_v_out_302011.awb") / 1000

					if var_582_10 + var_582_4 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_10 + var_582_4
					end

					if var_582_6.prefab_name ~= "" and arg_579_1.actors_[var_582_6.prefab_name] ~= nil then
						local var_582_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_6.prefab_name].transform, "story_v_out_302011", "302011141", "story_v_out_302011.awb")

						arg_579_1:RecordAudio("302011141", var_582_11)
						arg_579_1:RecordAudio("302011141", var_582_11)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_302011", "302011141", "story_v_out_302011.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_302011", "302011141", "story_v_out_302011.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_12 = math.max(var_582_5, arg_579_1.talkMaxDuration)

			if var_582_4 <= arg_579_1.time_ and arg_579_1.time_ < var_582_4 + var_582_12 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_4) / var_582_12

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_4 + var_582_12 and arg_579_1.time_ < var_582_4 + var_582_12 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play302011142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 302011142
		arg_583_1.duration_ = 5.1

		local var_583_0 = {
			zh = 2.966,
			ja = 5.1
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play302011143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["1033ui_story"]) and arg_583_1.var_.characterEffect1033ui_story == nil then
				arg_583_1.var_.characterEffect1033ui_story = arg_583_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_0 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["1033ui_story"]) then
				if arg_583_1.var_.characterEffect1033ui_story and not isNil(arg_583_1.actors_["1033ui_story"]) then
					arg_583_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["1033ui_story"]) and arg_583_1.var_.characterEffect1033ui_story then
				arg_583_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_586_2 = arg_583_1.actors_["1066ui_story"]

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(var_586_2) and arg_583_1.var_.characterEffect1066ui_story == nil then
				arg_583_1.var_.characterEffect1066ui_story = var_586_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_3 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_3 and not isNil(var_586_2) then
				if arg_583_1.var_.characterEffect1066ui_story and not isNil(var_586_2) then
					arg_583_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_583_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_583_1.time_ - 0) / var_586_3)
				end
			end

			if arg_583_1.time_ >= 0 + var_586_3 and arg_583_1.time_ < 0 + var_586_3 + arg_586_0 and not isNil(var_586_2) and arg_583_1.var_.characterEffect1066ui_story then
				arg_583_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_583_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_586_4 = 0
			local var_586_5 = 0.375

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_4 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_6 = arg_583_1:GetWordFromCfg(302011142)
				local var_586_7 = arg_583_1:FormatText(var_586_6.content)

				arg_583_1.text_.text = var_586_7

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_9 = 15 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_7) / 15)

				if (15 <= 0 and var_586_5 or var_586_5 * (utf8.len(var_586_7) / 15)) > 0 and var_586_5 < var_586_9 then
					arg_583_1.talkMaxDuration = var_586_9

					if var_586_9 + var_586_4 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_9 + var_586_4
					end
				end

				arg_583_1.text_.text = var_586_7
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011142", "story_v_out_302011.awb") ~= 0 then
					local var_586_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011142", "story_v_out_302011.awb") / 1000

					if var_586_10 + var_586_4 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_10 + var_586_4
					end

					if var_586_6.prefab_name ~= "" and arg_583_1.actors_[var_586_6.prefab_name] ~= nil then
						local var_586_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_6.prefab_name].transform, "story_v_out_302011", "302011142", "story_v_out_302011.awb")

						arg_583_1:RecordAudio("302011142", var_586_11)
						arg_583_1:RecordAudio("302011142", var_586_11)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_302011", "302011142", "story_v_out_302011.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_302011", "302011142", "story_v_out_302011.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_12 = math.max(var_586_5, arg_583_1.talkMaxDuration)

			if var_586_4 <= arg_583_1.time_ and arg_583_1.time_ < var_586_4 + var_586_12 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_4) / var_586_12

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_4 + var_586_12 and arg_583_1.time_ < var_586_4 + var_586_12 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play302011143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 302011143
		arg_587_1.duration_ = 3.97

		local var_587_0 = {
			zh = 3.966,
			ja = 1.999999999999
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play302011144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1066ui_story"]) and arg_587_1.var_.characterEffect1066ui_story == nil then
				arg_587_1.var_.characterEffect1066ui_story = arg_587_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_0 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1066ui_story"]) then
				if arg_587_1.var_.characterEffect1066ui_story and not isNil(arg_587_1.actors_["1066ui_story"]) then
					arg_587_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1066ui_story"]) and arg_587_1.var_.characterEffect1066ui_story then
				arg_587_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_590_2 = arg_587_1.actors_["1033ui_story"]

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(var_590_2) and arg_587_1.var_.characterEffect1033ui_story == nil then
				arg_587_1.var_.characterEffect1033ui_story = var_590_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_590_3 = 0.200000002980232

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_3 and not isNil(var_590_2) then
				if arg_587_1.var_.characterEffect1033ui_story and not isNil(var_590_2) then
					arg_587_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_587_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_587_1.time_ - 0) / var_590_3)
				end
			end

			if arg_587_1.time_ >= 0 + var_590_3 and arg_587_1.time_ < 0 + var_590_3 + arg_590_0 and not isNil(var_590_2) and arg_587_1.var_.characterEffect1033ui_story then
				arg_587_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_587_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_590_4 = 0
			local var_590_5 = 0.45

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_4 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_6 = arg_587_1:GetWordFromCfg(302011143)
				local var_590_7 = arg_587_1:FormatText(var_590_6.content)

				arg_587_1.text_.text = var_590_7

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_9 = 18 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_7) / 18)

				if (18 <= 0 and var_590_5 or var_590_5 * (utf8.len(var_590_7) / 18)) > 0 and var_590_5 < var_590_9 then
					arg_587_1.talkMaxDuration = var_590_9

					if var_590_9 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_9 + var_590_4
					end
				end

				arg_587_1.text_.text = var_590_7
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011143", "story_v_out_302011.awb") ~= 0 then
					local var_590_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011143", "story_v_out_302011.awb") / 1000

					if var_590_10 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_10 + var_590_4
					end

					if var_590_6.prefab_name ~= "" and arg_587_1.actors_[var_590_6.prefab_name] ~= nil then
						local var_590_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_6.prefab_name].transform, "story_v_out_302011", "302011143", "story_v_out_302011.awb")

						arg_587_1:RecordAudio("302011143", var_590_11)
						arg_587_1:RecordAudio("302011143", var_590_11)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_302011", "302011143", "story_v_out_302011.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_302011", "302011143", "story_v_out_302011.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_12 = math.max(var_590_5, arg_587_1.talkMaxDuration)

			if var_590_4 <= arg_587_1.time_ and arg_587_1.time_ < var_590_4 + var_590_12 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_4) / var_590_12

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_4 + var_590_12 and arg_587_1.time_ < var_590_4 + var_590_12 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play302011144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 302011144
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play302011145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(arg_591_1.actors_["1066ui_story"]) and arg_591_1.var_.characterEffect1066ui_story == nil then
				arg_591_1.var_.characterEffect1066ui_story = arg_591_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_0 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 and not isNil(arg_591_1.actors_["1066ui_story"]) then
				if arg_591_1.var_.characterEffect1066ui_story and not isNil(arg_591_1.actors_["1066ui_story"]) then
					arg_591_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_591_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_591_1.time_ - 0) / var_594_0)
				end
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 and not isNil(arg_591_1.actors_["1066ui_story"]) and arg_591_1.var_.characterEffect1066ui_story then
				arg_591_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_591_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_594_1 = 0
			local var_594_2 = 0.075

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(302011144).content)

				arg_591_1.text_.text = var_594_3

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 3 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_3) / 3)

				if (3 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_3) / 3)) > 0 and var_594_2 < var_594_5 then
					arg_591_1.talkMaxDuration = var_594_5

					if var_594_5 + var_594_1 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_5 + var_594_1
					end
				end

				arg_591_1.text_.text = var_594_3
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_6 = math.max(var_594_2, arg_591_1.talkMaxDuration)

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_6 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_1) / var_594_6

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_1 + var_594_6 and arg_591_1.time_ < var_594_1 + var_594_6 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play302011145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 302011145
		arg_595_1.duration_ = 7.43

		local var_595_0 = {
			zh = 7.433,
			ja = 1.999999999999
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play302011146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(arg_595_1.actors_["1066ui_story"]) and arg_595_1.var_.characterEffect1066ui_story == nil then
				arg_595_1.var_.characterEffect1066ui_story = arg_595_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_0 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 and not isNil(arg_595_1.actors_["1066ui_story"]) then
				if arg_595_1.var_.characterEffect1066ui_story and not isNil(arg_595_1.actors_["1066ui_story"]) then
					arg_595_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 and not isNil(arg_595_1.actors_["1066ui_story"]) and arg_595_1.var_.characterEffect1066ui_story then
				arg_595_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action5_2")
			end

			local var_598_2 = 0
			local var_598_3 = 0.85

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_2 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_4 = arg_595_1:GetWordFromCfg(302011145)
				local var_598_5 = arg_595_1:FormatText(var_598_4.content)

				arg_595_1.text_.text = var_598_5

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_7 = 34 <= 0 and var_598_3 or var_598_3 * (utf8.len(var_598_5) / 34)

				if (34 <= 0 and var_598_3 or var_598_3 * (utf8.len(var_598_5) / 34)) > 0 and var_598_3 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_2 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_2
					end
				end

				arg_595_1.text_.text = var_598_5
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011145", "story_v_out_302011.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011145", "story_v_out_302011.awb") / 1000

					if var_598_8 + var_598_2 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_2
					end

					if var_598_4.prefab_name ~= "" and arg_595_1.actors_[var_598_4.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_4.prefab_name].transform, "story_v_out_302011", "302011145", "story_v_out_302011.awb")

						arg_595_1:RecordAudio("302011145", var_598_9)
						arg_595_1:RecordAudio("302011145", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_302011", "302011145", "story_v_out_302011.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_302011", "302011145", "story_v_out_302011.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_3, arg_595_1.talkMaxDuration)

			if var_598_2 <= arg_595_1.time_ and arg_595_1.time_ < var_598_2 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_2) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_2 + var_598_10 and arg_595_1.time_ < var_598_2 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play302011146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 302011146
		arg_599_1.duration_ = 3.7

		local var_599_0 = {
			zh = 3.7,
			ja = 1.333
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play302011147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_602_0 = 0
			local var_602_1 = 0.375

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, false)
				arg_599_1.callingController_:SetSelectedState("normal")

				local var_602_2 = arg_599_1:GetWordFromCfg(302011146)
				local var_602_3 = arg_599_1:FormatText(var_602_2.content)

				arg_599_1.text_.text = var_602_3

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 15 <= 0 and var_602_1 or var_602_1 * (utf8.len(var_602_3) / 15)

				if (15 <= 0 and var_602_1 or var_602_1 * (utf8.len(var_602_3) / 15)) > 0 and var_602_1 < var_602_5 then
					arg_599_1.talkMaxDuration = var_602_5

					if var_602_5 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_3
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011146", "story_v_out_302011.awb") ~= 0 then
					local var_602_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011146", "story_v_out_302011.awb") / 1000

					if var_602_6 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_6 + var_602_0
					end

					if var_602_2.prefab_name ~= "" and arg_599_1.actors_[var_602_2.prefab_name] ~= nil then
						local var_602_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_2.prefab_name].transform, "story_v_out_302011", "302011146", "story_v_out_302011.awb")

						arg_599_1:RecordAudio("302011146", var_602_7)
						arg_599_1:RecordAudio("302011146", var_602_7)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_302011", "302011146", "story_v_out_302011.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_302011", "302011146", "story_v_out_302011.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_8 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_8 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_8

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_8 and arg_599_1.time_ < var_602_0 + var_602_8 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play302011147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 302011147
		arg_603_1.duration_ = 9

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play302011148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if arg_603_1.bgs_.A00 == nil then
				local var_606_0 = Object.Instantiate(arg_603_1.paintGo_)

				var_606_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_606_0.name = "A00"
				var_606_0.transform.parent = arg_603_1.stage_.transform
				var_606_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_603_1.bgs_.A00 = var_606_0
			end

			if 2 < arg_603_1.time_ and arg_603_1.time_ <= 2 + arg_606_0 then
				local var_606_1 = arg_603_1.bgs_.A00

				arg_603_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_606_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_606_2 = var_606_1:GetComponent("SpriteRenderer")

				if var_606_2 and var_606_2.sprite then
					local var_606_3 = 2 * (var_606_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_606_1.transform.localScale = Vector3.New(var_606_3 / var_606_2.sprite.bounds.size.y < var_606_3 * manager.ui.mainCameraCom_.aspect / var_606_2.sprite.bounds.size.x and var_606_3 * manager.ui.mainCameraCom_.aspect / var_606_2.sprite.bounds.size.x or var_606_3 / var_606_2.sprite.bounds.size.y, var_606_3 / var_606_2.sprite.bounds.size.y < var_606_3 * manager.ui.mainCameraCom_.aspect / var_606_2.sprite.bounds.size.x and var_606_3 * manager.ui.mainCameraCom_.aspect / var_606_2.sprite.bounds.size.x or var_606_3 / var_606_2.sprite.bounds.size.y, 0)
				end

				for iter_606_0, iter_606_1 in pairs(arg_603_1.bgs_) do
					if iter_606_0 ~= "A00" then
						iter_606_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_606_4 = 4

			if 4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1.allBtn_.enabled = false
			end

			if arg_603_1.time_ >= var_606_4 + 0.3 and arg_603_1.time_ < var_606_4 + 0.3 + arg_606_0 then
				arg_603_1.allBtn_.enabled = true
			end

			local var_606_5 = 0

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_5 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_6 = 2

			if var_606_5 <= arg_603_1.time_ and arg_603_1.time_ < var_606_5 + var_606_6 then
				local var_606_7 = Color.New(0, 0, 0)

				var_606_7.a = Mathf.Lerp(0, 1, (arg_603_1.time_ - var_606_5) / var_606_6)
				arg_603_1.mask_.color = var_606_7
			end

			if arg_603_1.time_ >= var_606_5 + var_606_6 and arg_603_1.time_ < var_606_5 + var_606_6 + arg_606_0 then
				local var_606_8 = Color.New(0, 0, 0)

				var_606_8.a = 1
				arg_603_1.mask_.color = var_606_8
			end

			local var_606_9 = 2

			if 2 < arg_603_1.time_ and arg_603_1.time_ <= var_606_9 + arg_606_0 then
				arg_603_1.mask_.enabled = true
				arg_603_1.mask_.raycastTarget = true

				arg_603_1:SetGaussion(false)
			end

			local var_606_10 = 2

			if var_606_9 <= arg_603_1.time_ and arg_603_1.time_ < var_606_9 + var_606_10 then
				local var_606_11 = Color.New(0, 0, 0)

				var_606_11.a = Mathf.Lerp(1, 0, (arg_603_1.time_ - var_606_9) / var_606_10)
				arg_603_1.mask_.color = var_606_11
			end

			if arg_603_1.time_ >= var_606_9 + var_606_10 and arg_603_1.time_ < var_606_9 + var_606_10 + arg_606_0 then
				local var_606_12 = Color.New(0, 0, 0)

				arg_603_1.mask_.enabled = false
				var_606_12.a = 0
				arg_603_1.mask_.color = var_606_12
			end

			local var_606_13 = arg_603_1.actors_["1033ui_story"].transform

			if 1.96599999815226 < arg_603_1.time_ and arg_603_1.time_ <= 1.96599999815226 + arg_606_0 then
				arg_603_1.var_.moveOldPos1033ui_story = var_606_13.localPosition
			end

			local var_606_14 = 0.001

			if 1.96599999815226 <= arg_603_1.time_ and arg_603_1.time_ < 1.96599999815226 + var_606_14 then
				var_606_13.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_603_1.time_ - 1.96599999815226) / var_606_14)
				var_606_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_13.position).x, (manager.ui.mainCamera.transform.position - var_606_13.position).y, (manager.ui.mainCamera.transform.position - var_606_13.position).z)
				var_606_13.localEulerAngles.z = 0
				var_606_13.localEulerAngles.x = 0
				var_606_13.localEulerAngles = var_606_13.localEulerAngles
			end

			if arg_603_1.time_ >= 1.96599999815226 + var_606_14 and arg_603_1.time_ < 1.96599999815226 + var_606_14 + arg_606_0 then
				var_606_13.localPosition = Vector3.New(0, 100, 0)
				var_606_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_13.position).x, (manager.ui.mainCamera.transform.position - var_606_13.position).y, (manager.ui.mainCamera.transform.position - var_606_13.position).z)
				var_606_13.localEulerAngles.z = 0
				var_606_13.localEulerAngles.x = 0
				var_606_13.localEulerAngles = var_606_13.localEulerAngles
			end

			local var_606_15 = arg_603_1.actors_["1066ui_story"].transform

			if 1.96599999815226 < arg_603_1.time_ and arg_603_1.time_ <= 1.96599999815226 + arg_606_0 then
				arg_603_1.var_.moveOldPos1066ui_story = var_606_15.localPosition
			end

			local var_606_16 = 0.001

			if 1.96599999815226 <= arg_603_1.time_ and arg_603_1.time_ < 1.96599999815226 + var_606_16 then
				var_606_15.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_603_1.time_ - 1.96599999815226) / var_606_16)
				var_606_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_15.position).x, (manager.ui.mainCamera.transform.position - var_606_15.position).y, (manager.ui.mainCamera.transform.position - var_606_15.position).z)
				var_606_15.localEulerAngles.z = 0
				var_606_15.localEulerAngles.x = 0
				var_606_15.localEulerAngles = var_606_15.localEulerAngles
			end

			if arg_603_1.time_ >= 1.96599999815226 + var_606_16 and arg_603_1.time_ < 1.96599999815226 + var_606_16 + arg_606_0 then
				var_606_15.localPosition = Vector3.New(0, 100, 0)
				var_606_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_606_15.position).x, (manager.ui.mainCamera.transform.position - var_606_15.position).y, (manager.ui.mainCamera.transform.position - var_606_15.position).z)
				var_606_15.localEulerAngles.z = 0
				var_606_15.localEulerAngles.x = 0
				var_606_15.localEulerAngles = var_606_15.localEulerAngles
			end

			local var_606_17 = arg_603_1.actors_["1066ui_story"]

			if 4 < arg_603_1.time_ and arg_603_1.time_ <= 4 + arg_606_0 and not isNil(var_606_17) and arg_603_1.var_.characterEffect1066ui_story == nil then
				arg_603_1.var_.characterEffect1066ui_story = var_606_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_18 = 0.200000002980232

			if 4 <= arg_603_1.time_ and arg_603_1.time_ < 4 + var_606_18 and not isNil(var_606_17) then
				if arg_603_1.var_.characterEffect1066ui_story and not isNil(var_606_17) then
					arg_603_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_603_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 4) / var_606_18)
				end
			end

			if arg_603_1.time_ >= 4 + var_606_18 and arg_603_1.time_ < 4 + var_606_18 + arg_606_0 and not isNil(var_606_17) and arg_603_1.var_.characterEffect1066ui_story then
				arg_603_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_603_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_603_1.time_ and arg_603_1.time_ <= 1.2 + arg_606_0 then
				arg_603_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 0.2 < arg_603_1.time_ and arg_603_1.time_ <= 0.2 + arg_606_0 then
				arg_603_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_603_1.frameCnt_ <= 1 then
				arg_603_1.dialog_:SetActive(false)
			end

			local var_606_21 = 4
			local var_606_22 = 1.45

			if 4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_21 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0

				arg_603_1.dialog_:SetActive(true)

				arg_603_1.dialogCg_.alpha = 0

				local var_606_23 = LeanTween.value(arg_603_1.dialog_, 0, 1, 0.3)

				var_606_23:setOnUpdate(LuaHelper.FloatAction(function(arg_607_0)
					arg_603_1.dialogCg_.alpha = arg_607_0
				end))
				var_606_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_603_1.dialog_)
					var_606_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_603_1.duration_ = arg_603_1.duration_ + 0.3

				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_24 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(302011147).content)

				arg_603_1.text_.text = var_606_24

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_26 = 58 <= 0 and var_606_22 or var_606_22 * (utf8.len(var_606_24) / 58)

				if (58 <= 0 and var_606_22 or var_606_22 * (utf8.len(var_606_24) / 58)) > 0 and var_606_22 < var_606_26 then
					arg_603_1.talkMaxDuration = var_606_26
					var_606_21 = var_606_21 + 0.3

					if var_606_26 + var_606_21 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_26 + var_606_21
					end
				end

				arg_603_1.text_.text = var_606_24
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_27 = var_606_21 + 0.3
			local var_606_28 = math.max(var_606_22, arg_603_1.talkMaxDuration)

			if var_606_21 + 0.3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_27 + var_606_28 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_27) / var_606_28

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_27 + var_606_28 and arg_603_1.time_ < var_606_27 + var_606_28 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_603_1:InitPlayNodeList()
	end,
	Play302011148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 302011148
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play302011149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.25

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_609_1.callingController_:SetSelectedState("normal")

				arg_609_1.keyicon_.color = Color.New(1, 1, 1)
				arg_609_1.icon_.color = Color.New(1, 1, 1)

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(302011148).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 10 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 10)

				if (10 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 10)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play302011149 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 302011149
		arg_613_1.duration_ = 4

		local var_613_0 = {
			zh = 4,
			ja = 3.666
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play302011150(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if arg_613_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_616_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_613_1.stage_.transform)

				var_616_0.name = "1019ui_story"
				var_616_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_613_1.actors_["1019ui_story"] = var_616_0

				local var_616_1 = var_616_0:GetComponentInChildren(typeof(CharacterEffect))

				var_616_1.enabled = true

				local var_616_2 = GameObjectTools.GetOrAddComponent(var_616_0, typeof(DynamicBoneHelper))

				if var_616_2 then
					var_616_2:EnableDynamicBone(false)
				end

				arg_613_1:ShowWeapon(var_616_1.transform, false)

				arg_613_1.var_["1019ui_story" .. "Animator"] = var_616_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_613_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_613_1.var_["1019ui_story" .. "LipSync"] = var_616_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_616_3 = arg_613_1.actors_["1019ui_story"].transform

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.var_.moveOldPos1019ui_story = var_616_3.localPosition
			end

			local var_616_4 = 0.001

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_4 then
				var_616_3.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_613_1.time_ - 0) / var_616_4)
				var_616_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_616_3.position).x, (manager.ui.mainCamera.transform.position - var_616_3.position).y, (manager.ui.mainCamera.transform.position - var_616_3.position).z)
				var_616_3.localEulerAngles.z = 0
				var_616_3.localEulerAngles.x = 0
				var_616_3.localEulerAngles = var_616_3.localEulerAngles
			end

			if arg_613_1.time_ >= 0 + var_616_4 and arg_613_1.time_ < 0 + var_616_4 + arg_616_0 then
				var_616_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_616_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_616_3.position).x, (manager.ui.mainCamera.transform.position - var_616_3.position).y, (manager.ui.mainCamera.transform.position - var_616_3.position).z)
				var_616_3.localEulerAngles.z = 0
				var_616_3.localEulerAngles.x = 0
				var_616_3.localEulerAngles = var_616_3.localEulerAngles
			end

			local var_616_5 = arg_613_1.actors_["1019ui_story"]

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(var_616_5) and arg_613_1.var_.characterEffect1019ui_story == nil then
				arg_613_1.var_.characterEffect1019ui_story = var_616_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_6 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_6 and not isNil(var_616_5) then
				if arg_613_1.var_.characterEffect1019ui_story and not isNil(var_616_5) then
					arg_613_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_613_1.time_ >= 0 + var_616_6 and arg_613_1.time_ < 0 + var_616_6 + arg_616_0 and not isNil(var_616_5) and arg_613_1.var_.characterEffect1019ui_story then
				arg_613_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_616_8 = 0
			local var_616_9 = 0.45

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_8 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_10 = arg_613_1:GetWordFromCfg(302011149)
				local var_616_11 = arg_613_1:FormatText(var_616_10.content)

				arg_613_1.text_.text = var_616_11

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_13 = 18 <= 0 and var_616_9 or var_616_9 * (utf8.len(var_616_11) / 18)

				if (18 <= 0 and var_616_9 or var_616_9 * (utf8.len(var_616_11) / 18)) > 0 and var_616_9 < var_616_13 then
					arg_613_1.talkMaxDuration = var_616_13

					if var_616_13 + var_616_8 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_13 + var_616_8
					end
				end

				arg_613_1.text_.text = var_616_11
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011149", "story_v_out_302011.awb") ~= 0 then
					local var_616_14 = manager.audio:GetVoiceLength("story_v_out_302011", "302011149", "story_v_out_302011.awb") / 1000

					if var_616_14 + var_616_8 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_14 + var_616_8
					end

					if var_616_10.prefab_name ~= "" and arg_613_1.actors_[var_616_10.prefab_name] ~= nil then
						local var_616_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_10.prefab_name].transform, "story_v_out_302011", "302011149", "story_v_out_302011.awb")

						arg_613_1:RecordAudio("302011149", var_616_15)
						arg_613_1:RecordAudio("302011149", var_616_15)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_302011", "302011149", "story_v_out_302011.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_302011", "302011149", "story_v_out_302011.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_16 = math.max(var_616_9, arg_613_1.talkMaxDuration)

			if var_616_8 <= arg_613_1.time_ and arg_613_1.time_ < var_616_8 + var_616_16 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_8) / var_616_16

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_8 + var_616_16 and arg_613_1.time_ < var_616_8 + var_616_16 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
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

		arg_613_1:InitPlayNodeList()
	end,
	Play302011150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 302011150
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play302011151(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) and arg_617_1.var_.characterEffect1019ui_story == nil then
				arg_617_1.var_.characterEffect1019ui_story = arg_617_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_0 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) then
				if arg_617_1.var_.characterEffect1019ui_story and not isNil(arg_617_1.actors_["1019ui_story"]) then
					arg_617_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_617_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_617_1.time_ - 0) / var_620_0)
				end
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 and not isNil(arg_617_1.actors_["1019ui_story"]) and arg_617_1.var_.characterEffect1019ui_story then
				arg_617_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_617_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_620_1 = 0
			local var_620_2 = 0.425

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, true)
				arg_617_1.iconController_:SetSelectedState("hero")

				arg_617_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_617_1.callingController_:SetSelectedState("normal")

				arg_617_1.keyicon_.color = Color.New(1, 1, 1)
				arg_617_1.icon_.color = Color.New(1, 1, 1)

				local var_620_3 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(302011150).content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 17 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 17)

				if (17 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 17)) > 0 and var_620_2 < var_620_5 then
					arg_617_1.talkMaxDuration = var_620_5

					if var_620_5 + var_620_1 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + var_620_1
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_6 = math.max(var_620_2, arg_617_1.talkMaxDuration)

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_6 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_1) / var_620_6

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_1 + var_620_6 and arg_617_1.time_ < var_620_1 + var_620_6 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play302011151 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 302011151
		arg_621_1.duration_ = 8.9

		local var_621_0 = {
			zh = 6.8,
			ja = 8.9
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play302011152(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) and arg_621_1.var_.characterEffect1019ui_story == nil then
				arg_621_1.var_.characterEffect1019ui_story = arg_621_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_0 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) then
				if arg_621_1.var_.characterEffect1019ui_story and not isNil(arg_621_1.actors_["1019ui_story"]) then
					arg_621_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 and not isNil(arg_621_1.actors_["1019ui_story"]) and arg_621_1.var_.characterEffect1019ui_story then
				arg_621_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_624_2 = 0
			local var_624_3 = 0.85

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_2 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_4 = arg_621_1:GetWordFromCfg(302011151)
				local var_624_5 = arg_621_1:FormatText(var_624_4.content)

				arg_621_1.text_.text = var_624_5

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_7 = 34 <= 0 and var_624_3 or var_624_3 * (utf8.len(var_624_5) / 34)

				if (34 <= 0 and var_624_3 or var_624_3 * (utf8.len(var_624_5) / 34)) > 0 and var_624_3 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_2 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_2
					end
				end

				arg_621_1.text_.text = var_624_5
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011151", "story_v_out_302011.awb") ~= 0 then
					local var_624_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011151", "story_v_out_302011.awb") / 1000

					if var_624_8 + var_624_2 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_2
					end

					if var_624_4.prefab_name ~= "" and arg_621_1.actors_[var_624_4.prefab_name] ~= nil then
						local var_624_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_4.prefab_name].transform, "story_v_out_302011", "302011151", "story_v_out_302011.awb")

						arg_621_1:RecordAudio("302011151", var_624_9)
						arg_621_1:RecordAudio("302011151", var_624_9)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_302011", "302011151", "story_v_out_302011.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_302011", "302011151", "story_v_out_302011.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = math.max(var_624_3, arg_621_1.talkMaxDuration)

			if var_624_2 <= arg_621_1.time_ and arg_621_1.time_ < var_624_2 + var_624_10 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_2) / var_624_10

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_2 + var_624_10 and arg_621_1.time_ < var_624_2 + var_624_10 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play302011152 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 302011152
		arg_625_1.duration_ = 4.27

		local var_625_0 = {
			zh = 4.266,
			ja = 1.333
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play302011153(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if arg_625_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_628_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_625_1.stage_.transform)

				var_628_0.name = "1037ui_story"
				var_628_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_625_1.actors_["1037ui_story"] = var_628_0

				local var_628_1 = var_628_0:GetComponentInChildren(typeof(CharacterEffect))

				var_628_1.enabled = true

				local var_628_2 = GameObjectTools.GetOrAddComponent(var_628_0, typeof(DynamicBoneHelper))

				if var_628_2 then
					var_628_2:EnableDynamicBone(false)
				end

				arg_625_1:ShowWeapon(var_628_1.transform, false)

				arg_625_1.var_["1037ui_story" .. "Animator"] = var_628_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_625_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_625_1.var_["1037ui_story" .. "LipSync"] = var_628_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_628_3 = arg_625_1.actors_["1037ui_story"].transform

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.var_.moveOldPos1037ui_story = var_628_3.localPosition
			end

			local var_628_4 = 0.001

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				var_628_3.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1037ui_story, Vector3.New(0.7, -1.09, -5.81), (arg_625_1.time_ - 0) / var_628_4)
				var_628_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_628_3.position).x, (manager.ui.mainCamera.transform.position - var_628_3.position).y, (manager.ui.mainCamera.transform.position - var_628_3.position).z)
				var_628_3.localEulerAngles.z = 0
				var_628_3.localEulerAngles.x = 0
				var_628_3.localEulerAngles = var_628_3.localEulerAngles
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				var_628_3.localPosition = Vector3.New(0.7, -1.09, -5.81)
				var_628_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_628_3.position).x, (manager.ui.mainCamera.transform.position - var_628_3.position).y, (manager.ui.mainCamera.transform.position - var_628_3.position).z)
				var_628_3.localEulerAngles.z = 0
				var_628_3.localEulerAngles.x = 0
				var_628_3.localEulerAngles = var_628_3.localEulerAngles
			end

			local var_628_5 = arg_625_1.actors_["1019ui_story"].transform

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.var_.moveOldPos1019ui_story = var_628_5.localPosition
			end

			local var_628_6 = 0.001

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_6 then
				var_628_5.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_625_1.time_ - 0) / var_628_6)
				var_628_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_628_5.position).x, (manager.ui.mainCamera.transform.position - var_628_5.position).y, (manager.ui.mainCamera.transform.position - var_628_5.position).z)
				var_628_5.localEulerAngles.z = 0
				var_628_5.localEulerAngles.x = 0
				var_628_5.localEulerAngles = var_628_5.localEulerAngles
			end

			if arg_625_1.time_ >= 0 + var_628_6 and arg_625_1.time_ < 0 + var_628_6 + arg_628_0 then
				var_628_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_628_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_628_5.position).x, (manager.ui.mainCamera.transform.position - var_628_5.position).y, (manager.ui.mainCamera.transform.position - var_628_5.position).z)
				var_628_5.localEulerAngles.z = 0
				var_628_5.localEulerAngles.x = 0
				var_628_5.localEulerAngles = var_628_5.localEulerAngles
			end

			local var_628_7 = arg_625_1.actors_["1037ui_story"]

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(var_628_7) and arg_625_1.var_.characterEffect1037ui_story == nil then
				arg_625_1.var_.characterEffect1037ui_story = var_628_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_8 = 0.200000002980232

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_8 and not isNil(var_628_7) then
				if arg_625_1.var_.characterEffect1037ui_story and not isNil(var_628_7) then
					arg_625_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= 0 + var_628_8 and arg_625_1.time_ < 0 + var_628_8 + arg_628_0 and not isNil(var_628_7) and arg_625_1.var_.characterEffect1037ui_story then
				arg_625_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_628_10 = arg_625_1.actors_["1019ui_story"]

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(var_628_10) and arg_625_1.var_.characterEffect1019ui_story == nil then
				arg_625_1.var_.characterEffect1019ui_story = var_628_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_11 = 0.200000002980232

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_11 and not isNil(var_628_10) then
				if arg_625_1.var_.characterEffect1019ui_story and not isNil(var_628_10) then
					arg_625_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_625_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_625_1.time_ - 0) / var_628_11)
				end
			end

			if arg_625_1.time_ >= 0 + var_628_11 and arg_625_1.time_ < 0 + var_628_11 + arg_628_0 and not isNil(var_628_10) and arg_625_1.var_.characterEffect1019ui_story then
				arg_625_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_625_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_628_12 = 0
			local var_628_13 = 0.325

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_12 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_14 = arg_625_1:GetWordFromCfg(302011152)
				local var_628_15 = arg_625_1:FormatText(var_628_14.content)

				arg_625_1.text_.text = var_628_15

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_17 = 13 <= 0 and var_628_13 or var_628_13 * (utf8.len(var_628_15) / 13)

				if (13 <= 0 and var_628_13 or var_628_13 * (utf8.len(var_628_15) / 13)) > 0 and var_628_13 < var_628_17 then
					arg_625_1.talkMaxDuration = var_628_17

					if var_628_17 + var_628_12 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_17 + var_628_12
					end
				end

				arg_625_1.text_.text = var_628_15
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011152", "story_v_out_302011.awb") ~= 0 then
					local var_628_18 = manager.audio:GetVoiceLength("story_v_out_302011", "302011152", "story_v_out_302011.awb") / 1000

					if var_628_18 + var_628_12 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_18 + var_628_12
					end

					if var_628_14.prefab_name ~= "" and arg_625_1.actors_[var_628_14.prefab_name] ~= nil then
						local var_628_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_14.prefab_name].transform, "story_v_out_302011", "302011152", "story_v_out_302011.awb")

						arg_625_1:RecordAudio("302011152", var_628_19)
						arg_625_1:RecordAudio("302011152", var_628_19)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_out_302011", "302011152", "story_v_out_302011.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_out_302011", "302011152", "story_v_out_302011.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_20 = math.max(var_628_13, arg_625_1.talkMaxDuration)

			if var_628_12 <= arg_625_1.time_ and arg_625_1.time_ < var_628_12 + var_628_20 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_12) / var_628_20

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_12 + var_628_20 and arg_625_1.time_ < var_628_12 + var_628_20 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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

		arg_625_1:InitPlayNodeList()
	end,
	Play302011153 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 302011153
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play302011154(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.var_.moveOldPos1037ui_story = arg_629_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_632_0 = 0.001

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 then
				arg_629_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_629_1.time_ - 0) / var_632_0)
				arg_629_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).z)
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles = arg_629_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 then
				arg_629_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_629_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1037ui_story"].transform.position).z)
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1037ui_story"].transform.localEulerAngles = arg_629_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_632_1 = arg_629_1.actors_["1019ui_story"].transform

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.var_.moveOldPos1019ui_story = var_632_1.localPosition
			end

			local var_632_2 = 0.001

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_2 then
				var_632_1.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_629_1.time_ - 0) / var_632_2)
				var_632_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_1.position).x, (manager.ui.mainCamera.transform.position - var_632_1.position).y, (manager.ui.mainCamera.transform.position - var_632_1.position).z)
				var_632_1.localEulerAngles.z = 0
				var_632_1.localEulerAngles.x = 0
				var_632_1.localEulerAngles = var_632_1.localEulerAngles
			end

			if arg_629_1.time_ >= 0 + var_632_2 and arg_629_1.time_ < 0 + var_632_2 + arg_632_0 then
				var_632_1.localPosition = Vector3.New(0, 100, 0)
				var_632_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_632_1.position).x, (manager.ui.mainCamera.transform.position - var_632_1.position).y, (manager.ui.mainCamera.transform.position - var_632_1.position).z)
				var_632_1.localEulerAngles.z = 0
				var_632_1.localEulerAngles.x = 0
				var_632_1.localEulerAngles = var_632_1.localEulerAngles
			end

			local var_632_3 = arg_629_1.actors_["1037ui_story"]

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 and not isNil(var_632_3) and arg_629_1.var_.characterEffect1037ui_story == nil then
				arg_629_1.var_.characterEffect1037ui_story = var_632_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_4 = 0.200000002980232

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 and not isNil(var_632_3) then
				if arg_629_1.var_.characterEffect1037ui_story and not isNil(var_632_3) then
					arg_629_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_629_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_629_1.time_ - 0) / var_632_4)
				end
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 and not isNil(var_632_3) and arg_629_1.var_.characterEffect1037ui_story then
				arg_629_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_629_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_632_5 = 0
			local var_632_6 = 1.4

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_5 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_7 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(302011153).content)

				arg_629_1.text_.text = var_632_7

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_9 = 56 <= 0 and var_632_6 or var_632_6 * (utf8.len(var_632_7) / 56)

				if (56 <= 0 and var_632_6 or var_632_6 * (utf8.len(var_632_7) / 56)) > 0 and var_632_6 < var_632_9 then
					arg_629_1.talkMaxDuration = var_632_9

					if var_632_9 + var_632_5 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_9 + var_632_5
					end
				end

				arg_629_1.text_.text = var_632_7
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_10 = math.max(var_632_6, arg_629_1.talkMaxDuration)

			if var_632_5 <= arg_629_1.time_ and arg_629_1.time_ < var_632_5 + var_632_10 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_5) / var_632_10

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_5 + var_632_10 and arg_629_1.time_ < var_632_5 + var_632_10 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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

		arg_629_1:InitPlayNodeList()
	end,
	Play302011154 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 302011154
		arg_633_1.duration_ = 8.87

		local var_633_0 = {
			zh = 5.466,
			ja = 8.866
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play302011155(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if arg_633_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_636_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_633_1.stage_.transform)

				var_636_0.name = "1084ui_story"
				var_636_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_633_1.actors_["1084ui_story"] = var_636_0

				local var_636_1 = var_636_0:GetComponentInChildren(typeof(CharacterEffect))

				var_636_1.enabled = true

				local var_636_2 = GameObjectTools.GetOrAddComponent(var_636_0, typeof(DynamicBoneHelper))

				if var_636_2 then
					var_636_2:EnableDynamicBone(false)
				end

				arg_633_1:ShowWeapon(var_636_1.transform, false)

				arg_633_1.var_["1084ui_story" .. "Animator"] = var_636_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_633_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_633_1.var_["1084ui_story" .. "LipSync"] = var_636_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_636_3 = arg_633_1.actors_["1084ui_story"].transform

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.var_.moveOldPos1084ui_story = var_636_3.localPosition
			end

			local var_636_4 = 0.001

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_4 then
				var_636_3.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_633_1.time_ - 0) / var_636_4)
				var_636_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_636_3.position).x, (manager.ui.mainCamera.transform.position - var_636_3.position).y, (manager.ui.mainCamera.transform.position - var_636_3.position).z)
				var_636_3.localEulerAngles.z = 0
				var_636_3.localEulerAngles.x = 0
				var_636_3.localEulerAngles = var_636_3.localEulerAngles
			end

			if arg_633_1.time_ >= 0 + var_636_4 and arg_633_1.time_ < 0 + var_636_4 + arg_636_0 then
				var_636_3.localPosition = Vector3.New(0, -0.97, -6)
				var_636_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_636_3.position).x, (manager.ui.mainCamera.transform.position - var_636_3.position).y, (manager.ui.mainCamera.transform.position - var_636_3.position).z)
				var_636_3.localEulerAngles.z = 0
				var_636_3.localEulerAngles.x = 0
				var_636_3.localEulerAngles = var_636_3.localEulerAngles
			end

			local var_636_5 = arg_633_1.actors_["1084ui_story"]

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(var_636_5) and arg_633_1.var_.characterEffect1084ui_story == nil then
				arg_633_1.var_.characterEffect1084ui_story = var_636_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_6 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_6 and not isNil(var_636_5) then
				if arg_633_1.var_.characterEffect1084ui_story and not isNil(var_636_5) then
					arg_633_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_6 and arg_633_1.time_ < 0 + var_636_6 + arg_636_0 and not isNil(var_636_5) and arg_633_1.var_.characterEffect1084ui_story then
				arg_633_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_636_8 = 0
			local var_636_9 = 0.675

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_8 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_10 = arg_633_1:GetWordFromCfg(302011154)
				local var_636_11 = arg_633_1:FormatText(var_636_10.content)

				arg_633_1.text_.text = var_636_11

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_13 = 27 <= 0 and var_636_9 or var_636_9 * (utf8.len(var_636_11) / 27)

				if (27 <= 0 and var_636_9 or var_636_9 * (utf8.len(var_636_11) / 27)) > 0 and var_636_9 < var_636_13 then
					arg_633_1.talkMaxDuration = var_636_13

					if var_636_13 + var_636_8 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_13 + var_636_8
					end
				end

				arg_633_1.text_.text = var_636_11
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011154", "story_v_out_302011.awb") ~= 0 then
					local var_636_14 = manager.audio:GetVoiceLength("story_v_out_302011", "302011154", "story_v_out_302011.awb") / 1000

					if var_636_14 + var_636_8 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_14 + var_636_8
					end

					if var_636_10.prefab_name ~= "" and arg_633_1.actors_[var_636_10.prefab_name] ~= nil then
						local var_636_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_10.prefab_name].transform, "story_v_out_302011", "302011154", "story_v_out_302011.awb")

						arg_633_1:RecordAudio("302011154", var_636_15)
						arg_633_1:RecordAudio("302011154", var_636_15)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_302011", "302011154", "story_v_out_302011.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_302011", "302011154", "story_v_out_302011.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_16 = math.max(var_636_9, arg_633_1.talkMaxDuration)

			if var_636_8 <= arg_633_1.time_ and arg_633_1.time_ < var_636_8 + var_636_16 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_8) / var_636_16

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_8 + var_636_16 and arg_633_1.time_ < var_636_8 + var_636_16 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
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

		arg_633_1:InitPlayNodeList()
	end,
	Play302011155 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 302011155
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play302011156(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 and not isNil(arg_637_1.actors_["1084ui_story"]) and arg_637_1.var_.characterEffect1084ui_story == nil then
				arg_637_1.var_.characterEffect1084ui_story = arg_637_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_0 = 0.200000002980232

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_0 and not isNil(arg_637_1.actors_["1084ui_story"]) then
				if arg_637_1.var_.characterEffect1084ui_story and not isNil(arg_637_1.actors_["1084ui_story"]) then
					arg_637_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_637_1.time_ - 0) / var_640_0)
				end
			end

			if arg_637_1.time_ >= 0 + var_640_0 and arg_637_1.time_ < 0 + var_640_0 + arg_640_0 and not isNil(arg_637_1.actors_["1084ui_story"]) and arg_637_1.var_.characterEffect1084ui_story then
				arg_637_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_640_1 = 0
			local var_640_2 = 0.275

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_3 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(302011155).content)

				arg_637_1.text_.text = var_640_3

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 11 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 11)

				if (11 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 11)) > 0 and var_640_2 < var_640_5 then
					arg_637_1.talkMaxDuration = var_640_5

					if var_640_5 + var_640_1 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + var_640_1
					end
				end

				arg_637_1.text_.text = var_640_3
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_6 = math.max(var_640_2, arg_637_1.talkMaxDuration)

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_6 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_1) / var_640_6

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_1 + var_640_6 and arg_637_1.time_ < var_640_1 + var_640_6 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play302011156 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 302011156
		arg_641_1.duration_ = 7.53

		local var_641_0 = {
			zh = 7.266,
			ja = 7.533
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play302011157(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.var_.moveOldPos1084ui_story = arg_641_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_644_0 = 0.001

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 then
				arg_641_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_641_1.time_ - 0) / var_644_0)
				arg_641_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).z)
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles = arg_641_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 then
				arg_641_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_641_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1084ui_story"].transform.position).z)
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1084ui_story"].transform.localEulerAngles = arg_641_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_644_1 = arg_641_1.actors_["1019ui_story"].transform

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.var_.moveOldPos1019ui_story = var_644_1.localPosition
			end

			local var_644_2 = 0.001

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_2 then
				var_644_1.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_641_1.time_ - 0) / var_644_2)
				var_644_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_644_1.position).x, (manager.ui.mainCamera.transform.position - var_644_1.position).y, (manager.ui.mainCamera.transform.position - var_644_1.position).z)
				var_644_1.localEulerAngles.z = 0
				var_644_1.localEulerAngles.x = 0
				var_644_1.localEulerAngles = var_644_1.localEulerAngles
			end

			if arg_641_1.time_ >= 0 + var_644_2 and arg_641_1.time_ < 0 + var_644_2 + arg_644_0 then
				var_644_1.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_644_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_644_1.position).x, (manager.ui.mainCamera.transform.position - var_644_1.position).y, (manager.ui.mainCamera.transform.position - var_644_1.position).z)
				var_644_1.localEulerAngles.z = 0
				var_644_1.localEulerAngles.x = 0
				var_644_1.localEulerAngles = var_644_1.localEulerAngles
			end

			local var_644_3 = arg_641_1.actors_["1019ui_story"]

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(var_644_3) and arg_641_1.var_.characterEffect1019ui_story == nil then
				arg_641_1.var_.characterEffect1019ui_story = var_644_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_4 = 0.200000002980232

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_4 and not isNil(var_644_3) then
				if arg_641_1.var_.characterEffect1019ui_story and not isNil(var_644_3) then
					arg_641_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 0 + var_644_4 and arg_641_1.time_ < 0 + var_644_4 + arg_644_0 and not isNil(var_644_3) and arg_641_1.var_.characterEffect1019ui_story then
				arg_641_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_644_6 = 0
			local var_644_7 = 0.975

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_6 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_8 = arg_641_1:GetWordFromCfg(302011156)
				local var_644_9 = arg_641_1:FormatText(var_644_8.content)

				arg_641_1.text_.text = var_644_9

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_11 = 39 <= 0 and var_644_7 or var_644_7 * (utf8.len(var_644_9) / 39)

				if (39 <= 0 and var_644_7 or var_644_7 * (utf8.len(var_644_9) / 39)) > 0 and var_644_7 < var_644_11 then
					arg_641_1.talkMaxDuration = var_644_11

					if var_644_11 + var_644_6 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_11 + var_644_6
					end
				end

				arg_641_1.text_.text = var_644_9
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011156", "story_v_out_302011.awb") ~= 0 then
					local var_644_12 = manager.audio:GetVoiceLength("story_v_out_302011", "302011156", "story_v_out_302011.awb") / 1000

					if var_644_12 + var_644_6 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_12 + var_644_6
					end

					if var_644_8.prefab_name ~= "" and arg_641_1.actors_[var_644_8.prefab_name] ~= nil then
						local var_644_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_8.prefab_name].transform, "story_v_out_302011", "302011156", "story_v_out_302011.awb")

						arg_641_1:RecordAudio("302011156", var_644_13)
						arg_641_1:RecordAudio("302011156", var_644_13)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_302011", "302011156", "story_v_out_302011.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_302011", "302011156", "story_v_out_302011.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_14 = math.max(var_644_7, arg_641_1.talkMaxDuration)

			if var_644_6 <= arg_641_1.time_ and arg_641_1.time_ < var_644_6 + var_644_14 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_6) / var_644_14

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_6 + var_644_14 and arg_641_1.time_ < var_644_6 + var_644_14 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
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

		arg_641_1:InitPlayNodeList()
	end,
	Play302011157 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 302011157
		arg_645_1.duration_ = 7.4

		local var_645_0 = {
			zh = 6.233,
			ja = 7.4
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play302011158(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_648_0 = 0
			local var_648_1 = 0.9

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(302011157)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 36 <= 0 and var_648_1 or var_648_1 * (utf8.len(var_648_3) / 36)

				if (36 <= 0 and var_648_1 or var_648_1 * (utf8.len(var_648_3) / 36)) > 0 and var_648_1 < var_648_5 then
					arg_645_1.talkMaxDuration = var_648_5

					if var_648_5 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_5 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011157", "story_v_out_302011.awb") ~= 0 then
					local var_648_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011157", "story_v_out_302011.awb") / 1000

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end

					if var_648_2.prefab_name ~= "" and arg_645_1.actors_[var_648_2.prefab_name] ~= nil then
						local var_648_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_2.prefab_name].transform, "story_v_out_302011", "302011157", "story_v_out_302011.awb")

						arg_645_1:RecordAudio("302011157", var_648_7)
						arg_645_1:RecordAudio("302011157", var_648_7)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_out_302011", "302011157", "story_v_out_302011.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_out_302011", "302011157", "story_v_out_302011.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play302011158 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 302011158
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play302011159(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 and not isNil(arg_649_1.actors_["1019ui_story"]) and arg_649_1.var_.characterEffect1019ui_story == nil then
				arg_649_1.var_.characterEffect1019ui_story = arg_649_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_0 = 0.200000002980232

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_0 and not isNil(arg_649_1.actors_["1019ui_story"]) then
				if arg_649_1.var_.characterEffect1019ui_story and not isNil(arg_649_1.actors_["1019ui_story"]) then
					arg_649_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_649_1.time_ - 0) / var_652_0)
				end
			end

			if arg_649_1.time_ >= 0 + var_652_0 and arg_649_1.time_ < 0 + var_652_0 + arg_652_0 and not isNil(arg_649_1.actors_["1019ui_story"]) and arg_649_1.var_.characterEffect1019ui_story then
				arg_649_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_652_1 = 0
			local var_652_2 = 0.225

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_3 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(302011158).content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 9 <= 0 and var_652_2 or var_652_2 * (utf8.len(var_652_3) / 9)

				if (9 <= 0 and var_652_2 or var_652_2 * (utf8.len(var_652_3) / 9)) > 0 and var_652_2 < var_652_5 then
					arg_649_1.talkMaxDuration = var_652_5

					if var_652_5 + var_652_1 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_5 + var_652_1
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_6 = math.max(var_652_2, arg_649_1.talkMaxDuration)

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_6 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_1) / var_652_6

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_1 + var_652_6 and arg_649_1.time_ < var_652_1 + var_652_6 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play302011159 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 302011159
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play302011160(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos1019ui_story = arg_653_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_656_0 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 then
				arg_653_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_653_1.time_ - 0) / var_656_0)
				arg_653_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).z)
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles = arg_653_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 then
				arg_653_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_653_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1019ui_story"].transform.position).z)
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1019ui_story"].transform.localEulerAngles = arg_653_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_656_1 = 0
			local var_656_2 = 1.025

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_3 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(302011159).content)

				arg_653_1.text_.text = var_656_3

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_5 = 41 <= 0 and var_656_2 or var_656_2 * (utf8.len(var_656_3) / 41)

				if (41 <= 0 and var_656_2 or var_656_2 * (utf8.len(var_656_3) / 41)) > 0 and var_656_2 < var_656_5 then
					arg_653_1.talkMaxDuration = var_656_5

					if var_656_5 + var_656_1 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_5 + var_656_1
					end
				end

				arg_653_1.text_.text = var_656_3
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_6 = math.max(var_656_2, arg_653_1.talkMaxDuration)

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_6 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_1) / var_656_6

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_1 + var_656_6 and arg_653_1.time_ < var_656_1 + var_656_6 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
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

		arg_653_1:InitPlayNodeList()
	end,
	Play302011160 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 302011160
		arg_657_1.duration_ = 5.07

		local var_657_0 = {
			zh = 5.066,
			ja = 1.999999999999
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play302011161(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos1037ui_story = arg_657_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_660_0 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 then
				arg_657_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_657_1.time_ - 0) / var_660_0)
				arg_657_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).z)
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles = arg_657_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 then
				arg_657_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_657_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1037ui_story"].transform.position).z)
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1037ui_story"].transform.localEulerAngles = arg_657_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_660_1 = arg_657_1.actors_["1037ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1037ui_story == nil then
				arg_657_1.var_.characterEffect1037ui_story = var_660_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_2 and not isNil(var_660_1) then
				if arg_657_1.var_.characterEffect1037ui_story and not isNil(var_660_1) then
					arg_657_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= 0 + var_660_2 and arg_657_1.time_ < 0 + var_660_2 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1037ui_story then
				arg_657_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_660_4 = 0
			local var_660_5 = 0.625

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_6 = arg_657_1:GetWordFromCfg(302011160)
				local var_660_7 = arg_657_1:FormatText(var_660_6.content)

				arg_657_1.text_.text = var_660_7

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_9 = 25 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 25)

				if (25 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 25)) > 0 and var_660_5 < var_660_9 then
					arg_657_1.talkMaxDuration = var_660_9

					if var_660_9 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_9 + var_660_4
					end
				end

				arg_657_1.text_.text = var_660_7
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011160", "story_v_out_302011.awb") ~= 0 then
					local var_660_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011160", "story_v_out_302011.awb") / 1000

					if var_660_10 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_10 + var_660_4
					end

					if var_660_6.prefab_name ~= "" and arg_657_1.actors_[var_660_6.prefab_name] ~= nil then
						local var_660_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_6.prefab_name].transform, "story_v_out_302011", "302011160", "story_v_out_302011.awb")

						arg_657_1:RecordAudio("302011160", var_660_11)
						arg_657_1:RecordAudio("302011160", var_660_11)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_302011", "302011160", "story_v_out_302011.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_302011", "302011160", "story_v_out_302011.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_12 = math.max(var_660_5, arg_657_1.talkMaxDuration)

			if var_660_4 <= arg_657_1.time_ and arg_657_1.time_ < var_660_4 + var_660_12 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_4) / var_660_12

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_4 + var_660_12 and arg_657_1.time_ < var_660_4 + var_660_12 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_657_1:InitPlayNodeList()
	end,
	Play302011161 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 302011161
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play302011162(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1037ui_story"]) and arg_661_1.var_.characterEffect1037ui_story == nil then
				arg_661_1.var_.characterEffect1037ui_story = arg_661_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.200000002980232

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1037ui_story"]) then
				if arg_661_1.var_.characterEffect1037ui_story and not isNil(arg_661_1.actors_["1037ui_story"]) then
					arg_661_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_661_1.time_ - 0) / var_664_0)
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1037ui_story"]) and arg_661_1.var_.characterEffect1037ui_story then
				arg_661_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_664_1 = 0
			local var_664_2 = 0.3

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, true)
				arg_661_1.iconController_:SetSelectedState("hero")

				arg_661_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_661_1.callingController_:SetSelectedState("normal")

				arg_661_1.keyicon_.color = Color.New(1, 1, 1)
				arg_661_1.icon_.color = Color.New(1, 1, 1)

				local var_664_3 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(302011161).content)

				arg_661_1.text_.text = var_664_3

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 12 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 12)

				if (12 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 12)) > 0 and var_664_2 < var_664_5 then
					arg_661_1.talkMaxDuration = var_664_5

					if var_664_5 + var_664_1 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_5 + var_664_1
					end
				end

				arg_661_1.text_.text = var_664_3
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_6 = math.max(var_664_2, arg_661_1.talkMaxDuration)

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_6 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_1) / var_664_6

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_1 + var_664_6 and arg_661_1.time_ < var_664_1 + var_664_6 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play302011162 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 302011162
		arg_665_1.duration_ = 9.97

		local var_665_0 = {
			zh = 9.966,
			ja = 1.999999999999
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play302011163(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 and not isNil(arg_665_1.actors_["1037ui_story"]) and arg_665_1.var_.characterEffect1037ui_story == nil then
				arg_665_1.var_.characterEffect1037ui_story = arg_665_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_0 = 0.200000002980232

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 and not isNil(arg_665_1.actors_["1037ui_story"]) then
				if arg_665_1.var_.characterEffect1037ui_story and not isNil(arg_665_1.actors_["1037ui_story"]) then
					arg_665_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 and not isNil(arg_665_1.actors_["1037ui_story"]) and arg_665_1.var_.characterEffect1037ui_story then
				arg_665_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action425")
			end

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_668_2 = 0
			local var_668_3 = 0.875

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_2 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_4 = arg_665_1:GetWordFromCfg(302011162)
				local var_668_5 = arg_665_1:FormatText(var_668_4.content)

				arg_665_1.text_.text = var_668_5

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_7 = 35 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_5) / 35)

				if (35 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_5) / 35)) > 0 and var_668_3 < var_668_7 then
					arg_665_1.talkMaxDuration = var_668_7

					if var_668_7 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_7 + var_668_2
					end
				end

				arg_665_1.text_.text = var_668_5
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011162", "story_v_out_302011.awb") ~= 0 then
					local var_668_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011162", "story_v_out_302011.awb") / 1000

					if var_668_8 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_8 + var_668_2
					end

					if var_668_4.prefab_name ~= "" and arg_665_1.actors_[var_668_4.prefab_name] ~= nil then
						local var_668_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_4.prefab_name].transform, "story_v_out_302011", "302011162", "story_v_out_302011.awb")

						arg_665_1:RecordAudio("302011162", var_668_9)
						arg_665_1:RecordAudio("302011162", var_668_9)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_302011", "302011162", "story_v_out_302011.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_302011", "302011162", "story_v_out_302011.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_10 = math.max(var_668_3, arg_665_1.talkMaxDuration)

			if var_668_2 <= arg_665_1.time_ and arg_665_1.time_ < var_668_2 + var_668_10 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_2) / var_668_10

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_2 + var_668_10 and arg_665_1.time_ < var_668_2 + var_668_10 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play302011163 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 302011163
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play302011164(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["1037ui_story"]) and arg_669_1.var_.characterEffect1037ui_story == nil then
				arg_669_1.var_.characterEffect1037ui_story = arg_669_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_0 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["1037ui_story"]) then
				if arg_669_1.var_.characterEffect1037ui_story and not isNil(arg_669_1.actors_["1037ui_story"]) then
					arg_669_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_669_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_669_1.time_ - 0) / var_672_0)
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["1037ui_story"]) and arg_669_1.var_.characterEffect1037ui_story then
				arg_669_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_669_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_672_1 = 0
			local var_672_2 = 0.575

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_3 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(302011163).content)

				arg_669_1.text_.text = var_672_3

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_5 = 23 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 23)

				if (23 <= 0 and var_672_2 or var_672_2 * (utf8.len(var_672_3) / 23)) > 0 and var_672_2 < var_672_5 then
					arg_669_1.talkMaxDuration = var_672_5

					if var_672_5 + var_672_1 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_5 + var_672_1
					end
				end

				arg_669_1.text_.text = var_672_3
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_6 = math.max(var_672_2, arg_669_1.talkMaxDuration)

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_6 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_1) / var_672_6

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_1 + var_672_6 and arg_669_1.time_ < var_672_1 + var_672_6 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play302011164 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 302011164
		arg_673_1.duration_ = 5.03

		local var_673_0 = {
			zh = 5.033,
			ja = 1.999999999999
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play302011165(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["1037ui_story"]) and arg_673_1.var_.characterEffect1037ui_story == nil then
				arg_673_1.var_.characterEffect1037ui_story = arg_673_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["1037ui_story"]) then
				if arg_673_1.var_.characterEffect1037ui_story and not isNil(arg_673_1.actors_["1037ui_story"]) then
					arg_673_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["1037ui_story"]) and arg_673_1.var_.characterEffect1037ui_story then
				arg_673_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action453")
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_676_2 = 0
			local var_676_3 = 0.55

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_2 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_4 = arg_673_1:GetWordFromCfg(302011164)
				local var_676_5 = arg_673_1:FormatText(var_676_4.content)

				arg_673_1.text_.text = var_676_5

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_7 = 22 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 22)

				if (22 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_5) / 22)) > 0 and var_676_3 < var_676_7 then
					arg_673_1.talkMaxDuration = var_676_7

					if var_676_7 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_7 + var_676_2
					end
				end

				arg_673_1.text_.text = var_676_5
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011164", "story_v_out_302011.awb") ~= 0 then
					local var_676_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011164", "story_v_out_302011.awb") / 1000

					if var_676_8 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_8 + var_676_2
					end

					if var_676_4.prefab_name ~= "" and arg_673_1.actors_[var_676_4.prefab_name] ~= nil then
						local var_676_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_4.prefab_name].transform, "story_v_out_302011", "302011164", "story_v_out_302011.awb")

						arg_673_1:RecordAudio("302011164", var_676_9)
						arg_673_1:RecordAudio("302011164", var_676_9)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_out_302011", "302011164", "story_v_out_302011.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_out_302011", "302011164", "story_v_out_302011.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_10 = math.max(var_676_3, arg_673_1.talkMaxDuration)

			if var_676_2 <= arg_673_1.time_ and arg_673_1.time_ < var_676_2 + var_676_10 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_2) / var_676_10

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_2 + var_676_10 and arg_673_1.time_ < var_676_2 + var_676_10 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play302011165 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 302011165
		arg_677_1.duration_ = 4.17

		local var_677_0 = {
			zh = 4.166,
			ja = 1.333
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play302011166(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = 0.45

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_1 = arg_677_1:GetWordFromCfg(302011165)
				local var_680_2 = arg_677_1:FormatText(var_680_1.content)

				arg_677_1.text_.text = var_680_2

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_4 = 18 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 18)

				if (18 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 18)) > 0 and var_680_0 < var_680_4 then
					arg_677_1.talkMaxDuration = var_680_4

					if var_680_4 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_4 + 0
					end
				end

				arg_677_1.text_.text = var_680_2
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011165", "story_v_out_302011.awb") ~= 0 then
					local var_680_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011165", "story_v_out_302011.awb") / 1000

					if var_680_5 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_5 + 0
					end

					if var_680_1.prefab_name ~= "" and arg_677_1.actors_[var_680_1.prefab_name] ~= nil then
						local var_680_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_1.prefab_name].transform, "story_v_out_302011", "302011165", "story_v_out_302011.awb")

						arg_677_1:RecordAudio("302011165", var_680_6)
						arg_677_1:RecordAudio("302011165", var_680_6)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_302011", "302011165", "story_v_out_302011.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_302011", "302011165", "story_v_out_302011.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_7 = math.max(var_680_0, arg_677_1.talkMaxDuration)

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_7 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - 0) / var_680_7

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= 0 + var_680_7 and arg_677_1.time_ < 0 + var_680_7 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play302011166 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 302011166
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play302011167(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.var_.moveOldPos1037ui_story = arg_681_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_684_0 = 0.001

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_0 then
				arg_681_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_681_1.time_ - 0) / var_684_0)
				arg_681_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).z)
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles = arg_681_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_681_1.time_ >= 0 + var_684_0 and arg_681_1.time_ < 0 + var_684_0 + arg_684_0 then
				arg_681_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_681_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_681_1.actors_["1037ui_story"].transform.position).z)
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_681_1.actors_["1037ui_story"].transform.localEulerAngles = arg_681_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_684_1 = arg_681_1.actors_["1037ui_story"]

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 and not isNil(var_684_1) and arg_681_1.var_.characterEffect1037ui_story == nil then
				arg_681_1.var_.characterEffect1037ui_story = var_684_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_2 = 0.200000002980232

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_2 and not isNil(var_684_1) then
				if arg_681_1.var_.characterEffect1037ui_story and not isNil(var_684_1) then
					arg_681_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_681_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_681_1.time_ - 0) / var_684_2)
				end
			end

			if arg_681_1.time_ >= 0 + var_684_2 and arg_681_1.time_ < 0 + var_684_2 + arg_684_0 and not isNil(var_684_1) and arg_681_1.var_.characterEffect1037ui_story then
				arg_681_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_681_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_684_3 = 0
			local var_684_4 = 1.75

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_3 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, false)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_5 = arg_681_1:FormatText(arg_681_1:GetWordFromCfg(302011166).content)

				arg_681_1.text_.text = var_684_5

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_7 = 70 <= 0 and var_684_4 or var_684_4 * (utf8.len(var_684_5) / 70)

				if (70 <= 0 and var_684_4 or var_684_4 * (utf8.len(var_684_5) / 70)) > 0 and var_684_4 < var_684_7 then
					arg_681_1.talkMaxDuration = var_684_7

					if var_684_7 + var_684_3 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_7 + var_684_3
					end
				end

				arg_681_1.text_.text = var_684_5
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_8 = math.max(var_684_4, arg_681_1.talkMaxDuration)

			if var_684_3 <= arg_681_1.time_ and arg_681_1.time_ < var_684_3 + var_684_8 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_3) / var_684_8

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_3 + var_684_8 and arg_681_1.time_ < var_684_3 + var_684_8 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play302011167 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 302011167
		arg_685_1.duration_ = 3.97

		local var_685_0 = {
			zh = 3.966,
			ja = 1.333
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play302011168(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.var_.moveOldPos1037ui_story = arg_685_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_688_0 = 0.001

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_0 then
				arg_685_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_685_1.time_ - 0) / var_688_0)
				arg_685_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).z)
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles = arg_685_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_685_1.time_ >= 0 + var_688_0 and arg_685_1.time_ < 0 + var_688_0 + arg_688_0 then
				arg_685_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_685_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_685_1.actors_["1037ui_story"].transform.position).z)
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_685_1.actors_["1037ui_story"].transform.localEulerAngles = arg_685_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_688_1 = arg_685_1.actors_["1037ui_story"]

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 and not isNil(var_688_1) and arg_685_1.var_.characterEffect1037ui_story == nil then
				arg_685_1.var_.characterEffect1037ui_story = var_688_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_2 = 0.200000002980232

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_2 and not isNil(var_688_1) then
				if arg_685_1.var_.characterEffect1037ui_story and not isNil(var_688_1) then
					arg_685_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= 0 + var_688_2 and arg_685_1.time_ < 0 + var_688_2 + arg_688_0 and not isNil(var_688_1) and arg_685_1.var_.characterEffect1037ui_story then
				arg_685_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_688_4 = 0
			local var_688_5 = 0.75

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_4 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_6 = arg_685_1:GetWordFromCfg(302011167)
				local var_688_7 = arg_685_1:FormatText(var_688_6.content)

				arg_685_1.text_.text = var_688_7

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_9 = 30 <= 0 and var_688_5 or var_688_5 * (utf8.len(var_688_7) / 30)

				if (30 <= 0 and var_688_5 or var_688_5 * (utf8.len(var_688_7) / 30)) > 0 and var_688_5 < var_688_9 then
					arg_685_1.talkMaxDuration = var_688_9

					if var_688_9 + var_688_4 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_9 + var_688_4
					end
				end

				arg_685_1.text_.text = var_688_7
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011167", "story_v_out_302011.awb") ~= 0 then
					local var_688_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011167", "story_v_out_302011.awb") / 1000

					if var_688_10 + var_688_4 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_10 + var_688_4
					end

					if var_688_6.prefab_name ~= "" and arg_685_1.actors_[var_688_6.prefab_name] ~= nil then
						local var_688_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_6.prefab_name].transform, "story_v_out_302011", "302011167", "story_v_out_302011.awb")

						arg_685_1:RecordAudio("302011167", var_688_11)
						arg_685_1:RecordAudio("302011167", var_688_11)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_out_302011", "302011167", "story_v_out_302011.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_out_302011", "302011167", "story_v_out_302011.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_12 = math.max(var_688_5, arg_685_1.talkMaxDuration)

			if var_688_4 <= arg_685_1.time_ and arg_685_1.time_ < var_688_4 + var_688_12 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_4) / var_688_12

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_4 + var_688_12 and arg_685_1.time_ < var_688_4 + var_688_12 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_685_1:InitPlayNodeList()
	end,
	Play302011168 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 302011168
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play302011169(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 and not isNil(arg_689_1.actors_["1037ui_story"]) and arg_689_1.var_.characterEffect1037ui_story == nil then
				arg_689_1.var_.characterEffect1037ui_story = arg_689_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_0 = 0.200000002980232

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_0 and not isNil(arg_689_1.actors_["1037ui_story"]) then
				if arg_689_1.var_.characterEffect1037ui_story and not isNil(arg_689_1.actors_["1037ui_story"]) then
					arg_689_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_689_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_689_1.time_ - 0) / var_692_0)
				end
			end

			if arg_689_1.time_ >= 0 + var_692_0 and arg_689_1.time_ < 0 + var_692_0 + arg_692_0 and not isNil(arg_689_1.actors_["1037ui_story"]) and arg_689_1.var_.characterEffect1037ui_story then
				arg_689_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_689_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_692_1 = 0
			local var_692_2 = 0.575

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_3 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(302011168).content)

				arg_689_1.text_.text = var_692_3

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 23 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 23)

				if (23 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 23)) > 0 and var_692_2 < var_692_5 then
					arg_689_1.talkMaxDuration = var_692_5

					if var_692_5 + var_692_1 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_5 + var_692_1
					end
				end

				arg_689_1.text_.text = var_692_3
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_6 = math.max(var_692_2, arg_689_1.talkMaxDuration)

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_6 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_1) / var_692_6

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_1 + var_692_6 and arg_689_1.time_ < var_692_1 + var_692_6 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play302011169 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 302011169
		arg_693_1.duration_ = 5.83

		local var_693_0 = {
			zh = 5.133,
			ja = 5.833
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play302011170(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.var_.moveOldPos1037ui_story = arg_693_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_696_0 = 0.001

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_0 then
				arg_693_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_693_1.time_ - 0) / var_696_0)
				arg_693_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).z)
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles = arg_693_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_693_1.time_ >= 0 + var_696_0 and arg_693_1.time_ < 0 + var_696_0 + arg_696_0 then
				arg_693_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_693_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_693_1.actors_["1037ui_story"].transform.position).z)
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_693_1.actors_["1037ui_story"].transform.localEulerAngles = arg_693_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_696_1 = arg_693_1.actors_["1019ui_story"].transform

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.var_.moveOldPos1019ui_story = var_696_1.localPosition
			end

			local var_696_2 = 0.001

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_2 then
				var_696_1.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_693_1.time_ - 0) / var_696_2)
				var_696_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_1.position).x, (manager.ui.mainCamera.transform.position - var_696_1.position).y, (manager.ui.mainCamera.transform.position - var_696_1.position).z)
				var_696_1.localEulerAngles.z = 0
				var_696_1.localEulerAngles.x = 0
				var_696_1.localEulerAngles = var_696_1.localEulerAngles
			end

			if arg_693_1.time_ >= 0 + var_696_2 and arg_693_1.time_ < 0 + var_696_2 + arg_696_0 then
				var_696_1.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_696_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_696_1.position).x, (manager.ui.mainCamera.transform.position - var_696_1.position).y, (manager.ui.mainCamera.transform.position - var_696_1.position).z)
				var_696_1.localEulerAngles.z = 0
				var_696_1.localEulerAngles.x = 0
				var_696_1.localEulerAngles = var_696_1.localEulerAngles
			end

			local var_696_3 = arg_693_1.actors_["1019ui_story"]

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 and not isNil(var_696_3) and arg_693_1.var_.characterEffect1019ui_story == nil then
				arg_693_1.var_.characterEffect1019ui_story = var_696_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_4 = 0.200000002980232

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_4 and not isNil(var_696_3) then
				if arg_693_1.var_.characterEffect1019ui_story and not isNil(var_696_3) then
					arg_693_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= 0 + var_696_4 and arg_693_1.time_ < 0 + var_696_4 + arg_696_0 and not isNil(var_696_3) and arg_693_1.var_.characterEffect1019ui_story then
				arg_693_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_696_6 = 0
			local var_696_7 = 0.7

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_6 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_8 = arg_693_1:GetWordFromCfg(302011169)
				local var_696_9 = arg_693_1:FormatText(var_696_8.content)

				arg_693_1.text_.text = var_696_9

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_11 = 28 <= 0 and var_696_7 or var_696_7 * (utf8.len(var_696_9) / 28)

				if (28 <= 0 and var_696_7 or var_696_7 * (utf8.len(var_696_9) / 28)) > 0 and var_696_7 < var_696_11 then
					arg_693_1.talkMaxDuration = var_696_11

					if var_696_11 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_11 + var_696_6
					end
				end

				arg_693_1.text_.text = var_696_9
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011169", "story_v_out_302011.awb") ~= 0 then
					local var_696_12 = manager.audio:GetVoiceLength("story_v_out_302011", "302011169", "story_v_out_302011.awb") / 1000

					if var_696_12 + var_696_6 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_12 + var_696_6
					end

					if var_696_8.prefab_name ~= "" and arg_693_1.actors_[var_696_8.prefab_name] ~= nil then
						local var_696_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_8.prefab_name].transform, "story_v_out_302011", "302011169", "story_v_out_302011.awb")

						arg_693_1:RecordAudio("302011169", var_696_13)
						arg_693_1:RecordAudio("302011169", var_696_13)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_out_302011", "302011169", "story_v_out_302011.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_out_302011", "302011169", "story_v_out_302011.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_14 = math.max(var_696_7, arg_693_1.talkMaxDuration)

			if var_696_6 <= arg_693_1.time_ and arg_693_1.time_ < var_696_6 + var_696_14 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_6) / var_696_14

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_6 + var_696_14 and arg_693_1.time_ < var_696_6 + var_696_14 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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

		arg_693_1:InitPlayNodeList()
	end,
	Play302011170 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 302011170
		arg_697_1.duration_ = 9.07

		local var_697_0 = {
			zh = 8.766,
			ja = 9.066
		}
		local var_697_1 = manager.audio:GetLocalizationFlag()

		if var_697_0[var_697_1] ~= nil then
			arg_697_1.duration_ = var_697_0[var_697_1]
		end

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play302011171(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_700_0 = 0
			local var_700_1 = 1.375

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_0 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				arg_697_1.leftNameTxt_.text = arg_697_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_2 = arg_697_1:GetWordFromCfg(302011170)
				local var_700_3 = arg_697_1:FormatText(var_700_2.content)

				arg_697_1.text_.text = var_700_3

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_5 = 55 <= 0 and var_700_1 or var_700_1 * (utf8.len(var_700_3) / 55)

				if (55 <= 0 and var_700_1 or var_700_1 * (utf8.len(var_700_3) / 55)) > 0 and var_700_1 < var_700_5 then
					arg_697_1.talkMaxDuration = var_700_5

					if var_700_5 + var_700_0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_5 + var_700_0
					end
				end

				arg_697_1.text_.text = var_700_3
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011170", "story_v_out_302011.awb") ~= 0 then
					local var_700_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011170", "story_v_out_302011.awb") / 1000

					if var_700_6 + var_700_0 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_6 + var_700_0
					end

					if var_700_2.prefab_name ~= "" and arg_697_1.actors_[var_700_2.prefab_name] ~= nil then
						local var_700_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_697_1.actors_[var_700_2.prefab_name].transform, "story_v_out_302011", "302011170", "story_v_out_302011.awb")

						arg_697_1:RecordAudio("302011170", var_700_7)
						arg_697_1:RecordAudio("302011170", var_700_7)
					else
						arg_697_1:AudioAction("play", "voice", "story_v_out_302011", "302011170", "story_v_out_302011.awb")
					end

					arg_697_1:RecordHistoryTalkVoice("story_v_out_302011", "302011170", "story_v_out_302011.awb")
				end

				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_8 = math.max(var_700_1, arg_697_1.talkMaxDuration)

			if var_700_0 <= arg_697_1.time_ and arg_697_1.time_ < var_700_0 + var_700_8 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_0) / var_700_8

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_0 + var_700_8 and arg_697_1.time_ < var_700_0 + var_700_8 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play302011171 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 302011171
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play302011172(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 and not isNil(arg_701_1.actors_["1019ui_story"]) and arg_701_1.var_.characterEffect1019ui_story == nil then
				arg_701_1.var_.characterEffect1019ui_story = arg_701_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_704_0 = 0.200000002980232

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_0 and not isNil(arg_701_1.actors_["1019ui_story"]) then
				if arg_701_1.var_.characterEffect1019ui_story and not isNil(arg_701_1.actors_["1019ui_story"]) then
					arg_701_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_701_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_701_1.time_ - 0) / var_704_0)
				end
			end

			if arg_701_1.time_ >= 0 + var_704_0 and arg_701_1.time_ < 0 + var_704_0 + arg_704_0 and not isNil(arg_701_1.actors_["1019ui_story"]) and arg_701_1.var_.characterEffect1019ui_story then
				arg_701_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_701_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_704_1 = 0
			local var_704_2 = 0.425

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_1 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_3 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(302011171).content)

				arg_701_1.text_.text = var_704_3

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_5 = 17 <= 0 and var_704_2 or var_704_2 * (utf8.len(var_704_3) / 17)

				if (17 <= 0 and var_704_2 or var_704_2 * (utf8.len(var_704_3) / 17)) > 0 and var_704_2 < var_704_5 then
					arg_701_1.talkMaxDuration = var_704_5

					if var_704_5 + var_704_1 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_5 + var_704_1
					end
				end

				arg_701_1.text_.text = var_704_3
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_6 = math.max(var_704_2, arg_701_1.talkMaxDuration)

			if var_704_1 <= arg_701_1.time_ and arg_701_1.time_ < var_704_1 + var_704_6 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_1) / var_704_6

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_1 + var_704_6 and arg_701_1.time_ < var_704_1 + var_704_6 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play302011172 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 302011172
		arg_705_1.duration_ = 7.33

		local var_705_0 = {
			zh = 4.633,
			ja = 7.333
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play302011173(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos1019ui_story = arg_705_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_708_0 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_0 then
				arg_705_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_705_1.time_ - 0) / var_708_0)
				arg_705_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).z)
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles = arg_705_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_0 and arg_705_1.time_ < 0 + var_708_0 + arg_708_0 then
				arg_705_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_705_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_705_1.actors_["1019ui_story"].transform.position).z)
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_705_1.actors_["1019ui_story"].transform.localEulerAngles = arg_705_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_708_1 = arg_705_1.actors_["1084ui_story"].transform

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.var_.moveOldPos1084ui_story = var_708_1.localPosition
			end

			local var_708_2 = 0.001

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_2 then
				var_708_1.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_705_1.time_ - 0) / var_708_2)
				var_708_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_708_1.position).x, (manager.ui.mainCamera.transform.position - var_708_1.position).y, (manager.ui.mainCamera.transform.position - var_708_1.position).z)
				var_708_1.localEulerAngles.z = 0
				var_708_1.localEulerAngles.x = 0
				var_708_1.localEulerAngles = var_708_1.localEulerAngles
			end

			if arg_705_1.time_ >= 0 + var_708_2 and arg_705_1.time_ < 0 + var_708_2 + arg_708_0 then
				var_708_1.localPosition = Vector3.New(0, -0.97, -6)
				var_708_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_708_1.position).x, (manager.ui.mainCamera.transform.position - var_708_1.position).y, (manager.ui.mainCamera.transform.position - var_708_1.position).z)
				var_708_1.localEulerAngles.z = 0
				var_708_1.localEulerAngles.x = 0
				var_708_1.localEulerAngles = var_708_1.localEulerAngles
			end

			local var_708_3 = arg_705_1.actors_["1084ui_story"]

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 and not isNil(var_708_3) and arg_705_1.var_.characterEffect1084ui_story == nil then
				arg_705_1.var_.characterEffect1084ui_story = var_708_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_4 = 0.200000002980232

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_4 and not isNil(var_708_3) then
				if arg_705_1.var_.characterEffect1084ui_story and not isNil(var_708_3) then
					arg_705_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= 0 + var_708_4 and arg_705_1.time_ < 0 + var_708_4 + arg_708_0 and not isNil(var_708_3) and arg_705_1.var_.characterEffect1084ui_story then
				arg_705_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_708_6 = 0
			local var_708_7 = 0.6

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_6 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_8 = arg_705_1:GetWordFromCfg(302011172)
				local var_708_9 = arg_705_1:FormatText(var_708_8.content)

				arg_705_1.text_.text = var_708_9

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_11 = 24 <= 0 and var_708_7 or var_708_7 * (utf8.len(var_708_9) / 24)

				if (24 <= 0 and var_708_7 or var_708_7 * (utf8.len(var_708_9) / 24)) > 0 and var_708_7 < var_708_11 then
					arg_705_1.talkMaxDuration = var_708_11

					if var_708_11 + var_708_6 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_11 + var_708_6
					end
				end

				arg_705_1.text_.text = var_708_9
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011172", "story_v_out_302011.awb") ~= 0 then
					local var_708_12 = manager.audio:GetVoiceLength("story_v_out_302011", "302011172", "story_v_out_302011.awb") / 1000

					if var_708_12 + var_708_6 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_12 + var_708_6
					end

					if var_708_8.prefab_name ~= "" and arg_705_1.actors_[var_708_8.prefab_name] ~= nil then
						local var_708_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_8.prefab_name].transform, "story_v_out_302011", "302011172", "story_v_out_302011.awb")

						arg_705_1:RecordAudio("302011172", var_708_13)
						arg_705_1:RecordAudio("302011172", var_708_13)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_out_302011", "302011172", "story_v_out_302011.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_out_302011", "302011172", "story_v_out_302011.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_14 = math.max(var_708_7, arg_705_1.talkMaxDuration)

			if var_708_6 <= arg_705_1.time_ and arg_705_1.time_ < var_708_6 + var_708_14 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_6) / var_708_14

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_6 + var_708_14 and arg_705_1.time_ < var_708_6 + var_708_14 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_705_1:InitPlayNodeList()
	end,
	Play302011173 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 302011173
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play302011174(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 and not isNil(arg_709_1.actors_["1084ui_story"]) and arg_709_1.var_.characterEffect1084ui_story == nil then
				arg_709_1.var_.characterEffect1084ui_story = arg_709_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_0 = 0.200000002980232

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 and not isNil(arg_709_1.actors_["1084ui_story"]) then
				if arg_709_1.var_.characterEffect1084ui_story and not isNil(arg_709_1.actors_["1084ui_story"]) then
					arg_709_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_709_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_709_1.time_ - 0) / var_712_0)
				end
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 and not isNil(arg_709_1.actors_["1084ui_story"]) and arg_709_1.var_.characterEffect1084ui_story then
				arg_709_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_709_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_712_1 = 0
			local var_712_2 = 0.475

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, true)

				arg_709_1.leftNameTxt_.text = arg_709_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_709_1.leftNameTxt_.transform)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1.leftNameTxt_.text)
				SetActive(arg_709_1.iconTrs_.gameObject, true)
				arg_709_1.iconController_:SetSelectedState("hero")

				arg_709_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_709_1.callingController_:SetSelectedState("normal")

				arg_709_1.keyicon_.color = Color.New(1, 1, 1)
				arg_709_1.icon_.color = Color.New(1, 1, 1)

				local var_712_3 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(302011173).content)

				arg_709_1.text_.text = var_712_3

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_5 = 19 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 19)

				if (19 <= 0 and var_712_2 or var_712_2 * (utf8.len(var_712_3) / 19)) > 0 and var_712_2 < var_712_5 then
					arg_709_1.talkMaxDuration = var_712_5

					if var_712_5 + var_712_1 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_5 + var_712_1
					end
				end

				arg_709_1.text_.text = var_712_3
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_6 = math.max(var_712_2, arg_709_1.talkMaxDuration)

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_6 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_1) / var_712_6

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_1 + var_712_6 and arg_709_1.time_ < var_712_1 + var_712_6 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play302011174 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 302011174
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play302011175(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.55

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(302011174).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 22 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 22)

				if (22 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 22)) > 0 and var_716_0 < var_716_3 then
					arg_713_1.talkMaxDuration = var_716_3

					if var_716_3 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_3 + 0
					end
				end

				arg_713_1.text_.text = var_716_1
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_4 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_4 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_4

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_4 and arg_713_1.time_ < 0 + var_716_4 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play302011175 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 302011175
		arg_717_1.duration_ = 3.97

		local var_717_0 = {
			zh = 3.066,
			ja = 3.966
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play302011176(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.var_.moveOldPos1084ui_story = arg_717_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_720_0 = 0.001

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_0 then
				arg_717_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_717_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_717_1.time_ - 0) / var_720_0)
				arg_717_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).z)
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles = arg_717_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_717_1.time_ >= 0 + var_720_0 and arg_717_1.time_ < 0 + var_720_0 + arg_720_0 then
				arg_717_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_717_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_717_1.actors_["1084ui_story"].transform.position).z)
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_717_1.actors_["1084ui_story"].transform.localEulerAngles = arg_717_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_720_1 = arg_717_1.actors_["1084ui_story"]

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 and not isNil(var_720_1) and arg_717_1.var_.characterEffect1084ui_story == nil then
				arg_717_1.var_.characterEffect1084ui_story = var_720_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.200000002980232

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_2 and not isNil(var_720_1) then
				if arg_717_1.var_.characterEffect1084ui_story and not isNil(var_720_1) then
					arg_717_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_717_1.time_ >= 0 + var_720_2 and arg_717_1.time_ < 0 + var_720_2 + arg_720_0 and not isNil(var_720_1) and arg_717_1.var_.characterEffect1084ui_story then
				arg_717_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_720_4 = 0
			local var_720_5 = 0.175

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_4 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_6 = arg_717_1:GetWordFromCfg(302011175)
				local var_720_7 = arg_717_1:FormatText(var_720_6.content)

				arg_717_1.text_.text = var_720_7

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_9 = 7 <= 0 and var_720_5 or var_720_5 * (utf8.len(var_720_7) / 7)

				if (7 <= 0 and var_720_5 or var_720_5 * (utf8.len(var_720_7) / 7)) > 0 and var_720_5 < var_720_9 then
					arg_717_1.talkMaxDuration = var_720_9

					if var_720_9 + var_720_4 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_9 + var_720_4
					end
				end

				arg_717_1.text_.text = var_720_7
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011175", "story_v_out_302011.awb") ~= 0 then
					local var_720_10 = manager.audio:GetVoiceLength("story_v_out_302011", "302011175", "story_v_out_302011.awb") / 1000

					if var_720_10 + var_720_4 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_10 + var_720_4
					end

					if var_720_6.prefab_name ~= "" and arg_717_1.actors_[var_720_6.prefab_name] ~= nil then
						local var_720_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_6.prefab_name].transform, "story_v_out_302011", "302011175", "story_v_out_302011.awb")

						arg_717_1:RecordAudio("302011175", var_720_11)
						arg_717_1:RecordAudio("302011175", var_720_11)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_out_302011", "302011175", "story_v_out_302011.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_out_302011", "302011175", "story_v_out_302011.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_12 = math.max(var_720_5, arg_717_1.talkMaxDuration)

			if var_720_4 <= arg_717_1.time_ and arg_717_1.time_ < var_720_4 + var_720_12 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_4) / var_720_12

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_4 + var_720_12 and arg_717_1.time_ < var_720_4 + var_720_12 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {
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

		arg_717_1:InitPlayNodeList()
	end,
	Play302011176 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 302011176
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play302011177(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) and arg_721_1.var_.characterEffect1084ui_story == nil then
				arg_721_1.var_.characterEffect1084ui_story = arg_721_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_0 = 0.200000002980232

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) then
				if arg_721_1.var_.characterEffect1084ui_story and not isNil(arg_721_1.actors_["1084ui_story"]) then
					arg_721_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_721_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_721_1.time_ - 0) / var_724_0)
				end
			end

			if arg_721_1.time_ >= 0 + var_724_0 and arg_721_1.time_ < 0 + var_724_0 + arg_724_0 and not isNil(arg_721_1.actors_["1084ui_story"]) and arg_721_1.var_.characterEffect1084ui_story then
				arg_721_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_721_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_724_1 = 0
			local var_724_2 = 0.625

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_3 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(302011176).content)

				arg_721_1.text_.text = var_724_3

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_5 = 25 <= 0 and var_724_2 or var_724_2 * (utf8.len(var_724_3) / 25)

				if (25 <= 0 and var_724_2 or var_724_2 * (utf8.len(var_724_3) / 25)) > 0 and var_724_2 < var_724_5 then
					arg_721_1.talkMaxDuration = var_724_5

					if var_724_5 + var_724_1 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_5 + var_724_1
					end
				end

				arg_721_1.text_.text = var_724_3
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_6 = math.max(var_724_2, arg_721_1.talkMaxDuration)

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_6 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_1) / var_724_6

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_1 + var_724_6 and arg_721_1.time_ < var_724_1 + var_724_6 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play302011177 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 302011177
		arg_725_1.duration_ = 5.4

		local var_725_0 = {
			zh = 5.4,
			ja = 5.233
		}
		local var_725_1 = manager.audio:GetLocalizationFlag()

		if var_725_0[var_725_1] ~= nil then
			arg_725_1.duration_ = var_725_0[var_725_1]
		end

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play302011178(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.var_.moveOldPos1019ui_story = arg_725_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_728_0 = 0.001

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_0 then
				arg_725_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_725_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_725_1.time_ - 0) / var_728_0)
				arg_725_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).z)
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles = arg_725_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_725_1.time_ >= 0 + var_728_0 and arg_725_1.time_ < 0 + var_728_0 + arg_728_0 then
				arg_725_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_725_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_725_1.actors_["1019ui_story"].transform.position).z)
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_725_1.actors_["1019ui_story"].transform.localEulerAngles = arg_725_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_728_1 = arg_725_1.actors_["1019ui_story"]

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 and not isNil(var_728_1) and arg_725_1.var_.characterEffect1019ui_story == nil then
				arg_725_1.var_.characterEffect1019ui_story = var_728_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_728_2 = 0.200000002980232

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_2 and not isNil(var_728_1) then
				if arg_725_1.var_.characterEffect1019ui_story and not isNil(var_728_1) then
					arg_725_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_725_1.time_ >= 0 + var_728_2 and arg_725_1.time_ < 0 + var_728_2 + arg_728_0 and not isNil(var_728_1) and arg_725_1.var_.characterEffect1019ui_story then
				arg_725_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_728_4 = arg_725_1.actors_["1084ui_story"].transform

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1.var_.moveOldPos1084ui_story = var_728_4.localPosition
			end

			local var_728_5 = 0.001

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_5 then
				var_728_4.localPosition = Vector3.Lerp(arg_725_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_725_1.time_ - 0) / var_728_5)
				var_728_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_728_4.position).x, (manager.ui.mainCamera.transform.position - var_728_4.position).y, (manager.ui.mainCamera.transform.position - var_728_4.position).z)
				var_728_4.localEulerAngles.z = 0
				var_728_4.localEulerAngles.x = 0
				var_728_4.localEulerAngles = var_728_4.localEulerAngles
			end

			if arg_725_1.time_ >= 0 + var_728_5 and arg_725_1.time_ < 0 + var_728_5 + arg_728_0 then
				var_728_4.localPosition = Vector3.New(0, 100, 0)
				var_728_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_728_4.position).x, (manager.ui.mainCamera.transform.position - var_728_4.position).y, (manager.ui.mainCamera.transform.position - var_728_4.position).z)
				var_728_4.localEulerAngles.z = 0
				var_728_4.localEulerAngles.x = 0
				var_728_4.localEulerAngles = var_728_4.localEulerAngles
			end

			local var_728_6 = 0
			local var_728_7 = 0.575

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_6 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_8 = arg_725_1:GetWordFromCfg(302011177)
				local var_728_9 = arg_725_1:FormatText(var_728_8.content)

				arg_725_1.text_.text = var_728_9

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_11 = 23 <= 0 and var_728_7 or var_728_7 * (utf8.len(var_728_9) / 23)

				if (23 <= 0 and var_728_7 or var_728_7 * (utf8.len(var_728_9) / 23)) > 0 and var_728_7 < var_728_11 then
					arg_725_1.talkMaxDuration = var_728_11

					if var_728_11 + var_728_6 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_11 + var_728_6
					end
				end

				arg_725_1.text_.text = var_728_9
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011177", "story_v_out_302011.awb") ~= 0 then
					local var_728_12 = manager.audio:GetVoiceLength("story_v_out_302011", "302011177", "story_v_out_302011.awb") / 1000

					if var_728_12 + var_728_6 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_12 + var_728_6
					end

					if var_728_8.prefab_name ~= "" and arg_725_1.actors_[var_728_8.prefab_name] ~= nil then
						local var_728_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_725_1.actors_[var_728_8.prefab_name].transform, "story_v_out_302011", "302011177", "story_v_out_302011.awb")

						arg_725_1:RecordAudio("302011177", var_728_13)
						arg_725_1:RecordAudio("302011177", var_728_13)
					else
						arg_725_1:AudioAction("play", "voice", "story_v_out_302011", "302011177", "story_v_out_302011.awb")
					end

					arg_725_1:RecordHistoryTalkVoice("story_v_out_302011", "302011177", "story_v_out_302011.awb")
				end

				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_14 = math.max(var_728_7, arg_725_1.talkMaxDuration)

			if var_728_6 <= arg_725_1.time_ and arg_725_1.time_ < var_728_6 + var_728_14 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_6) / var_728_14

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_6 + var_728_14 and arg_725_1.time_ < var_728_6 + var_728_14 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_725_1:InitPlayNodeList()
	end,
	Play302011178 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 302011178
		arg_729_1.duration_ = 8.37

		local var_729_0 = {
			zh = 6.166,
			ja = 8.366
		}
		local var_729_1 = manager.audio:GetLocalizationFlag()

		if var_729_0[var_729_1] ~= nil then
			arg_729_1.duration_ = var_729_0[var_729_1]
		end

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play302011179(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_732_0 = 0
			local var_732_1 = 0.775

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_2 = arg_729_1:GetWordFromCfg(302011178)
				local var_732_3 = arg_729_1:FormatText(var_732_2.content)

				arg_729_1.text_.text = var_732_3

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 31 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 31)

				if (31 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 31)) > 0 and var_732_1 < var_732_5 then
					arg_729_1.talkMaxDuration = var_732_5

					if var_732_5 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_5 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_3
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011178", "story_v_out_302011.awb") ~= 0 then
					local var_732_6 = manager.audio:GetVoiceLength("story_v_out_302011", "302011178", "story_v_out_302011.awb") / 1000

					if var_732_6 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_6 + var_732_0
					end

					if var_732_2.prefab_name ~= "" and arg_729_1.actors_[var_732_2.prefab_name] ~= nil then
						local var_732_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_2.prefab_name].transform, "story_v_out_302011", "302011178", "story_v_out_302011.awb")

						arg_729_1:RecordAudio("302011178", var_732_7)
						arg_729_1:RecordAudio("302011178", var_732_7)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_out_302011", "302011178", "story_v_out_302011.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_out_302011", "302011178", "story_v_out_302011.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play302011179 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 302011179
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play302011180(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 and not isNil(arg_733_1.actors_["1019ui_story"]) and arg_733_1.var_.characterEffect1019ui_story == nil then
				arg_733_1.var_.characterEffect1019ui_story = arg_733_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_0 = 0.200000002980232

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_0 and not isNil(arg_733_1.actors_["1019ui_story"]) then
				if arg_733_1.var_.characterEffect1019ui_story and not isNil(arg_733_1.actors_["1019ui_story"]) then
					arg_733_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_733_1.time_ - 0) / var_736_0)
				end
			end

			if arg_733_1.time_ >= 0 + var_736_0 and arg_733_1.time_ < 0 + var_736_0 + arg_736_0 and not isNil(arg_733_1.actors_["1019ui_story"]) and arg_733_1.var_.characterEffect1019ui_story then
				arg_733_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_736_1 = 0
			local var_736_2 = 0.6

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				arg_733_1.leftNameTxt_.text = arg_733_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_733_1.callingController_:SetSelectedState("normal")

				arg_733_1.keyicon_.color = Color.New(1, 1, 1)
				arg_733_1.icon_.color = Color.New(1, 1, 1)

				local var_736_3 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(302011179).content)

				arg_733_1.text_.text = var_736_3

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 24 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 24)

				if (24 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 24)) > 0 and var_736_2 < var_736_5 then
					arg_733_1.talkMaxDuration = var_736_5

					if var_736_5 + var_736_1 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_5 + var_736_1
					end
				end

				arg_733_1.text_.text = var_736_3
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_6 = math.max(var_736_2, arg_733_1.talkMaxDuration)

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_6 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_1) / var_736_6

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_1 + var_736_6 and arg_733_1.time_ < var_736_1 + var_736_6 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play302011180 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 302011180
		arg_737_1.duration_ = 5.5

		local var_737_0 = {
			zh = 4.2,
			ja = 5.5
		}
		local var_737_1 = manager.audio:GetLocalizationFlag()

		if var_737_0[var_737_1] ~= nil then
			arg_737_1.duration_ = var_737_0[var_737_1]
		end

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play302011181(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["1019ui_story"]) and arg_737_1.var_.characterEffect1019ui_story == nil then
				arg_737_1.var_.characterEffect1019ui_story = arg_737_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.200000002980232

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["1019ui_story"]) then
				if arg_737_1.var_.characterEffect1019ui_story and not isNil(arg_737_1.actors_["1019ui_story"]) then
					arg_737_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["1019ui_story"]) and arg_737_1.var_.characterEffect1019ui_story then
				arg_737_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_740_2 = 0
			local var_740_3 = 0.5

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_2 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_4 = arg_737_1:GetWordFromCfg(302011180)
				local var_740_5 = arg_737_1:FormatText(var_740_4.content)

				arg_737_1.text_.text = var_740_5

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_7 = 20 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_5) / 20)

				if (20 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_5) / 20)) > 0 and var_740_3 < var_740_7 then
					arg_737_1.talkMaxDuration = var_740_7

					if var_740_7 + var_740_2 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_7 + var_740_2
					end
				end

				arg_737_1.text_.text = var_740_5
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011180", "story_v_out_302011.awb") ~= 0 then
					local var_740_8 = manager.audio:GetVoiceLength("story_v_out_302011", "302011180", "story_v_out_302011.awb") / 1000

					if var_740_8 + var_740_2 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_8 + var_740_2
					end

					if var_740_4.prefab_name ~= "" and arg_737_1.actors_[var_740_4.prefab_name] ~= nil then
						local var_740_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_4.prefab_name].transform, "story_v_out_302011", "302011180", "story_v_out_302011.awb")

						arg_737_1:RecordAudio("302011180", var_740_9)
						arg_737_1:RecordAudio("302011180", var_740_9)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_out_302011", "302011180", "story_v_out_302011.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_out_302011", "302011180", "story_v_out_302011.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_10 = math.max(var_740_3, arg_737_1.talkMaxDuration)

			if var_740_2 <= arg_737_1.time_ and arg_737_1.time_ < var_740_2 + var_740_10 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_2) / var_740_10

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_2 + var_740_10 and arg_737_1.time_ < var_740_2 + var_740_10 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play302011181 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 302011181
		arg_741_1.duration_ = 10.37

		local var_741_0 = {
			zh = 6.433,
			ja = 10.366
		}
		local var_741_1 = manager.audio:GetLocalizationFlag()

		if var_741_0[var_741_1] ~= nil then
			arg_741_1.duration_ = var_741_0[var_741_1]
		end

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
			arg_741_1.auto_ = false
		end

		function arg_741_1.playNext_(arg_743_0)
			arg_741_1.onStoryFinished_()
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0.8

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				arg_741_1.leftNameTxt_.text = arg_741_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_1 = arg_741_1:GetWordFromCfg(302011181)
				local var_744_2 = arg_741_1:FormatText(var_744_1.content)

				arg_741_1.text_.text = var_744_2

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_4 = 32 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_2) / 32)

				if (32 <= 0 and var_744_0 or var_744_0 * (utf8.len(var_744_2) / 32)) > 0 and var_744_0 < var_744_4 then
					arg_741_1.talkMaxDuration = var_744_4

					if var_744_4 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_4 + 0
					end
				end

				arg_741_1.text_.text = var_744_2
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_302011", "302011181", "story_v_out_302011.awb") ~= 0 then
					local var_744_5 = manager.audio:GetVoiceLength("story_v_out_302011", "302011181", "story_v_out_302011.awb") / 1000

					if var_744_5 + 0 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_5 + 0
					end

					if var_744_1.prefab_name ~= "" and arg_741_1.actors_[var_744_1.prefab_name] ~= nil then
						local var_744_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_741_1.actors_[var_744_1.prefab_name].transform, "story_v_out_302011", "302011181", "story_v_out_302011.awb")

						arg_741_1:RecordAudio("302011181", var_744_6)
						arg_741_1:RecordAudio("302011181", var_744_6)
					else
						arg_741_1:AudioAction("play", "voice", "story_v_out_302011", "302011181", "story_v_out_302011.awb")
					end

					arg_741_1:RecordHistoryTalkVoice("story_v_out_302011", "302011181", "story_v_out_302011.awb")
				end

				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_7 = math.max(var_744_0, arg_741_1.talkMaxDuration)

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_7 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - 0) / var_744_7

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= 0 + var_744_7 and arg_741_1.time_ < 0 + var_744_7 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/MS0201",
		"TextureConfig/Background/MS0201a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_302011.awb"
	}
}
