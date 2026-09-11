return {
	Play123071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123071001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play123071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.9

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(123071002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 36)

				if (36 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 36)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play123071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123071003
		arg_13_1.duration_ = 9.97

		local var_13_0 = {
			zh = 8.6,
			ja = 9.966
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(123071003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)

				if (38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 38)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071003", "story_v_out_123071.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071003", "story_v_out_123071.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_123071", "123071003", "story_v_out_123071.awb")

						arg_13_1:RecordAudio("123071003", var_16_6)
						arg_13_1:RecordAudio("123071003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_123071", "123071003", "story_v_out_123071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_123071", "123071003", "story_v_out_123071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123071004
		arg_17_1.duration_ = 10.6

		local var_17_0 = {
			zh = 9.1,
			ja = 10.6
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10003ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10003ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10003ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10003ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10003ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10003ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10003ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10003ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10003ui_story, Vector3.New(0, -1.05, -5.9), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.05, -5.9)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["10003ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10003ui_story == nil then
				arg_17_1.var_.characterEffect10003ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect10003ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10003ui_story then
				arg_17_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				if arg_17_1.var_.characterEffect10003ui_story == nil then
					arg_17_1.var_.characterEffect10003ui_story = arg_17_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_17_1.var_.characterEffect10003ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				if arg_17_1.var_.characterEffect10003ui_story == nil then
					arg_17_1.var_.characterEffect10003ui_story = arg_17_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_20_9 = arg_17_1.var_.characterEffect10003ui_story

				arg_17_1.var_.characterEffect10003ui_story.imageEffect:turnOff()

				var_20_9.interferenceEffect.enabled = true
				var_20_9.interferenceEffect.noise = 0.001
				var_20_9.interferenceEffect.simTimeScale = 1
				var_20_9.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_20_10 = 0
			local var_20_11 = 1.15

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(123071004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 46 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 46)

				if (46 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 46)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071004", "story_v_out_123071.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_123071", "123071004", "story_v_out_123071.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_123071", "123071004", "story_v_out_123071.awb")

						arg_17_1:RecordAudio("123071004", var_20_17)
						arg_17_1:RecordAudio("123071004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123071", "123071004", "story_v_out_123071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123071", "123071004", "story_v_out_123071.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play123071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123071005
		arg_21_1.duration_ = 10.47

		local var_21_0 = {
			zh = 10.466,
			ja = 8.566
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10003ui_story"]) and arg_21_1.var_.characterEffect10003ui_story == nil then
				arg_21_1.var_.characterEffect10003ui_story = arg_21_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10003ui_story"]) then
				if arg_21_1.var_.characterEffect10003ui_story and not isNil(arg_21_1.actors_["10003ui_story"]) then
					arg_21_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10003ui_story"]) and arg_21_1.var_.characterEffect10003ui_story then
				arg_21_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 1.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(123071005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 53)

				if (53 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 53)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071005", "story_v_out_123071.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071005", "story_v_out_123071.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_123071", "123071005", "story_v_out_123071.awb")

						arg_21_1:RecordAudio("123071005", var_24_8)
						arg_21_1:RecordAudio("123071005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123071", "123071005", "story_v_out_123071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123071", "123071005", "story_v_out_123071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123071006
		arg_25_1.duration_ = 5.97

		local var_25_0 = {
			zh = 5.466,
			ja = 5.966
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(123071006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 26)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071006", "story_v_out_123071.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071006", "story_v_out_123071.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_123071", "123071006", "story_v_out_123071.awb")

						arg_25_1:RecordAudio("123071006", var_28_6)
						arg_25_1:RecordAudio("123071006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_123071", "123071006", "story_v_out_123071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_123071", "123071006", "story_v_out_123071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play123071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123071007
		arg_29_1.duration_ = 14.1

		local var_29_0 = {
			zh = 13.366,
			ja = 14.1
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10003ui_story"]) and arg_29_1.var_.characterEffect10003ui_story == nil then
				arg_29_1.var_.characterEffect10003ui_story = arg_29_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10003ui_story"]) then
				if arg_29_1.var_.characterEffect10003ui_story and not isNil(arg_29_1.actors_["10003ui_story"]) then
					arg_29_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10003ui_story"]) and arg_29_1.var_.characterEffect10003ui_story then
				arg_29_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action5_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = 0
			local var_32_3 = 1.825

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(123071007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 73 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 73)

				if (73 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 73)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071007", "story_v_out_123071.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071007", "story_v_out_123071.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_123071", "123071007", "story_v_out_123071.awb")

						arg_29_1:RecordAudio("123071007", var_32_9)
						arg_29_1:RecordAudio("123071007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123071", "123071007", "story_v_out_123071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123071", "123071007", "story_v_out_123071.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123071008
		arg_33_1.duration_ = 9.67

		local var_33_0 = {
			zh = 9.633,
			ja = 9.666
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10003ui_story"]) and arg_33_1.var_.characterEffect10003ui_story == nil then
				arg_33_1.var_.characterEffect10003ui_story = arg_33_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10003ui_story"]) then
				if arg_33_1.var_.characterEffect10003ui_story and not isNil(arg_33_1.actors_["10003ui_story"]) then
					arg_33_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10003ui_story"]) and arg_33_1.var_.characterEffect10003ui_story then
				arg_33_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 1.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(123071008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 48 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 48)

				if (48 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 48)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071008", "story_v_out_123071.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071008", "story_v_out_123071.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_123071", "123071008", "story_v_out_123071.awb")

						arg_33_1:RecordAudio("123071008", var_36_8)
						arg_33_1:RecordAudio("123071008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123071", "123071008", "story_v_out_123071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123071", "123071008", "story_v_out_123071.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123071009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play123071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10003ui_story = arg_37_1.actors_["10003ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10003ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).z)
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles = arg_37_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10003ui_story"].transform.position).z)
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10003ui_story"].transform.localEulerAngles = arg_37_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10003ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10003ui_story == nil then
				arg_37_1.var_.characterEffect10003ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10003ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10003ui_story then
				arg_37_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_40_3 = "1019ui_story"

			if arg_37_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_40_4 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_37_1.stage_.transform)

				var_40_4.name = var_40_3
				var_40_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_[var_40_3] = var_40_4

				local var_40_5 = var_40_4:GetComponentInChildren(typeof(CharacterEffect))

				var_40_5.enabled = true

				local var_40_6 = GameObjectTools.GetOrAddComponent(var_40_4, typeof(DynamicBoneHelper))

				if var_40_6 then
					var_40_6:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_5.transform, false)

				arg_37_1.var_[var_40_3 .. "Animator"] = var_40_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_[var_40_3 .. "Animator"].applyRootMotion = true
				arg_37_1.var_[var_40_3 .. "LipSync"] = var_40_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_7 = arg_37_1.actors_["1019ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1019ui_story = var_40_7.localPosition
			end

			local var_40_8 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_8 then
				var_40_7.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_37_1.time_ - 0) / var_40_8)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_8 and arg_37_1.time_ < 0 + var_40_8 + arg_40_0 then
				var_40_7.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_40_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_7.position).x, (manager.ui.mainCamera.transform.position - var_40_7.position).y, (manager.ui.mainCamera.transform.position - var_40_7.position).z)
				var_40_7.localEulerAngles.z = 0
				var_40_7.localEulerAngles.x = 0
				var_40_7.localEulerAngles = var_40_7.localEulerAngles
			end

			local var_40_9 = arg_37_1.actors_["1019ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_10 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 and not isNil(var_40_9) then
				if arg_37_1.var_.characterEffect1019ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_40_12 = 0
			local var_40_13 = 0.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(123071009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 4 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 4)

				if (4 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 4)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071009", "story_v_out_123071.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_123071", "123071009", "story_v_out_123071.awb") / 1000

					if var_40_18 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_12
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_123071", "123071009", "story_v_out_123071.awb")

						arg_37_1:RecordAudio("123071009", var_40_19)
						arg_37_1:RecordAudio("123071009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123071", "123071009", "story_v_out_123071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123071", "123071009", "story_v_out_123071.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_20 and arg_37_1.time_ < var_40_12 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
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

		arg_37_1:InitPlayNodeList()
	end,
	Play123071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123071010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play123071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = arg_41_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) then
				if arg_41_1.var_.characterEffect1019ui_story and not isNil(arg_41_1.actors_["1019ui_story"]) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 1.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(123071010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 55 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 55)

				if (55 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 55)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play123071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123071011
		arg_45_1.duration_ = 17.17

		local var_45_0 = {
			zh = 15,
			ja = 17.166
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
				arg_45_0:Play123071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_48_0 = arg_45_1.actors_["1019ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story == nil then
				arg_45_1.var_.characterEffect1019ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_1 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(var_48_0) then
				if arg_45_1.var_.characterEffect1019ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1019ui_story then
				arg_45_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_48_3 = 0
			local var_48_4 = 1.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:GetWordFromCfg(123071011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 71 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_6) / 71)

				if (71 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_6) / 71)) > 0 and var_48_4 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071011", "story_v_out_123071.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_123071", "123071011", "story_v_out_123071.awb") / 1000

					if var_48_9 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_3
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_123071", "123071011", "story_v_out_123071.awb")

						arg_45_1:RecordAudio("123071011", var_48_10)
						arg_45_1:RecordAudio("123071011", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123071", "123071011", "story_v_out_123071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123071", "123071011", "story_v_out_123071.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_11 and arg_45_1.time_ < var_48_3 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123071012
		arg_49_1.duration_ = 2.8

		local var_49_0 = {
			zh = 2.6,
			ja = 2.8
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10003ui_story = arg_49_1.actors_["10003ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10003ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10003ui_story, Vector3.New(0, -1.05, -5.9), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).z)
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles = arg_49_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10003ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.9)
				arg_49_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10003ui_story"].transform.position).z)
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10003ui_story"].transform.localEulerAngles = arg_49_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10003ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10003ui_story == nil then
				arg_49_1.var_.characterEffect10003ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10003ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10003ui_story then
				arg_49_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = arg_49_1.actors_["1019ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1019ui_story = var_52_4.localPosition
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_5)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(0, 100, 0)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			local var_52_6 = arg_49_1.actors_["1019ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1019ui_story == nil then
				arg_49_1.var_.characterEffect1019ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_7 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 and not isNil(var_52_6) then
				if arg_49_1.var_.characterEffect1019ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_7)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1019ui_story then
				arg_49_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_52_8 = 0
			local var_52_9 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(123071012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 10 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 10)

				if (10 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 10)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071012", "story_v_out_123071.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071012", "story_v_out_123071.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_123071", "123071012", "story_v_out_123071.awb")

						arg_49_1:RecordAudio("123071012", var_52_15)
						arg_49_1:RecordAudio("123071012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_123071", "123071012", "story_v_out_123071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_123071", "123071012", "story_v_out_123071.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
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

		arg_49_1:InitPlayNodeList()
	end,
	Play123071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123071013
		arg_53_1.duration_ = 9.37

		local var_53_0 = {
			zh = 7.133,
			ja = 9.366
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play123071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10003ui_story = arg_53_1.actors_["10003ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10003ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10003ui_story, Vector3.New(-0.7, -1.05, -5.9), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).z)
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles = arg_53_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10003ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -5.9)
				arg_53_1.actors_["10003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10003ui_story"].transform.position).z)
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10003ui_story"].transform.localEulerAngles = arg_53_1.actors_["10003ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1019ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1019ui_story == nil then
				arg_53_1.var_.characterEffect1019ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1019ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1019ui_story then
				arg_53_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = arg_53_1.actors_["10003ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10003ui_story == nil then
				arg_53_1.var_.characterEffect10003ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect10003ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10003ui_story then
				arg_53_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_56_6 = arg_53_1.actors_["1019ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1019ui_story = var_56_6.localPosition
			end

			local var_56_7 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				var_56_6.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_53_1.time_ - 0) / var_56_7)
				var_56_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_6.position).x, (manager.ui.mainCamera.transform.position - var_56_6.position).y, (manager.ui.mainCamera.transform.position - var_56_6.position).z)
				var_56_6.localEulerAngles.z = 0
				var_56_6.localEulerAngles.x = 0
				var_56_6.localEulerAngles = var_56_6.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				var_56_6.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_56_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_6.position).x, (manager.ui.mainCamera.transform.position - var_56_6.position).y, (manager.ui.mainCamera.transform.position - var_56_6.position).z)
				var_56_6.localEulerAngles.z = 0
				var_56_6.localEulerAngles.x = 0
				var_56_6.localEulerAngles = var_56_6.localEulerAngles
			end

			local var_56_8 = 0
			local var_56_9 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(123071013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 35 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 35)

				if (35 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 35)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071013", "story_v_out_123071.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071013", "story_v_out_123071.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_123071", "123071013", "story_v_out_123071.awb")

						arg_53_1:RecordAudio("123071013", var_56_15)
						arg_53_1:RecordAudio("123071013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123071", "123071013", "story_v_out_123071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123071", "123071013", "story_v_out_123071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
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

		arg_53_1:InitPlayNodeList()
	end,
	Play123071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play123071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1019ui_story = arg_57_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).z)
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles = arg_57_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1019ui_story"].transform.position).z)
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1019ui_story"].transform.localEulerAngles = arg_57_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1019ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1019ui_story == nil then
				arg_57_1.var_.characterEffect1019ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1019ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1019ui_story then
				arg_57_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_60_3 = arg_57_1.actors_["10003ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10003ui_story = var_60_3.localPosition
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_3.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_4)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_3.localPosition = Vector3.New(0, 100, 0)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			local var_60_5 = 0
			local var_60_6 = 0.725

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(123071014).content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 29 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 29)

				if (29 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_7) / 29)) > 0 and var_60_6 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_10 and arg_57_1.time_ < var_60_5 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play123071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123071015
		arg_61_1.duration_ = 6.07

		local var_61_0 = {
			zh = 6.066,
			ja = 6.033
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.775

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(123071015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 31 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 31)

				if (31 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 31)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071015", "story_v_out_123071.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071015", "story_v_out_123071.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_123071", "123071015", "story_v_out_123071.awb")

						arg_61_1:RecordAudio("123071015", var_64_6)
						arg_61_1:RecordAudio("123071015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_123071", "123071015", "story_v_out_123071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_123071", "123071015", "story_v_out_123071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123071016
		arg_65_1.duration_ = 8.43

		local var_65_0 = {
			zh = 8.433,
			ja = 7.2
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play123071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1019ui_story = arg_65_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).z)
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles = arg_65_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_65_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1019ui_story"].transform.position).z)
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1019ui_story"].transform.localEulerAngles = arg_65_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1019ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1019ui_story == nil then
				arg_65_1.var_.characterEffect1019ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1019ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1019ui_story then
				arg_65_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 1.075

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(123071016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 43 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 43)

				if (43 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 43)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071016", "story_v_out_123071.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_123071", "123071016", "story_v_out_123071.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_123071", "123071016", "story_v_out_123071.awb")

						arg_65_1:RecordAudio("123071016", var_68_11)
						arg_65_1:RecordAudio("123071016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123071", "123071016", "story_v_out_123071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123071", "123071016", "story_v_out_123071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play123071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123071017
		arg_69_1.duration_ = 2.67

		local var_69_0 = {
			zh = 1.5,
			ja = 2.666
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play123071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story == nil then
				arg_69_1.var_.characterEffect1019ui_story = arg_69_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) then
				if arg_69_1.var_.characterEffect1019ui_story and not isNil(arg_69_1.actors_["1019ui_story"]) then
					arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1019ui_story"]) and arg_69_1.var_.characterEffect1019ui_story then
				arg_69_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(123071017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 6 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 6)

				if (6 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 6)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071017", "story_v_out_123071.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071017", "story_v_out_123071.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_123071", "123071017", "story_v_out_123071.awb")

						arg_69_1:RecordAudio("123071017", var_72_8)
						arg_69_1:RecordAudio("123071017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123071", "123071017", "story_v_out_123071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123071", "123071017", "story_v_out_123071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play123071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123071018
		arg_73_1.duration_ = 4.47

		local var_73_0 = {
			zh = 3.466,
			ja = 4.466
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play123071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1019ui_story"]) and arg_73_1.var_.characterEffect1019ui_story == nil then
				arg_73_1.var_.characterEffect1019ui_story = arg_73_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1019ui_story"]) then
				if arg_73_1.var_.characterEffect1019ui_story and not isNil(arg_73_1.actors_["1019ui_story"]) then
					arg_73_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1019ui_story"]) and arg_73_1.var_.characterEffect1019ui_story then
				arg_73_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.325

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(123071018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 13 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 13)

				if (13 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 13)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071018", "story_v_out_123071.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071018", "story_v_out_123071.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_123071", "123071018", "story_v_out_123071.awb")

						arg_73_1:RecordAudio("123071018", var_76_9)
						arg_73_1:RecordAudio("123071018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123071", "123071018", "story_v_out_123071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123071", "123071018", "story_v_out_123071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123071019
		arg_77_1.duration_ = 7.47

		local var_77_0 = {
			zh = 7.466,
			ja = 7.366
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play123071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story == nil then
				arg_77_1.var_.characterEffect1019ui_story = arg_77_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) then
				if arg_77_1.var_.characterEffect1019ui_story and not isNil(arg_77_1.actors_["1019ui_story"]) then
					arg_77_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1019ui_story"]) and arg_77_1.var_.characterEffect1019ui_story then
				arg_77_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.85

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(123071019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 34 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 34)

				if (34 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 34)) > 0 and var_80_2 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071019", "story_v_out_123071.awb") ~= 0 then
					local var_80_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071019", "story_v_out_123071.awb") / 1000

					if var_80_7 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_1
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_123071", "123071019", "story_v_out_123071.awb")

						arg_77_1:RecordAudio("123071019", var_80_8)
						arg_77_1:RecordAudio("123071019", var_80_8)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123071", "123071019", "story_v_out_123071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123071", "123071019", "story_v_out_123071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_9 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_9 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_9

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_9 and arg_77_1.time_ < var_80_1 + var_80_9 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play123071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123071020
		arg_81_1.duration_ = 9.87

		local var_81_0 = {
			zh = 9.866,
			ja = 8.4
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story == nil then
				arg_81_1.var_.characterEffect1019ui_story = arg_81_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) then
				if arg_81_1.var_.characterEffect1019ui_story and not isNil(arg_81_1.actors_["1019ui_story"]) then
					arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1019ui_story"]) and arg_81_1.var_.characterEffect1019ui_story then
				arg_81_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_2 = 0
			local var_84_3 = 1.25

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(123071020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 50 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 50)

				if (50 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 50)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071020", "story_v_out_123071.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071020", "story_v_out_123071.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_123071", "123071020", "story_v_out_123071.awb")

						arg_81_1:RecordAudio("123071020", var_84_9)
						arg_81_1:RecordAudio("123071020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_123071", "123071020", "story_v_out_123071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_123071", "123071020", "story_v_out_123071.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123071021
		arg_85_1.duration_ = 13.67

		local var_85_0 = {
			zh = 13.666,
			ja = 12
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play123071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.75

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(123071021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 70 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 70)

				if (70 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 70)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071021", "story_v_out_123071.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071021", "story_v_out_123071.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_123071", "123071021", "story_v_out_123071.awb")

						arg_85_1:RecordAudio("123071021", var_88_6)
						arg_85_1:RecordAudio("123071021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123071", "123071021", "story_v_out_123071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123071", "123071021", "story_v_out_123071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play123071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123071022
		arg_89_1.duration_ = 2.33

		local var_89_0 = {
			zh = 2.033,
			ja = 2.333
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
				arg_89_0:Play123071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) and arg_89_1.var_.characterEffect1019ui_story == nil then
				arg_89_1.var_.characterEffect1019ui_story = arg_89_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) then
				if arg_89_1.var_.characterEffect1019ui_story and not isNil(arg_89_1.actors_["1019ui_story"]) then
					arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1019ui_story"]) and arg_89_1.var_.characterEffect1019ui_story then
				arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(123071022)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 9 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 9)

				if (9 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_4) / 9)) > 0 and var_92_2 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071022", "story_v_out_123071.awb") ~= 0 then
					local var_92_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071022", "story_v_out_123071.awb") / 1000

					if var_92_7 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_1
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_123071", "123071022", "story_v_out_123071.awb")

						arg_89_1:RecordAudio("123071022", var_92_8)
						arg_89_1:RecordAudio("123071022", var_92_8)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_123071", "123071022", "story_v_out_123071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_123071", "123071022", "story_v_out_123071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_9 and arg_89_1.time_ < var_92_1 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123071023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play123071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) and arg_93_1.var_.characterEffect1019ui_story == nil then
				arg_93_1.var_.characterEffect1019ui_story = arg_93_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) then
				if arg_93_1.var_.characterEffect1019ui_story and not isNil(arg_93_1.actors_["1019ui_story"]) then
					arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1019ui_story"]) and arg_93_1.var_.characterEffect1019ui_story then
				arg_93_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.175

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(123071023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 7 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 7)

				if (7 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 7)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071023", "story_v_out_123071.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071023", "story_v_out_123071.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_123071", "123071023", "story_v_out_123071.awb")

						arg_93_1:RecordAudio("123071023", var_96_9)
						arg_93_1:RecordAudio("123071023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123071", "123071023", "story_v_out_123071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123071", "123071023", "story_v_out_123071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123071024
		arg_97_1.duration_ = 13.37

		local var_97_0 = {
			zh = 13.366,
			ja = 11.166
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play123071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1019ui_story"]) and arg_97_1.var_.characterEffect1019ui_story == nil then
				arg_97_1.var_.characterEffect1019ui_story = arg_97_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1019ui_story"]) then
				if arg_97_1.var_.characterEffect1019ui_story and not isNil(arg_97_1.actors_["1019ui_story"]) then
					arg_97_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1019ui_story"]) and arg_97_1.var_.characterEffect1019ui_story then
				arg_97_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 1.575

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(123071024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 63 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 63)

				if (63 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 63)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071024", "story_v_out_123071.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071024", "story_v_out_123071.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_123071", "123071024", "story_v_out_123071.awb")

						arg_97_1:RecordAudio("123071024", var_100_8)
						arg_97_1:RecordAudio("123071024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123071", "123071024", "story_v_out_123071.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123071", "123071024", "story_v_out_123071.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play123071025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123071025
		arg_101_1.duration_ = 13.5

		local var_101_0 = {
			zh = 10.9,
			ja = 13.5
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
				arg_101_0:Play123071026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.3

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(123071025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)

				if (52 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 52)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071025", "story_v_out_123071.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071025", "story_v_out_123071.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_123071", "123071025", "story_v_out_123071.awb")

						arg_101_1:RecordAudio("123071025", var_104_6)
						arg_101_1:RecordAudio("123071025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123071", "123071025", "story_v_out_123071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123071", "123071025", "story_v_out_123071.awb")
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
	Play123071026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123071026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123071027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(123071026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 18 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 18)

				if (18 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 18)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123071027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123071027
		arg_109_1.duration_ = 3.53

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play123071028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1019ui_story = arg_109_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).z)
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles = arg_109_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_109_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1019ui_story"].transform.position).z)
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1019ui_story"].transform.localEulerAngles = arg_109_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1019ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1019ui_story == nil then
				arg_109_1.var_.characterEffect1019ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1019ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1019ui_story then
				arg_109_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.375

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(123071027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 15 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 15)

				if (15 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 15)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071027", "story_v_out_123071.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_123071", "123071027", "story_v_out_123071.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_123071", "123071027", "story_v_out_123071.awb")

						arg_109_1:RecordAudio("123071027", var_112_11)
						arg_109_1:RecordAudio("123071027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123071", "123071027", "story_v_out_123071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123071", "123071027", "story_v_out_123071.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play123071028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123071028
		arg_113_1.duration_ = 8.53

		local var_113_0 = {
			zh = 8.533,
			ja = 6.733
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
				arg_113_0:Play123071029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story == nil then
				arg_113_1.var_.characterEffect1019ui_story = arg_113_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) then
				if arg_113_1.var_.characterEffect1019ui_story and not isNil(arg_113_1.actors_["1019ui_story"]) then
					arg_113_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story then
				arg_113_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 1.025

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(123071028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 41 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 41)

				if (41 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 41)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071028", "story_v_out_123071.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071028", "story_v_out_123071.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_123071", "123071028", "story_v_out_123071.awb")

						arg_113_1:RecordAudio("123071028", var_116_8)
						arg_113_1:RecordAudio("123071028", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123071", "123071028", "story_v_out_123071.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123071", "123071028", "story_v_out_123071.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123071029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123071029
		arg_117_1.duration_ = 3.37

		local var_117_0 = {
			zh = 3.366,
			ja = 1.666
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
				arg_117_0:Play123071030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = arg_117_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) then
				if arg_117_1.var_.characterEffect1019ui_story and not isNil(arg_117_1.actors_["1019ui_story"]) then
					arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story then
				arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_120_2 = 0
			local var_120_3 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(123071029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 14 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 14)

				if (14 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 14)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071029", "story_v_out_123071.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071029", "story_v_out_123071.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_123071", "123071029", "story_v_out_123071.awb")

						arg_117_1:RecordAudio("123071029", var_120_9)
						arg_117_1:RecordAudio("123071029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123071", "123071029", "story_v_out_123071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123071", "123071029", "story_v_out_123071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play123071030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123071030
		arg_121_1.duration_ = 10.73

		local var_121_0 = {
			zh = 6.633,
			ja = 10.733
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
				arg_121_0:Play123071031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = arg_121_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) then
				if arg_121_1.var_.characterEffect1019ui_story and not isNil(arg_121_1.actors_["1019ui_story"]) then
					arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story then
				arg_121_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(123071030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 29 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 29)

				if (29 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 29)) > 0 and var_124_2 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071030", "story_v_out_123071.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071030", "story_v_out_123071.awb") / 1000

					if var_124_7 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_1
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_123071", "123071030", "story_v_out_123071.awb")

						arg_121_1:RecordAudio("123071030", var_124_8)
						arg_121_1:RecordAudio("123071030", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123071", "123071030", "story_v_out_123071.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123071", "123071030", "story_v_out_123071.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_9 and arg_121_1.time_ < var_124_1 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play123071031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123071031
		arg_125_1.duration_ = 3.73

		local var_125_0 = {
			zh = 3.7,
			ja = 3.733
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
				arg_125_0:Play123071032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1019ui_story"]) and arg_125_1.var_.characterEffect1019ui_story == nil then
				arg_125_1.var_.characterEffect1019ui_story = arg_125_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1019ui_story"]) then
				if arg_125_1.var_.characterEffect1019ui_story and not isNil(arg_125_1.actors_["1019ui_story"]) then
					arg_125_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1019ui_story"]) and arg_125_1.var_.characterEffect1019ui_story then
				arg_125_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_2 = 0
			local var_128_3 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(123071031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 13 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 13)

				if (13 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 13)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071031", "story_v_out_123071.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071031", "story_v_out_123071.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_123071", "123071031", "story_v_out_123071.awb")

						arg_125_1:RecordAudio("123071031", var_128_9)
						arg_125_1:RecordAudio("123071031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_123071", "123071031", "story_v_out_123071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_123071", "123071031", "story_v_out_123071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play123071032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 123071032
		arg_129_1.duration_ = 6.83

		local var_129_0 = {
			zh = 4.1,
			ja = 6.833
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play123071033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1019ui_story"]) and arg_129_1.var_.characterEffect1019ui_story == nil then
				arg_129_1.var_.characterEffect1019ui_story = arg_129_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1019ui_story"]) then
				if arg_129_1.var_.characterEffect1019ui_story and not isNil(arg_129_1.actors_["1019ui_story"]) then
					arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1019ui_story"]) and arg_129_1.var_.characterEffect1019ui_story then
				arg_129_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(123071032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 16 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 16)

				if (16 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_4) / 16)) > 0 and var_132_2 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071032", "story_v_out_123071.awb") ~= 0 then
					local var_132_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071032", "story_v_out_123071.awb") / 1000

					if var_132_7 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_1
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_123071", "123071032", "story_v_out_123071.awb")

						arg_129_1:RecordAudio("123071032", var_132_8)
						arg_129_1:RecordAudio("123071032", var_132_8)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_123071", "123071032", "story_v_out_123071.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_123071", "123071032", "story_v_out_123071.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_9 and arg_129_1.time_ < var_132_1 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play123071033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 123071033
		arg_133_1.duration_ = 12.47

		local var_133_0 = {
			zh = 12.466,
			ja = 8.833
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play123071034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.325

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(123071033)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 53 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 53)

				if (53 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 53)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071033", "story_v_out_123071.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071033", "story_v_out_123071.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_123071", "123071033", "story_v_out_123071.awb")

						arg_133_1:RecordAudio("123071033", var_136_6)
						arg_133_1:RecordAudio("123071033", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_123071", "123071033", "story_v_out_123071.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_123071", "123071033", "story_v_out_123071.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play123071034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123071034
		arg_137_1.duration_ = 10.47

		local var_137_0 = {
			zh = 10.466,
			ja = 8.833
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play123071035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.15

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:GetWordFromCfg(123071034)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 46 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 46)

				if (46 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 46)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071034", "story_v_out_123071.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071034", "story_v_out_123071.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_123071", "123071034", "story_v_out_123071.awb")

						arg_137_1:RecordAudio("123071034", var_140_6)
						arg_137_1:RecordAudio("123071034", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_123071", "123071034", "story_v_out_123071.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_123071", "123071034", "story_v_out_123071.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play123071035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123071035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play123071036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.275

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(123071035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 11 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 11)

				if (11 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 11)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play123071036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123071036
		arg_145_1.duration_ = 8.9

		local var_145_0 = {
			zh = 6,
			ja = 8.9
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play123071037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) and arg_145_1.var_.characterEffect1019ui_story == nil then
				arg_145_1.var_.characterEffect1019ui_story = arg_145_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) then
				if arg_145_1.var_.characterEffect1019ui_story and not isNil(arg_145_1.actors_["1019ui_story"]) then
					arg_145_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1019ui_story"]) and arg_145_1.var_.characterEffect1019ui_story then
				arg_145_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_2 = 0
			local var_148_3 = 0.675

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(123071036)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 27 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 27)

				if (27 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 27)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071036", "story_v_out_123071.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071036", "story_v_out_123071.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_123071", "123071036", "story_v_out_123071.awb")

						arg_145_1:RecordAudio("123071036", var_148_9)
						arg_145_1:RecordAudio("123071036", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_123071", "123071036", "story_v_out_123071.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_123071", "123071036", "story_v_out_123071.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play123071037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123071037
		arg_149_1.duration_ = 9.97

		local var_149_0 = {
			zh = 9.3,
			ja = 9.966
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play123071038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1019ui_story"]) and arg_149_1.var_.characterEffect1019ui_story == nil then
				arg_149_1.var_.characterEffect1019ui_story = arg_149_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1019ui_story"]) then
				if arg_149_1.var_.characterEffect1019ui_story and not isNil(arg_149_1.actors_["1019ui_story"]) then
					arg_149_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1019ui_story"]) and arg_149_1.var_.characterEffect1019ui_story then
				arg_149_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 1.1

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(123071037)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 46 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 46)

				if (46 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 46)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071037", "story_v_out_123071.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_out_123071", "123071037", "story_v_out_123071.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_out_123071", "123071037", "story_v_out_123071.awb")

						arg_149_1:RecordAudio("123071037", var_152_8)
						arg_149_1:RecordAudio("123071037", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_123071", "123071037", "story_v_out_123071.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_123071", "123071037", "story_v_out_123071.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play123071038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123071038
		arg_153_1.duration_ = 11.9

		local var_153_0 = {
			zh = 11.766,
			ja = 11.9
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play123071039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(123071038)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 59 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 59)

				if (59 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 59)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071038", "story_v_out_123071.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071038", "story_v_out_123071.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_123071", "123071038", "story_v_out_123071.awb")

						arg_153_1:RecordAudio("123071038", var_156_6)
						arg_153_1:RecordAudio("123071038", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123071", "123071038", "story_v_out_123071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123071", "123071038", "story_v_out_123071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play123071039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 123071039
		arg_157_1.duration_ = 6.23

		local var_157_0 = {
			zh = 4.1,
			ja = 6.233
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
				arg_157_0:Play123071040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_160_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_157_1.bgmTxt_.text ~= var_160_2 and arg_157_1.bgmTxt_.text ~= "" then
						if arg_157_1.bgmTxt2_.text ~= "" then
							arg_157_1.bgmTxt_.text = arg_157_1.bgmTxt2_.text
						end

						arg_157_1.bgmTxt2_.text = var_160_2

						arg_157_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_157_1.bgmTxt_.text = var_160_2
						arg_157_1.bgmTxt2_.text = var_160_2
					end

					if arg_157_1.bgmTimer then
						arg_157_1.bgmTimer:Stop()

						arg_157_1.bgmTimer = nil
					end

					if arg_157_1.settingData.show_music_name == 1 then
						arg_157_1.musicController:SetSelectedState("show")
						arg_157_1.musicAnimator_:Play("open", 0, 0)

						if arg_157_1.settingData.music_time ~= 0 then
							arg_157_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_157_1.settingData.music_time), function()
								if arg_157_1 == nil or isNil(arg_157_1.bgmTxt_) then
									return
								end

								arg_157_1.musicController:SetSelectedState("hide")
								arg_157_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_160_3 = 0
			local var_160_4 = 0.525

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_5 = arg_157_1:GetWordFromCfg(123071039)
				local var_160_6 = arg_157_1:FormatText(var_160_5.content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 21 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_6) / 21)

				if (21 <= 0 and var_160_4 or var_160_4 * (utf8.len(var_160_6) / 21)) > 0 and var_160_4 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_3
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071039", "story_v_out_123071.awb") ~= 0 then
					local var_160_9 = manager.audio:GetVoiceLength("story_v_out_123071", "123071039", "story_v_out_123071.awb") / 1000

					if var_160_9 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_3
					end

					if var_160_5.prefab_name ~= "" and arg_157_1.actors_[var_160_5.prefab_name] ~= nil then
						local var_160_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_5.prefab_name].transform, "story_v_out_123071", "123071039", "story_v_out_123071.awb")

						arg_157_1:RecordAudio("123071039", var_160_10)
						arg_157_1:RecordAudio("123071039", var_160_10)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_123071", "123071039", "story_v_out_123071.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_123071", "123071039", "story_v_out_123071.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_4, arg_157_1.talkMaxDuration)

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_3) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_3 + var_160_11 and arg_157_1.time_ < var_160_3 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play123071040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 123071040
		arg_162_1.duration_ = 9

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play123071041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if arg_162_1.bgs_.K04f == nil then
				local var_165_0 = Object.Instantiate(arg_162_1.paintGo_)

				var_165_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K04f")
				var_165_0.name = "K04f"
				var_165_0.transform.parent = arg_162_1.stage_.transform
				var_165_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.bgs_.K04f = var_165_0
			end

			if 1.999999999999 < arg_162_1.time_ and arg_162_1.time_ <= 1.999999999999 + arg_165_0 then
				local var_165_1 = arg_162_1.bgs_.K04f

				arg_162_1.bgs_.K04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_165_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_165_2 = var_165_1:GetComponent("SpriteRenderer")

				if var_165_2 and var_165_2.sprite then
					local var_165_3 = 2 * (var_165_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_165_1.transform.localScale = Vector3.New(var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, var_165_3 / var_165_2.sprite.bounds.size.y < var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x and var_165_3 * manager.ui.mainCameraCom_.aspect / var_165_2.sprite.bounds.size.x or var_165_3 / var_165_2.sprite.bounds.size.y, 0)
				end

				for iter_165_0, iter_165_1 in pairs(arg_162_1.bgs_) do
					if iter_165_0 ~= "K04f" then
						iter_165_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_165_4 = 0

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_5 = 2

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_5 then
				local var_165_6 = Color.New(0, 0, 0)

				var_165_6.a = Mathf.Lerp(0, 1, (arg_162_1.time_ - var_165_4) / var_165_5)
				arg_162_1.mask_.color = var_165_6
			end

			if arg_162_1.time_ >= var_165_4 + var_165_5 and arg_162_1.time_ < var_165_4 + var_165_5 + arg_165_0 then
				local var_165_7 = Color.New(0, 0, 0)

				var_165_7.a = 1
				arg_162_1.mask_.color = var_165_7
			end

			local var_165_8 = 2

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.mask_.enabled = true
				arg_162_1.mask_.raycastTarget = true

				arg_162_1:SetGaussion(false)
			end

			local var_165_9 = 2

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_9 then
				local var_165_10 = Color.New(0, 0, 0)

				var_165_10.a = Mathf.Lerp(1, 0, (arg_162_1.time_ - var_165_8) / var_165_9)
				arg_162_1.mask_.color = var_165_10
			end

			if arg_162_1.time_ >= var_165_8 + var_165_9 and arg_162_1.time_ < var_165_8 + var_165_9 + arg_165_0 then
				local var_165_11 = Color.New(0, 0, 0)

				arg_162_1.mask_.enabled = false
				var_165_11.a = 0
				arg_162_1.mask_.color = var_165_11
			end

			local var_165_12 = arg_162_1.actors_["1019ui_story"].transform

			if 1.966 < arg_162_1.time_ and arg_162_1.time_ <= 1.966 + arg_165_0 then
				arg_162_1.var_.moveOldPos1019ui_story = var_165_12.localPosition
			end

			local var_165_13 = 0.001

			if 1.966 <= arg_162_1.time_ and arg_162_1.time_ < 1.966 + var_165_13 then
				var_165_12.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 1.966) / var_165_13)
				var_165_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_12.position).x, (manager.ui.mainCamera.transform.position - var_165_12.position).y, (manager.ui.mainCamera.transform.position - var_165_12.position).z)
				var_165_12.localEulerAngles.z = 0
				var_165_12.localEulerAngles.x = 0
				var_165_12.localEulerAngles = var_165_12.localEulerAngles
			end

			if arg_162_1.time_ >= 1.966 + var_165_13 and arg_162_1.time_ < 1.966 + var_165_13 + arg_165_0 then
				var_165_12.localPosition = Vector3.New(0, 100, 0)
				var_165_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_12.position).x, (manager.ui.mainCamera.transform.position - var_165_12.position).y, (manager.ui.mainCamera.transform.position - var_165_12.position).z)
				var_165_12.localEulerAngles.z = 0
				var_165_12.localEulerAngles.x = 0
				var_165_12.localEulerAngles = var_165_12.localEulerAngles
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_165_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_162_1.bgmTxt_.text ~= var_165_16 and arg_162_1.bgmTxt_.text ~= "" then
						if arg_162_1.bgmTxt2_.text ~= "" then
							arg_162_1.bgmTxt_.text = arg_162_1.bgmTxt2_.text
						end

						arg_162_1.bgmTxt2_.text = var_165_16

						arg_162_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_162_1.bgmTxt_.text = var_165_16
						arg_162_1.bgmTxt2_.text = var_165_16
					end

					if arg_162_1.bgmTimer then
						arg_162_1.bgmTimer:Stop()

						arg_162_1.bgmTimer = nil
					end

					if arg_162_1.settingData.show_music_name == 1 then
						arg_162_1.musicController:SetSelectedState("show")
						arg_162_1.musicAnimator_:Play("open", 0, 0)

						if arg_162_1.settingData.music_time ~= 0 then
							arg_162_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_162_1.settingData.music_time), function()
								if arg_162_1 == nil or isNil(arg_162_1.bgmTxt_) then
									return
								end

								arg_162_1.musicController:SetSelectedState("hide")
								arg_162_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_162_1.time_ and arg_162_1.time_ <= 2 + arg_165_0 then
				arg_162_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_165_19 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if "" ~= "" then
					if arg_162_1.bgmTxt_.text ~= var_165_19 and arg_162_1.bgmTxt_.text ~= "" then
						if arg_162_1.bgmTxt2_.text ~= "" then
							arg_162_1.bgmTxt_.text = arg_162_1.bgmTxt2_.text
						end

						arg_162_1.bgmTxt2_.text = var_165_19

						arg_162_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_162_1.bgmTxt_.text = var_165_19
						arg_162_1.bgmTxt2_.text = var_165_19
					end

					if arg_162_1.bgmTimer then
						arg_162_1.bgmTimer:Stop()

						arg_162_1.bgmTimer = nil
					end

					if arg_162_1.settingData.show_music_name == 1 then
						arg_162_1.musicController:SetSelectedState("show")
						arg_162_1.musicAnimator_:Play("open", 0, 0)

						if arg_162_1.settingData.music_time ~= 0 then
							arg_162_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_162_1.settingData.music_time), function()
								if arg_162_1 == nil or isNil(arg_162_1.bgmTxt_) then
									return
								end

								arg_162_1.musicController:SetSelectedState("hide")
								arg_162_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_162_1.frameCnt_ <= 1 then
				arg_162_1.dialog_:SetActive(false)
			end

			local var_165_20 = 4
			local var_165_21 = 1.6

			if 4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_20 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0

				arg_162_1.dialog_:SetActive(true)

				arg_162_1.dialogCg_.alpha = 0

				local var_165_22 = LeanTween.value(arg_162_1.dialog_, 0, 1, 0.3)

				var_165_22:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_162_1.dialogCg_.alpha = arg_168_0
				end))
				var_165_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_162_1.dialog_)
					var_165_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_162_1.duration_ = arg_162_1.duration_ + 0.3

				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_23 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(123071040).content)

				arg_162_1.text_.text = var_165_23

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_25 = 64 <= 0 and var_165_21 or var_165_21 * (utf8.len(var_165_23) / 64)

				if (64 <= 0 and var_165_21 or var_165_21 * (utf8.len(var_165_23) / 64)) > 0 and var_165_21 < var_165_25 then
					arg_162_1.talkMaxDuration = var_165_25
					var_165_20 = var_165_20 + 0.3

					if var_165_25 + var_165_20 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_25 + var_165_20
					end
				end

				arg_162_1.text_.text = var_165_23
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_26 = var_165_20 + 0.3
			local var_165_27 = math.max(var_165_21, arg_162_1.talkMaxDuration)

			if var_165_20 + 0.3 <= arg_162_1.time_ and arg_162_1.time_ < var_165_26 + var_165_27 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_26) / var_165_27

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_26 + var_165_27 and arg_162_1.time_ < var_165_26 + var_165_27 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play123071041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 123071041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play123071042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.9

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(123071041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 36 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 36)

				if (36 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 36)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play123071042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 123071042
		arg_174_1.duration_ = 3.87

		local var_174_0 = {
			zh = 3.866,
			ja = 3.433
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
				arg_174_0:Play123071043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if arg_174_1.actors_["10048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10048ui_story"))) then
				local var_177_0 = Object.Instantiate(Asset.Load("Char/" .. "10048ui_story"), arg_174_1.stage_.transform)

				var_177_0.name = "10048ui_story"
				var_177_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["10048ui_story"] = var_177_0

				local var_177_1 = var_177_0:GetComponentInChildren(typeof(CharacterEffect))

				var_177_1.enabled = true

				local var_177_2 = GameObjectTools.GetOrAddComponent(var_177_0, typeof(DynamicBoneHelper))

				if var_177_2 then
					var_177_2:EnableDynamicBone(false)
				end

				arg_174_1:ShowWeapon(var_177_1.transform, false)

				arg_174_1.var_["10048ui_story" .. "Animator"] = var_177_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_174_1.var_["10048ui_story" .. "Animator"].applyRootMotion = true
				arg_174_1.var_["10048ui_story" .. "LipSync"] = var_177_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_177_3 = arg_174_1.actors_["10048ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10048ui_story = var_177_3.localPosition
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_3.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10048ui_story, Vector3.New(0, -1.155, -6.13), (arg_174_1.time_ - 0) / var_177_4)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_3.localPosition = Vector3.New(0, -1.155, -6.13)
				var_177_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_3.position).x, (manager.ui.mainCamera.transform.position - var_177_3.position).y, (manager.ui.mainCamera.transform.position - var_177_3.position).z)
				var_177_3.localEulerAngles.z = 0
				var_177_3.localEulerAngles.x = 0
				var_177_3.localEulerAngles = var_177_3.localEulerAngles
			end

			local var_177_5 = arg_174_1.actors_["10048ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.characterEffect10048ui_story == nil then
				arg_174_1.var_.characterEffect10048ui_story = var_177_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_6 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_6 and not isNil(var_177_5) then
				if arg_174_1.var_.characterEffect10048ui_story and not isNil(var_177_5) then
					arg_174_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_6 and arg_174_1.time_ < 0 + var_177_6 + arg_177_0 and not isNil(var_177_5) and arg_174_1.var_.characterEffect10048ui_story then
				arg_174_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048action/10048action3_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_177_8 = 0
			local var_177_9 = 0.5

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(123071042)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 20 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 20)

				if (20 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 20)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071042", "story_v_out_123071.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071042", "story_v_out_123071.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_123071", "123071042", "story_v_out_123071.awb")

						arg_174_1:RecordAudio("123071042", var_177_15)
						arg_174_1:RecordAudio("123071042", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_123071", "123071042", "story_v_out_123071.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_123071", "123071042", "story_v_out_123071.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play123071043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 123071043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play123071044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10048ui_story"]) and arg_178_1.var_.characterEffect10048ui_story == nil then
				arg_178_1.var_.characterEffect10048ui_story = arg_178_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10048ui_story"]) then
				if arg_178_1.var_.characterEffect10048ui_story and not isNil(arg_178_1.actors_["10048ui_story"]) then
					arg_178_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_178_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10048ui_story"]) and arg_178_1.var_.characterEffect10048ui_story then
				arg_178_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_178_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.875

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(123071043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 35 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 35)

				if (35 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 35)) > 0 and var_181_2 < var_181_5 then
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
	Play123071044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 123071044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play123071045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.95

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(123071044).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 38 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 38)

				if (38 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 38)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play123071045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 123071045
		arg_186_1.duration_ = 10.63

		local var_186_0 = {
			zh = 9,
			ja = 10.633
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play123071046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10048ui_story"]) and arg_186_1.var_.characterEffect10048ui_story == nil then
				arg_186_1.var_.characterEffect10048ui_story = arg_186_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10048ui_story"]) then
				if arg_186_1.var_.characterEffect10048ui_story and not isNil(arg_186_1.actors_["10048ui_story"]) then
					arg_186_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10048ui_story"]) and arg_186_1.var_.characterEffect10048ui_story then
				arg_186_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_189_2 = 0
			local var_189_3 = 1.05

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(123071045)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 42 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 42)

				if (42 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 42)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071045", "story_v_out_123071.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071045", "story_v_out_123071.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_123071", "123071045", "story_v_out_123071.awb")

						arg_186_1:RecordAudio("123071045", var_189_9)
						arg_186_1:RecordAudio("123071045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_123071", "123071045", "story_v_out_123071.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_123071", "123071045", "story_v_out_123071.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play123071046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 123071046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play123071047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10048ui_story"]) and arg_190_1.var_.characterEffect10048ui_story == nil then
				arg_190_1.var_.characterEffect10048ui_story = arg_190_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10048ui_story"]) then
				if arg_190_1.var_.characterEffect10048ui_story and not isNil(arg_190_1.actors_["10048ui_story"]) then
					arg_190_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10048ui_story"]) and arg_190_1.var_.characterEffect10048ui_story then
				arg_190_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.875

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(123071046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 35 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 35)

				if (35 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 35)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play123071047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 123071047
		arg_194_1.duration_ = 5.8

		local var_194_0 = {
			zh = 4,
			ja = 5.8
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play123071048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["10048ui_story"]) and arg_194_1.var_.characterEffect10048ui_story == nil then
				arg_194_1.var_.characterEffect10048ui_story = arg_194_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["10048ui_story"]) then
				if arg_194_1.var_.characterEffect10048ui_story and not isNil(arg_194_1.actors_["10048ui_story"]) then
					arg_194_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["10048ui_story"]) and arg_194_1.var_.characterEffect10048ui_story then
				arg_194_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			local var_197_2 = 0
			local var_197_3 = 0.475

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(123071047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 19 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 19)

				if (19 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 19)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071047", "story_v_out_123071.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071047", "story_v_out_123071.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_123071", "123071047", "story_v_out_123071.awb")

						arg_194_1:RecordAudio("123071047", var_197_9)
						arg_194_1:RecordAudio("123071047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_123071", "123071047", "story_v_out_123071.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_123071", "123071047", "story_v_out_123071.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play123071048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 123071048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play123071049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10048ui_story"]) and arg_198_1.var_.characterEffect10048ui_story == nil then
				arg_198_1.var_.characterEffect10048ui_story = arg_198_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10048ui_story"]) then
				if arg_198_1.var_.characterEffect10048ui_story and not isNil(arg_198_1.actors_["10048ui_story"]) then
					arg_198_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10048ui_story"]) and arg_198_1.var_.characterEffect10048ui_story then
				arg_198_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.25

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

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(123071048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 10 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 10)

				if (10 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 10)) > 0 and var_201_2 < var_201_5 then
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
	Play123071049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 123071049
		arg_202_1.duration_ = 7.47

		local var_202_0 = {
			zh = 4.533,
			ja = 7.466
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
				arg_202_0:Play123071050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10048ui_story"]) and arg_202_1.var_.characterEffect10048ui_story == nil then
				arg_202_1.var_.characterEffect10048ui_story = arg_202_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10048ui_story"]) then
				if arg_202_1.var_.characterEffect10048ui_story and not isNil(arg_202_1.actors_["10048ui_story"]) then
					arg_202_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10048ui_story"]) and arg_202_1.var_.characterEffect10048ui_story then
				arg_202_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/story10048/story10048actionlink/10048action432")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_205_2 = 0
			local var_205_3 = 0.5

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:GetWordFromCfg(123071049)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 20 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 20)

				if (20 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 20)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071049", "story_v_out_123071.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071049", "story_v_out_123071.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_out_123071", "123071049", "story_v_out_123071.awb")

						arg_202_1:RecordAudio("123071049", var_205_9)
						arg_202_1:RecordAudio("123071049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_123071", "123071049", "story_v_out_123071.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_123071", "123071049", "story_v_out_123071.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play123071050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 123071050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play123071051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10048ui_story"]) and arg_206_1.var_.characterEffect10048ui_story == nil then
				arg_206_1.var_.characterEffect10048ui_story = arg_206_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10048ui_story"]) then
				if arg_206_1.var_.characterEffect10048ui_story and not isNil(arg_206_1.actors_["10048ui_story"]) then
					arg_206_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10048ui_story"]) and arg_206_1.var_.characterEffect10048ui_story then
				arg_206_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 0.275

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(123071050).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 11 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 11)

				if (11 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 11)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play123071051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 123071051
		arg_210_1.duration_ = 8.57

		local var_210_0 = {
			zh = 2.7,
			ja = 8.566
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
				arg_210_0:Play123071052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10048ui_story"]) and arg_210_1.var_.characterEffect10048ui_story == nil then
				arg_210_1.var_.characterEffect10048ui_story = arg_210_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10048ui_story"]) then
				if arg_210_1.var_.characterEffect10048ui_story and not isNil(arg_210_1.actors_["10048ui_story"]) then
					arg_210_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10048ui_story"]) and arg_210_1.var_.characterEffect10048ui_story then
				arg_210_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.35

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(123071051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 14 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 14)

				if (14 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 14)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071051", "story_v_out_123071.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071051", "story_v_out_123071.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_123071", "123071051", "story_v_out_123071.awb")

						arg_210_1:RecordAudio("123071051", var_213_9)
						arg_210_1:RecordAudio("123071051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_123071", "123071051", "story_v_out_123071.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_123071", "123071051", "story_v_out_123071.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play123071052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 123071052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play123071053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10048ui_story"]) and arg_214_1.var_.characterEffect10048ui_story == nil then
				arg_214_1.var_.characterEffect10048ui_story = arg_214_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10048ui_story"]) then
				if arg_214_1.var_.characterEffect10048ui_story and not isNil(arg_214_1.actors_["10048ui_story"]) then
					arg_214_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_214_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10048ui_story"]) and arg_214_1.var_.characterEffect10048ui_story then
				arg_214_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_214_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.375

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(123071052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 15 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 15)

				if (15 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 15)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play123071053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 123071053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play123071054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.575

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(123071053).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 23 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 23)

				if (23 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 23)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play123071054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 123071054
		arg_222_1.duration_ = 2.77

		local var_222_0 = {
			zh = 2.766,
			ja = 2.333
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play123071055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10048ui_story"]) and arg_222_1.var_.characterEffect10048ui_story == nil then
				arg_222_1.var_.characterEffect10048ui_story = arg_222_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10048ui_story"]) then
				if arg_222_1.var_.characterEffect10048ui_story and not isNil(arg_222_1.actors_["10048ui_story"]) then
					arg_222_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10048ui_story"]) and arg_222_1.var_.characterEffect10048ui_story then
				arg_222_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_225_2 = 0
			local var_225_3 = 0.325

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_2 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_4 = arg_222_1:GetWordFromCfg(123071054)
				local var_225_5 = arg_222_1:FormatText(var_225_4.content)

				arg_222_1.text_.text = var_225_5

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_7 = 13 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 13)

				if (13 <= 0 and var_225_3 or var_225_3 * (utf8.len(var_225_5) / 13)) > 0 and var_225_3 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_2
					end
				end

				arg_222_1.text_.text = var_225_5
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071054", "story_v_out_123071.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071054", "story_v_out_123071.awb") / 1000

					if var_225_8 + var_225_2 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_2
					end

					if var_225_4.prefab_name ~= "" and arg_222_1.actors_[var_225_4.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_4.prefab_name].transform, "story_v_out_123071", "123071054", "story_v_out_123071.awb")

						arg_222_1:RecordAudio("123071054", var_225_9)
						arg_222_1:RecordAudio("123071054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_123071", "123071054", "story_v_out_123071.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_123071", "123071054", "story_v_out_123071.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_3, arg_222_1.talkMaxDuration)

			if var_225_2 <= arg_222_1.time_ and arg_222_1.time_ < var_225_2 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_2) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_2 + var_225_10 and arg_222_1.time_ < var_225_2 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play123071055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 123071055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play123071056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10048ui_story"]) and arg_226_1.var_.characterEffect10048ui_story == nil then
				arg_226_1.var_.characterEffect10048ui_story = arg_226_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10048ui_story"]) then
				if arg_226_1.var_.characterEffect10048ui_story and not isNil(arg_226_1.actors_["10048ui_story"]) then
					arg_226_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10048ui_story"]) and arg_226_1.var_.characterEffect10048ui_story then
				arg_226_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.8

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(123071055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 32 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 32)

				if (32 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 32)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play123071056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 123071056
		arg_230_1.duration_ = 6.97

		local var_230_0 = {
			zh = 4.933,
			ja = 6.966
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play123071057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10048ui_story"]) and arg_230_1.var_.characterEffect10048ui_story == nil then
				arg_230_1.var_.characterEffect10048ui_story = arg_230_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10048ui_story"]) then
				if arg_230_1.var_.characterEffect10048ui_story and not isNil(arg_230_1.actors_["10048ui_story"]) then
					arg_230_1.var_.characterEffect10048ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10048ui_story"]) and arg_230_1.var_.characterEffect10048ui_story then
				arg_230_1.var_.characterEffect10048ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("10048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_233_2 = 0
			local var_233_3 = 0.575

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[486].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(123071056)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 23 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 23)

				if (23 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 23)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071056", "story_v_out_123071.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071056", "story_v_out_123071.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_123071", "123071056", "story_v_out_123071.awb")

						arg_230_1:RecordAudio("123071056", var_233_9)
						arg_230_1:RecordAudio("123071056", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_123071", "123071056", "story_v_out_123071.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_123071", "123071056", "story_v_out_123071.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play123071057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 123071057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play123071058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10048ui_story"]) and arg_234_1.var_.characterEffect10048ui_story == nil then
				arg_234_1.var_.characterEffect10048ui_story = arg_234_1.actors_["10048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10048ui_story"]) then
				if arg_234_1.var_.characterEffect10048ui_story and not isNil(arg_234_1.actors_["10048ui_story"]) then
					arg_234_1.var_.characterEffect10048ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10048ui_story"]) and arg_234_1.var_.characterEffect10048ui_story then
				arg_234_1.var_.characterEffect10048ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10048ui_story.fillRatio = 0.5
			end

			local var_237_1 = arg_234_1.actors_["10048ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10048ui_story = var_237_1.localPosition
			end

			local var_237_2 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 then
				var_237_1.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10048ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_2)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 then
				var_237_1.localPosition = Vector3.New(0, 100, 0)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			local var_237_3 = 0
			local var_237_4 = 0.975

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_5 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(123071057).content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 39 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 39)

				if (39 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 39)) > 0 and var_237_4 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_3 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_3
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_4, arg_234_1.talkMaxDuration)

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_3) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_3 + var_237_8 and arg_234_1.time_ < var_237_3 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play123071058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 123071058
		arg_238_1.duration_ = 0.5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"

			SetActive(arg_238_1.choicesGo_, true)

			for iter_239_0, iter_239_1 in ipairs(arg_238_1.choices_) do
				SetActive(iter_239_1.go, iter_239_0 <= 1)
			end

			arg_238_1.choices_[1].txt.text = arg_238_1:FormatText(StoryChoiceCfg[502].name)
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play123071059(arg_238_1)
			end

			arg_238_1:RecordChoiceLog(123071058, 502)
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			if arg_238_1.time_ >= 0 + 0.5 and arg_238_1.time_ < 0 + 0.5 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play123071059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 123071059
		arg_242_1.duration_ = 9

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play123071060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.bgs_.STwhite == nil then
				local var_245_0 = Object.Instantiate(arg_242_1.paintGo_)

				var_245_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_245_0.name = "STwhite"
				var_245_0.transform.parent = arg_242_1.stage_.transform
				var_245_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.bgs_.STwhite = var_245_0
			end

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= 2 + arg_245_0 then
				local var_245_1 = arg_242_1.bgs_.STwhite

				arg_242_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_245_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_245_2 = var_245_1:GetComponent("SpriteRenderer")

				if var_245_2 and var_245_2.sprite then
					local var_245_3 = 2 * (var_245_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_245_1.transform.localScale = Vector3.New(var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, var_245_3 / var_245_2.sprite.bounds.size.y < var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x and var_245_3 * manager.ui.mainCameraCom_.aspect / var_245_2.sprite.bounds.size.x or var_245_3 / var_245_2.sprite.bounds.size.y, 0)
				end

				for iter_245_0, iter_245_1 in pairs(arg_242_1.bgs_) do
					if iter_245_0 ~= "STwhite" then
						iter_245_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_245_4 = 0

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_5 = 2

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_5 then
				local var_245_6 = Color.New(0, 0, 0)

				var_245_6.a = Mathf.Lerp(0, 1, (arg_242_1.time_ - var_245_4) / var_245_5)
				arg_242_1.mask_.color = var_245_6
			end

			if arg_242_1.time_ >= var_245_4 + var_245_5 and arg_242_1.time_ < var_245_4 + var_245_5 + arg_245_0 then
				local var_245_7 = Color.New(0, 0, 0)

				var_245_7.a = 1
				arg_242_1.mask_.color = var_245_7
			end

			local var_245_8 = 2

			if 2 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.mask_.enabled = true
				arg_242_1.mask_.raycastTarget = true

				arg_242_1:SetGaussion(false)
			end

			local var_245_9 = 2

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_9 then
				local var_245_10 = Color.New(0, 0, 0)

				var_245_10.a = Mathf.Lerp(1, 0, (arg_242_1.time_ - var_245_8) / var_245_9)
				arg_242_1.mask_.color = var_245_10
			end

			if arg_242_1.time_ >= var_245_8 + var_245_9 and arg_242_1.time_ < var_245_8 + var_245_9 + arg_245_0 then
				local var_245_11 = Color.New(0, 0, 0)

				arg_242_1.mask_.enabled = false
				var_245_11.a = 0
				arg_242_1.mask_.color = var_245_11
			end

			if arg_242_1.frameCnt_ <= 1 then
				arg_242_1.dialog_:SetActive(false)
			end

			local var_245_12 = 4
			local var_245_13 = 1.675

			if 4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_12 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0

				arg_242_1.dialog_:SetActive(true)

				arg_242_1.dialogCg_.alpha = 0

				local var_245_14 = LeanTween.value(arg_242_1.dialog_, 0, 1, 0.3)

				var_245_14:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_242_1.dialogCg_.alpha = arg_246_0
				end))
				var_245_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_242_1.dialog_)
					var_245_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_242_1.duration_ = arg_242_1.duration_ + 0.3

				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_15 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(123071059).content)

				arg_242_1.text_.text = var_245_15

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_17 = 67 <= 0 and var_245_13 or var_245_13 * (utf8.len(var_245_15) / 67)

				if (67 <= 0 and var_245_13 or var_245_13 * (utf8.len(var_245_15) / 67)) > 0 and var_245_13 < var_245_17 then
					arg_242_1.talkMaxDuration = var_245_17
					var_245_12 = var_245_12 + 0.3

					if var_245_17 + var_245_12 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_17 + var_245_12
					end
				end

				arg_242_1.text_.text = var_245_15
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_18 = var_245_12 + 0.3
			local var_245_19 = math.max(var_245_13, arg_242_1.talkMaxDuration)

			if var_245_12 + 0.3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_18 + var_245_19 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_18) / var_245_19

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_18 + var_245_19 and arg_242_1.time_ < var_245_18 + var_245_19 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play123071060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 123071060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play123071061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(123071060).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 44 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 44)

				if (44 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 44)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play123071061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 123071061
		arg_252_1.duration_ = 7

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play123071062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if arg_252_1.bgs_.K05f == nil then
				local var_255_0 = Object.Instantiate(arg_252_1.paintGo_)

				var_255_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_255_0.name = "K05f"
				var_255_0.transform.parent = arg_252_1.stage_.transform
				var_255_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.bgs_.K05f = var_255_0
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_1 = arg_252_1.bgs_.K05f

				arg_252_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_2 = var_255_1:GetComponent("SpriteRenderer")

				if var_255_2 and var_255_2.sprite then
					local var_255_3 = 2 * (var_255_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_1.transform.localScale = Vector3.New(var_255_3 / var_255_2.sprite.bounds.size.y < var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x and var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x or var_255_3 / var_255_2.sprite.bounds.size.y, var_255_3 / var_255_2.sprite.bounds.size.y < var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x and var_255_3 * manager.ui.mainCameraCom_.aspect / var_255_2.sprite.bounds.size.x or var_255_3 / var_255_2.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "K05f" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_255_4 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_5 = 2

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_5 then
				local var_255_6 = Color.New(1, 1, 1)

				var_255_6.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_4) / var_255_5)
				arg_252_1.mask_.color = var_255_6
			end

			if arg_252_1.time_ >= var_255_4 + var_255_5 and arg_252_1.time_ < var_255_4 + var_255_5 + arg_255_0 then
				local var_255_7 = Color.New(1, 1, 1)

				arg_252_1.mask_.enabled = false
				var_255_7.a = 0
				arg_252_1.mask_.color = var_255_7
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_8 = 2
			local var_255_9 = 0.425

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_10 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_10:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_11 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(123071061).content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 17 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 17)

				if (17 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 17)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13
					var_255_8 = var_255_8 + 0.3

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = var_255_8 + 0.3
			local var_255_15 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_14 + var_255_15 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_14) / var_255_15

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_14 + var_255_15 and arg_252_1.time_ < var_255_14 + var_255_15 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play123071062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 123071062
		arg_258_1.duration_ = 4.2

		local var_258_0 = {
			zh = 3.066,
			ja = 4.2
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
				arg_258_0:Play123071063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if arg_258_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_261_0 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_258_1.stage_.transform)

				var_261_0.name = "1050ui_story"
				var_261_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.actors_["1050ui_story"] = var_261_0

				local var_261_1 = var_261_0:GetComponentInChildren(typeof(CharacterEffect))

				var_261_1.enabled = true

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end

				arg_258_1:ShowWeapon(var_261_1.transform, false)

				arg_258_1.var_["1050ui_story" .. "Animator"] = var_261_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_258_1.var_["1050ui_story" .. "Animator"].applyRootMotion = true
				arg_258_1.var_["1050ui_story" .. "LipSync"] = var_261_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_261_3 = arg_258_1.actors_["1050ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1050ui_story = var_261_3.localPosition
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_3.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_258_1.time_ - 0) / var_261_4)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_3.localPosition = Vector3.New(0, -1, -6.1)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			local var_261_5 = arg_258_1.actors_["1050ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1050ui_story == nil then
				arg_258_1.var_.characterEffect1050ui_story = var_261_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_6 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_6 and not isNil(var_261_5) then
				if arg_258_1.var_.characterEffect1050ui_story and not isNil(var_261_5) then
					arg_258_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_6 and arg_258_1.time_ < 0 + var_261_6 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1050ui_story then
				arg_258_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_261_8 = 0
			local var_261_9 = 0.375

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:GetWordFromCfg(123071062)
				local var_261_11 = arg_258_1:FormatText(var_261_10.content)

				arg_258_1.text_.text = var_261_11

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 15 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 15)

				if (15 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 15)) > 0 and var_261_9 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_11
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071062", "story_v_out_123071.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071062", "story_v_out_123071.awb") / 1000

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end

					if var_261_10.prefab_name ~= "" and arg_258_1.actors_[var_261_10.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_10.prefab_name].transform, "story_v_out_123071", "123071062", "story_v_out_123071.awb")

						arg_258_1:RecordAudio("123071062", var_261_15)
						arg_258_1:RecordAudio("123071062", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_123071", "123071062", "story_v_out_123071.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_123071", "123071062", "story_v_out_123071.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play123071063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 123071063
		arg_262_1.duration_ = 11.93

		local var_262_0 = {
			zh = 10.433,
			ja = 11.933
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play123071064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if arg_262_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_265_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_262_1.stage_.transform)

				var_265_0.name = "1093ui_story"
				var_265_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_["1093ui_story"] = var_265_0

				local var_265_1 = var_265_0:GetComponentInChildren(typeof(CharacterEffect))

				var_265_1.enabled = true

				local var_265_2 = GameObjectTools.GetOrAddComponent(var_265_0, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(false)
				end

				arg_262_1:ShowWeapon(var_265_1.transform, false)

				arg_262_1.var_["1093ui_story" .. "Animator"] = var_265_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_262_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_262_1.var_["1093ui_story" .. "LipSync"] = var_265_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_265_3 = arg_262_1.actors_["1093ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1093ui_story = var_265_3.localPosition
			end

			local var_265_4 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				var_265_3.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_262_1.time_ - 0) / var_265_4)
				var_265_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_3.position).x, (manager.ui.mainCamera.transform.position - var_265_3.position).y, (manager.ui.mainCamera.transform.position - var_265_3.position).z)
				var_265_3.localEulerAngles.z = 0
				var_265_3.localEulerAngles.x = 0
				var_265_3.localEulerAngles = var_265_3.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				var_265_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_265_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_3.position).x, (manager.ui.mainCamera.transform.position - var_265_3.position).y, (manager.ui.mainCamera.transform.position - var_265_3.position).z)
				var_265_3.localEulerAngles.z = 0
				var_265_3.localEulerAngles.x = 0
				var_265_3.localEulerAngles = var_265_3.localEulerAngles
			end

			local var_265_5 = arg_262_1.actors_["1093ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect1093ui_story == nil then
				arg_262_1.var_.characterEffect1093ui_story = var_265_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_6 and not isNil(var_265_5) then
				if arg_262_1.var_.characterEffect1093ui_story and not isNil(var_265_5) then
					arg_262_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_6 and arg_262_1.time_ < 0 + var_265_6 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect1093ui_story then
				arg_262_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_265_8 = arg_262_1.actors_["1050ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1050ui_story = var_265_8.localPosition
			end

			local var_265_9 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_9 then
				var_265_8.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_9)
				var_265_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_8.position).x, (manager.ui.mainCamera.transform.position - var_265_8.position).y, (manager.ui.mainCamera.transform.position - var_265_8.position).z)
				var_265_8.localEulerAngles.z = 0
				var_265_8.localEulerAngles.x = 0
				var_265_8.localEulerAngles = var_265_8.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_9 and arg_262_1.time_ < 0 + var_265_9 + arg_265_0 then
				var_265_8.localPosition = Vector3.New(0, 100, 0)
				var_265_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_8.position).x, (manager.ui.mainCamera.transform.position - var_265_8.position).y, (manager.ui.mainCamera.transform.position - var_265_8.position).z)
				var_265_8.localEulerAngles.z = 0
				var_265_8.localEulerAngles.x = 0
				var_265_8.localEulerAngles = var_265_8.localEulerAngles
			end

			local var_265_10 = arg_262_1.actors_["1050ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_10) and arg_262_1.var_.characterEffect1050ui_story == nil then
				arg_262_1.var_.characterEffect1050ui_story = var_265_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_11 and not isNil(var_265_10) then
				if arg_262_1.var_.characterEffect1050ui_story and not isNil(var_265_10) then
					arg_262_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_11)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_11 and arg_262_1.time_ < 0 + var_265_11 + arg_265_0 and not isNil(var_265_10) and arg_262_1.var_.characterEffect1050ui_story then
				arg_262_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_265_12 = 0
			local var_265_13 = 1.075

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_12 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_14 = arg_262_1:GetWordFromCfg(123071063)
				local var_265_15 = arg_262_1:FormatText(var_265_14.content)

				arg_262_1.text_.text = var_265_15

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_17 = 43 <= 0 and var_265_13 or var_265_13 * (utf8.len(var_265_15) / 43)

				if (43 <= 0 and var_265_13 or var_265_13 * (utf8.len(var_265_15) / 43)) > 0 and var_265_13 < var_265_17 then
					arg_262_1.talkMaxDuration = var_265_17

					if var_265_17 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_17 + var_265_12
					end
				end

				arg_262_1.text_.text = var_265_15
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071063", "story_v_out_123071.awb") ~= 0 then
					local var_265_18 = manager.audio:GetVoiceLength("story_v_out_123071", "123071063", "story_v_out_123071.awb") / 1000

					if var_265_18 + var_265_12 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_18 + var_265_12
					end

					if var_265_14.prefab_name ~= "" and arg_262_1.actors_[var_265_14.prefab_name] ~= nil then
						local var_265_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_14.prefab_name].transform, "story_v_out_123071", "123071063", "story_v_out_123071.awb")

						arg_262_1:RecordAudio("123071063", var_265_19)
						arg_262_1:RecordAudio("123071063", var_265_19)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_123071", "123071063", "story_v_out_123071.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_123071", "123071063", "story_v_out_123071.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_20 = math.max(var_265_13, arg_262_1.talkMaxDuration)

			if var_265_12 <= arg_262_1.time_ and arg_262_1.time_ < var_265_12 + var_265_20 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_12) / var_265_20

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_12 + var_265_20 and arg_262_1.time_ < var_265_12 + var_265_20 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play123071064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 123071064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play123071065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1093ui_story"]) and arg_266_1.var_.characterEffect1093ui_story == nil then
				arg_266_1.var_.characterEffect1093ui_story = arg_266_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1093ui_story"]) then
				if arg_266_1.var_.characterEffect1093ui_story and not isNil(arg_266_1.actors_["1093ui_story"]) then
					arg_266_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1093ui_story"]) and arg_266_1.var_.characterEffect1093ui_story then
				arg_266_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.575

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(123071064).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 23 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 23)

				if (23 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 23)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play123071065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 123071065
		arg_270_1.duration_ = 10

		local var_270_0 = {
			zh = 10,
			ja = 8.333
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play123071066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_273_0 = arg_270_1.actors_["1093ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1093ui_story == nil then
				arg_270_1.var_.characterEffect1093ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_1 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 and not isNil(var_273_0) then
				if arg_270_1.var_.characterEffect1093ui_story and not isNil(var_273_0) then
					arg_270_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1093ui_story then
				arg_270_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_273_3 = 0
			local var_273_4 = 1.15

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_5 = arg_270_1:GetWordFromCfg(123071065)
				local var_273_6 = arg_270_1:FormatText(var_273_5.content)

				arg_270_1.text_.text = var_273_6

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_8 = 46 <= 0 and var_273_4 or var_273_4 * (utf8.len(var_273_6) / 46)

				if (46 <= 0 and var_273_4 or var_273_4 * (utf8.len(var_273_6) / 46)) > 0 and var_273_4 < var_273_8 then
					arg_270_1.talkMaxDuration = var_273_8

					if var_273_8 + var_273_3 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_3
					end
				end

				arg_270_1.text_.text = var_273_6
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071065", "story_v_out_123071.awb") ~= 0 then
					local var_273_9 = manager.audio:GetVoiceLength("story_v_out_123071", "123071065", "story_v_out_123071.awb") / 1000

					if var_273_9 + var_273_3 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_3
					end

					if var_273_5.prefab_name ~= "" and arg_270_1.actors_[var_273_5.prefab_name] ~= nil then
						local var_273_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_5.prefab_name].transform, "story_v_out_123071", "123071065", "story_v_out_123071.awb")

						arg_270_1:RecordAudio("123071065", var_273_10)
						arg_270_1:RecordAudio("123071065", var_273_10)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_123071", "123071065", "story_v_out_123071.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_123071", "123071065", "story_v_out_123071.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_11 = math.max(var_273_4, arg_270_1.talkMaxDuration)

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_11 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_3) / var_273_11

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_3 + var_273_11 and arg_270_1.time_ < var_273_3 + var_273_11 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play123071066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 123071066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play123071067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1093ui_story"]) and arg_274_1.var_.characterEffect1093ui_story == nil then
				arg_274_1.var_.characterEffect1093ui_story = arg_274_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1093ui_story"]) then
				if arg_274_1.var_.characterEffect1093ui_story and not isNil(arg_274_1.actors_["1093ui_story"]) then
					arg_274_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1093ui_story"]) and arg_274_1.var_.characterEffect1093ui_story then
				arg_274_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.35

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(123071066).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 14 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 14)

				if (14 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 14)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play123071067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 123071067
		arg_278_1.duration_ = 8.47

		local var_278_0 = {
			zh = 8.3,
			ja = 8.466
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
				arg_278_0:Play123071068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1093ui_story"]) and arg_278_1.var_.characterEffect1093ui_story == nil then
				arg_278_1.var_.characterEffect1093ui_story = arg_278_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1093ui_story"]) then
				if arg_278_1.var_.characterEffect1093ui_story and not isNil(arg_278_1.actors_["1093ui_story"]) then
					arg_278_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1093ui_story"]) and arg_278_1.var_.characterEffect1093ui_story then
				arg_278_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_281_2 = 0
			local var_281_3 = 0.75

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_4 = arg_278_1:GetWordFromCfg(123071067)
				local var_281_5 = arg_278_1:FormatText(var_281_4.content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 30 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 30)

				if (30 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 30)) > 0 and var_281_3 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071067", "story_v_out_123071.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071067", "story_v_out_123071.awb") / 1000

					if var_281_8 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_2
					end

					if var_281_4.prefab_name ~= "" and arg_278_1.actors_[var_281_4.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_4.prefab_name].transform, "story_v_out_123071", "123071067", "story_v_out_123071.awb")

						arg_278_1:RecordAudio("123071067", var_281_9)
						arg_278_1:RecordAudio("123071067", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_123071", "123071067", "story_v_out_123071.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_123071", "123071067", "story_v_out_123071.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 <= arg_278_1.time_ and arg_278_1.time_ < var_281_2 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_2) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_2 + var_281_10 and arg_278_1.time_ < var_281_2 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play123071068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 123071068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play123071069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1093ui_story"]) and arg_282_1.var_.characterEffect1093ui_story == nil then
				arg_282_1.var_.characterEffect1093ui_story = arg_282_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1093ui_story"]) then
				if arg_282_1.var_.characterEffect1093ui_story and not isNil(arg_282_1.actors_["1093ui_story"]) then
					arg_282_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1093ui_story"]) and arg_282_1.var_.characterEffect1093ui_story then
				arg_282_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 1.5

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(123071068).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 60 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 60)

				if (60 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 60)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play123071069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 123071069
		arg_286_1.duration_ = 4.87

		local var_286_0 = {
			zh = 4.333,
			ja = 4.866
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play123071070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1093ui_story"]) and arg_286_1.var_.characterEffect1093ui_story == nil then
				arg_286_1.var_.characterEffect1093ui_story = arg_286_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1093ui_story"]) then
				if arg_286_1.var_.characterEffect1093ui_story and not isNil(arg_286_1.actors_["1093ui_story"]) then
					arg_286_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1093ui_story"]) and arg_286_1.var_.characterEffect1093ui_story then
				arg_286_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_2 = 0
			local var_289_3 = 0.5

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_2 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_4 = arg_286_1:GetWordFromCfg(123071069)
				local var_289_5 = arg_286_1:FormatText(var_289_4.content)

				arg_286_1.text_.text = var_289_5

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_7 = 20 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 20)

				if (20 <= 0 and var_289_3 or var_289_3 * (utf8.len(var_289_5) / 20)) > 0 and var_289_3 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_2
					end
				end

				arg_286_1.text_.text = var_289_5
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071069", "story_v_out_123071.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071069", "story_v_out_123071.awb") / 1000

					if var_289_8 + var_289_2 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_2
					end

					if var_289_4.prefab_name ~= "" and arg_286_1.actors_[var_289_4.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_4.prefab_name].transform, "story_v_out_123071", "123071069", "story_v_out_123071.awb")

						arg_286_1:RecordAudio("123071069", var_289_9)
						arg_286_1:RecordAudio("123071069", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_123071", "123071069", "story_v_out_123071.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_123071", "123071069", "story_v_out_123071.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_3, arg_286_1.talkMaxDuration)

			if var_289_2 <= arg_286_1.time_ and arg_286_1.time_ < var_289_2 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_2) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_2 + var_289_10 and arg_286_1.time_ < var_289_2 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play123071070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 123071070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play123071071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1093ui_story"]) and arg_290_1.var_.characterEffect1093ui_story == nil then
				arg_290_1.var_.characterEffect1093ui_story = arg_290_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1093ui_story"]) then
				if arg_290_1.var_.characterEffect1093ui_story and not isNil(arg_290_1.actors_["1093ui_story"]) then
					arg_290_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1093ui_story"]) and arg_290_1.var_.characterEffect1093ui_story then
				arg_290_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.725

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(123071070).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 29 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 29)

				if (29 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 29)) > 0 and var_293_2 < var_293_5 then
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

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play123071071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 123071071
		arg_294_1.duration_ = 16.23

		local var_294_0 = {
			zh = 13.666,
			ja = 16.233
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play123071072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1093ui_story"]) and arg_294_1.var_.characterEffect1093ui_story == nil then
				arg_294_1.var_.characterEffect1093ui_story = arg_294_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1093ui_story"]) then
				if arg_294_1.var_.characterEffect1093ui_story and not isNil(arg_294_1.actors_["1093ui_story"]) then
					arg_294_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1093ui_story"]) and arg_294_1.var_.characterEffect1093ui_story then
				arg_294_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_297_2 = 0
			local var_297_3 = 1.525

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_4 = arg_294_1:GetWordFromCfg(123071071)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 61 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 61)

				if (61 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 61)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071071", "story_v_out_123071.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071071", "story_v_out_123071.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_out_123071", "123071071", "story_v_out_123071.awb")

						arg_294_1:RecordAudio("123071071", var_297_9)
						arg_294_1:RecordAudio("123071071", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_123071", "123071071", "story_v_out_123071.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_123071", "123071071", "story_v_out_123071.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play123071072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 123071072
		arg_298_1.duration_ = 4.3

		local var_298_0 = {
			zh = 3.8,
			ja = 4.3
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play123071073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1093ui_story"]) and arg_298_1.var_.characterEffect1093ui_story == nil then
				arg_298_1.var_.characterEffect1093ui_story = arg_298_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1093ui_story"]) then
				if arg_298_1.var_.characterEffect1093ui_story and not isNil(arg_298_1.actors_["1093ui_story"]) then
					arg_298_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1093ui_story"]) and arg_298_1.var_.characterEffect1093ui_story then
				arg_298_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action9_1")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_301_2 = 0
			local var_301_3 = 0.525

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_4 = arg_298_1:GetWordFromCfg(123071072)
				local var_301_5 = arg_298_1:FormatText(var_301_4.content)

				arg_298_1.text_.text = var_301_5

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_7 = 21 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 21)

				if (21 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_5) / 21)) > 0 and var_301_3 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_2
					end
				end

				arg_298_1.text_.text = var_301_5
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071072", "story_v_out_123071.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071072", "story_v_out_123071.awb") / 1000

					if var_301_8 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_2
					end

					if var_301_4.prefab_name ~= "" and arg_298_1.actors_[var_301_4.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_4.prefab_name].transform, "story_v_out_123071", "123071072", "story_v_out_123071.awb")

						arg_298_1:RecordAudio("123071072", var_301_9)
						arg_298_1:RecordAudio("123071072", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_123071", "123071072", "story_v_out_123071.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_123071", "123071072", "story_v_out_123071.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_3, arg_298_1.talkMaxDuration)

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_2) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_2 + var_301_10 and arg_298_1.time_ < var_301_2 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play123071073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 123071073
		arg_302_1.duration_ = 9

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play123071074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 1.96599999815226 < arg_302_1.time_ and arg_302_1.time_ <= 1.96599999815226 + arg_305_0 then
				arg_302_1.var_.moveOldPos1093ui_story = arg_302_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 1.96599999815226 <= arg_302_1.time_ and arg_302_1.time_ < 1.96599999815226 + var_305_0 then
				arg_302_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_302_1.time_ - 1.96599999815226) / var_305_0)
				arg_302_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).z)
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles = arg_302_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 1.96599999815226 + var_305_0 and arg_302_1.time_ < 1.96599999815226 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1093ui_story"].transform.position).z)
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1093ui_story"].transform.localEulerAngles = arg_302_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_302_1.time_ and arg_302_1.time_ <= 1.96599999815226 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1093ui_story == nil then
				arg_302_1.var_.characterEffect1093ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.034000001847744

			if 1.96599999815226 <= arg_302_1.time_ and arg_302_1.time_ < 1.96599999815226 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1093ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_302_1.time_ - 1.96599999815226) / var_305_2)
				end
			end

			if arg_302_1.time_ >= 1.96599999815226 + var_305_2 and arg_302_1.time_ < 1.96599999815226 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1093ui_story then
				arg_302_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_305_3 = 0

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_3 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_4 = 2

			if var_305_3 <= arg_302_1.time_ and arg_302_1.time_ < var_305_3 + var_305_4 then
				local var_305_5 = Color.New(0, 0, 0)

				var_305_5.a = Mathf.Lerp(0, 1, (arg_302_1.time_ - var_305_3) / var_305_4)
				arg_302_1.mask_.color = var_305_5
			end

			if arg_302_1.time_ >= var_305_3 + var_305_4 and arg_302_1.time_ < var_305_3 + var_305_4 + arg_305_0 then
				local var_305_6 = Color.New(0, 0, 0)

				var_305_6.a = 1
				arg_302_1.mask_.color = var_305_6
			end

			local var_305_7 = 2

			if 2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_8 = 2

			if var_305_7 <= arg_302_1.time_ and arg_302_1.time_ < var_305_7 + var_305_8 then
				local var_305_9 = Color.New(0, 0, 0)

				var_305_9.a = Mathf.Lerp(1, 0, (arg_302_1.time_ - var_305_7) / var_305_8)
				arg_302_1.mask_.color = var_305_9
			end

			if arg_302_1.time_ >= var_305_7 + var_305_8 and arg_302_1.time_ < var_305_7 + var_305_8 + arg_305_0 then
				local var_305_10 = Color.New(0, 0, 0)

				arg_302_1.mask_.enabled = false
				var_305_10.a = 0
				arg_302_1.mask_.color = var_305_10
			end

			local var_305_11 = "K06f"

			if arg_302_1.bgs_.K06f == nil then
				local var_305_12 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_305_11)
				var_305_12.name = var_305_11
				var_305_12.transform.parent = arg_302_1.stage_.transform
				var_305_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_[var_305_11] = var_305_12
			end

			if 2 < arg_302_1.time_ and arg_302_1.time_ <= 2 + arg_305_0 then
				local var_305_13 = arg_302_1.bgs_.K06f

				arg_302_1.bgs_.K06f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_305_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_14 = var_305_13:GetComponent("SpriteRenderer")

				if var_305_14 and var_305_14.sprite then
					local var_305_15 = 2 * (var_305_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_305_13.transform.localScale = Vector3.New(var_305_15 / var_305_14.sprite.bounds.size.y < var_305_15 * manager.ui.mainCameraCom_.aspect / var_305_14.sprite.bounds.size.x and var_305_15 * manager.ui.mainCameraCom_.aspect / var_305_14.sprite.bounds.size.x or var_305_15 / var_305_14.sprite.bounds.size.y, var_305_15 / var_305_14.sprite.bounds.size.y < var_305_15 * manager.ui.mainCameraCom_.aspect / var_305_14.sprite.bounds.size.x and var_305_15 * manager.ui.mainCameraCom_.aspect / var_305_14.sprite.bounds.size.x or var_305_15 / var_305_14.sprite.bounds.size.y, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "K06f" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_16 = 4
			local var_305_17 = 0.5

			if 4 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_18 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_18:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_19 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(123071073).content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_21 = 20 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_19) / 20)

				if (20 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_19) / 20)) > 0 and var_305_17 < var_305_21 then
					arg_302_1.talkMaxDuration = var_305_21
					var_305_16 = var_305_16 + 0.3

					if var_305_21 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_21 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_22 = var_305_16 + 0.3
			local var_305_23 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 + 0.3 <= arg_302_1.time_ and arg_302_1.time_ < var_305_22 + var_305_23 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_22) / var_305_23

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_22 + var_305_23 and arg_302_1.time_ < var_305_22 + var_305_23 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play123071074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 123071074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play123071075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 1.2

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(123071074).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 48 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 48)

				if (48 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 48)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play123071075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 123071075
		arg_312_1.duration_ = 0.5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"

			SetActive(arg_312_1.choicesGo_, true)

			for iter_313_0, iter_313_1 in ipairs(arg_312_1.choices_) do
				SetActive(iter_313_1.go, iter_313_0 <= 1)
			end

			arg_312_1.choices_[1].txt.text = arg_312_1:FormatText(StoryChoiceCfg[503].name)
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play123071076(arg_312_1)
			end

			arg_312_1:RecordChoiceLog(123071075, 503)
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.allBtn_.enabled = false
			end

			if arg_312_1.time_ >= 0 + 0.5 and arg_312_1.time_ < 0 + 0.5 + arg_315_0 then
				arg_312_1.allBtn_.enabled = true
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play123071076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 123071076
		arg_316_1.duration_ = 3.77

		local var_316_0 = {
			zh = 3.766,
			ja = 3.7
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play123071077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.275

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(123071076)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 11 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 11)

				if (11 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 11)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071076", "story_v_out_123071.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071076", "story_v_out_123071.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_123071", "123071076", "story_v_out_123071.awb")

						arg_316_1:RecordAudio("123071076", var_319_6)
						arg_316_1:RecordAudio("123071076", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_123071", "123071076", "story_v_out_123071.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_123071", "123071076", "story_v_out_123071.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play123071077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 123071077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play123071078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.625

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(123071077).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 25 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 25)

				if (25 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 25)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play123071078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 123071078
		arg_324_1.duration_ = 6.3

		local var_324_0 = {
			zh = 4.966,
			ja = 6.3
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play123071079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1093ui_story = arg_324_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_327_0 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 then
				arg_324_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_324_1.time_ - 0) / var_327_0)
				arg_324_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).z)
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles = arg_324_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 then
				arg_324_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_324_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1093ui_story"].transform.position).z)
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1093ui_story"].transform.localEulerAngles = arg_324_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_327_1 = arg_324_1.actors_["1093ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1093ui_story == nil then
				arg_324_1.var_.characterEffect1093ui_story = var_327_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 and not isNil(var_327_1) then
				if arg_324_1.var_.characterEffect1093ui_story and not isNil(var_327_1) then
					arg_324_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1093ui_story then
				arg_324_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_327_4 = 0
			local var_327_5 = 0.525

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_6 = arg_324_1:GetWordFromCfg(123071078)
				local var_327_7 = arg_324_1:FormatText(var_327_6.content)

				arg_324_1.text_.text = var_327_7

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_9 = 21 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 21)

				if (21 <= 0 and var_327_5 or var_327_5 * (utf8.len(var_327_7) / 21)) > 0 and var_327_5 < var_327_9 then
					arg_324_1.talkMaxDuration = var_327_9

					if var_327_9 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_9 + var_327_4
					end
				end

				arg_324_1.text_.text = var_327_7
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071078", "story_v_out_123071.awb") ~= 0 then
					local var_327_10 = manager.audio:GetVoiceLength("story_v_out_123071", "123071078", "story_v_out_123071.awb") / 1000

					if var_327_10 + var_327_4 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_4
					end

					if var_327_6.prefab_name ~= "" and arg_324_1.actors_[var_327_6.prefab_name] ~= nil then
						local var_327_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_6.prefab_name].transform, "story_v_out_123071", "123071078", "story_v_out_123071.awb")

						arg_324_1:RecordAudio("123071078", var_327_11)
						arg_324_1:RecordAudio("123071078", var_327_11)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_123071", "123071078", "story_v_out_123071.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_123071", "123071078", "story_v_out_123071.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_12 = math.max(var_327_5, arg_324_1.talkMaxDuration)

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_12 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_4) / var_327_12

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_4 + var_327_12 and arg_324_1.time_ < var_327_4 + var_327_12 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play123071079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 123071079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play123071080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1093ui_story"]) and arg_328_1.var_.characterEffect1093ui_story == nil then
				arg_328_1.var_.characterEffect1093ui_story = arg_328_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1093ui_story"]) then
				if arg_328_1.var_.characterEffect1093ui_story and not isNil(arg_328_1.actors_["1093ui_story"]) then
					arg_328_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_0)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1093ui_story"]) and arg_328_1.var_.characterEffect1093ui_story then
				arg_328_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_331_1 = 0
			local var_331_2 = 0.8

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_3 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(123071079).content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 32 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 32)

				if (32 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_3) / 32)) > 0 and var_331_2 < var_331_5 then
					arg_328_1.talkMaxDuration = var_331_5

					if var_331_5 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_6 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_6 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_6

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_6 and arg_328_1.time_ < var_331_1 + var_331_6 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play123071080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 123071080
		arg_332_1.duration_ = 5.57

		local var_332_0 = {
			zh = 3.8,
			ja = 5.566
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play123071081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0.3

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_1 = arg_332_1:GetWordFromCfg(123071080)
				local var_335_2 = arg_332_1:FormatText(var_335_1.content)

				arg_332_1.text_.text = var_335_2

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 12 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 12)

				if (12 <= 0 and var_335_0 or var_335_0 * (utf8.len(var_335_2) / 12)) > 0 and var_335_0 < var_335_4 then
					arg_332_1.talkMaxDuration = var_335_4

					if var_335_4 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_4 + 0
					end
				end

				arg_332_1.text_.text = var_335_2
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071080", "story_v_out_123071.awb") ~= 0 then
					local var_335_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071080", "story_v_out_123071.awb") / 1000

					if var_335_5 + 0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + 0
					end

					if var_335_1.prefab_name ~= "" and arg_332_1.actors_[var_335_1.prefab_name] ~= nil then
						local var_335_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_1.prefab_name].transform, "story_v_out_123071", "123071080", "story_v_out_123071.awb")

						arg_332_1:RecordAudio("123071080", var_335_6)
						arg_332_1:RecordAudio("123071080", var_335_6)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_123071", "123071080", "story_v_out_123071.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_123071", "123071080", "story_v_out_123071.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_0, arg_332_1.talkMaxDuration)

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - 0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play123071081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 123071081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play123071082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1093ui_story = arg_336_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).z)
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles = arg_336_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1093ui_story"].transform.position).z)
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1093ui_story"].transform.localEulerAngles = arg_336_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_339_1 = 0
			local var_339_2 = 0.65

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_3 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(123071081).content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 26 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 26)

				if (26 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_3) / 26)) > 0 and var_339_2 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_6 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_6 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_6

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_6 and arg_336_1.time_ < var_339_1 + var_339_6 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play123071082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 123071082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play123071083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 1.175

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(123071082).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 47 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 47)

				if (47 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 47)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play123071083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 123071083
		arg_344_1.duration_ = 8.17

		local var_344_0 = {
			zh = 7.8,
			ja = 8.166
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play123071084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if arg_344_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_347_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_344_1.stage_.transform)

				var_347_0.name = "1015ui_story"
				var_347_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_344_1.actors_["1015ui_story"] = var_347_0

				local var_347_1 = var_347_0:GetComponentInChildren(typeof(CharacterEffect))

				var_347_1.enabled = true

				local var_347_2 = GameObjectTools.GetOrAddComponent(var_347_0, typeof(DynamicBoneHelper))

				if var_347_2 then
					var_347_2:EnableDynamicBone(false)
				end

				arg_344_1:ShowWeapon(var_347_1.transform, false)

				arg_344_1.var_["1015ui_story" .. "Animator"] = var_347_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_344_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_344_1.var_["1015ui_story" .. "LipSync"] = var_347_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_347_3 = arg_344_1.actors_["1015ui_story"].transform

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos1015ui_story = var_347_3.localPosition
			end

			local var_347_4 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				var_347_3.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_344_1.time_ - 0) / var_347_4)
				var_347_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_3.position).x, (manager.ui.mainCamera.transform.position - var_347_3.position).y, (manager.ui.mainCamera.transform.position - var_347_3.position).z)
				var_347_3.localEulerAngles.z = 0
				var_347_3.localEulerAngles.x = 0
				var_347_3.localEulerAngles = var_347_3.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				var_347_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_347_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_3.position).x, (manager.ui.mainCamera.transform.position - var_347_3.position).y, (manager.ui.mainCamera.transform.position - var_347_3.position).z)
				var_347_3.localEulerAngles.z = 0
				var_347_3.localEulerAngles.x = 0
				var_347_3.localEulerAngles = var_347_3.localEulerAngles
			end

			local var_347_5 = arg_344_1.actors_["1015ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.characterEffect1015ui_story == nil then
				arg_344_1.var_.characterEffect1015ui_story = var_347_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_6 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_6 and not isNil(var_347_5) then
				if arg_344_1.var_.characterEffect1015ui_story and not isNil(var_347_5) then
					arg_344_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_6 and arg_344_1.time_ < 0 + var_347_6 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.characterEffect1015ui_story then
				arg_344_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_8 = 0
			local var_347_9 = 0.975

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_8 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_10 = arg_344_1:GetWordFromCfg(123071083)
				local var_347_11 = arg_344_1:FormatText(var_347_10.content)

				arg_344_1.text_.text = var_347_11

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_13 = 39 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 39)

				if (39 <= 0 and var_347_9 or var_347_9 * (utf8.len(var_347_11) / 39)) > 0 and var_347_9 < var_347_13 then
					arg_344_1.talkMaxDuration = var_347_13

					if var_347_13 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_8
					end
				end

				arg_344_1.text_.text = var_347_11
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071083", "story_v_out_123071.awb") ~= 0 then
					local var_347_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071083", "story_v_out_123071.awb") / 1000

					if var_347_14 + var_347_8 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_14 + var_347_8
					end

					if var_347_10.prefab_name ~= "" and arg_344_1.actors_[var_347_10.prefab_name] ~= nil then
						local var_347_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_10.prefab_name].transform, "story_v_out_123071", "123071083", "story_v_out_123071.awb")

						arg_344_1:RecordAudio("123071083", var_347_15)
						arg_344_1:RecordAudio("123071083", var_347_15)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_123071", "123071083", "story_v_out_123071.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_123071", "123071083", "story_v_out_123071.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_16 = math.max(var_347_9, arg_344_1.talkMaxDuration)

			if var_347_8 <= arg_344_1.time_ and arg_344_1.time_ < var_347_8 + var_347_16 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_8) / var_347_16

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_8 + var_347_16 and arg_344_1.time_ < var_347_8 + var_347_16 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play123071084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 123071084
		arg_348_1.duration_ = 15.73

		local var_348_0 = {
			zh = 15.733,
			ja = 14.7
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play123071085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 2.075

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(123071084)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 83 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 83)

				if (83 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 83)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071084", "story_v_out_123071.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071084", "story_v_out_123071.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_123071", "123071084", "story_v_out_123071.awb")

						arg_348_1:RecordAudio("123071084", var_351_6)
						arg_348_1:RecordAudio("123071084", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_123071", "123071084", "story_v_out_123071.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_123071", "123071084", "story_v_out_123071.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play123071085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 123071085
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play123071086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1015ui_story"]) and arg_352_1.var_.characterEffect1015ui_story == nil then
				arg_352_1.var_.characterEffect1015ui_story = arg_352_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1015ui_story"]) then
				if arg_352_1.var_.characterEffect1015ui_story and not isNil(arg_352_1.actors_["1015ui_story"]) then
					arg_352_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1015ui_story"]) and arg_352_1.var_.characterEffect1015ui_story then
				arg_352_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.275

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(123071085).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 11 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 11)

				if (11 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 11)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play123071086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 123071086
		arg_356_1.duration_ = 5.77

		local var_356_0 = {
			zh = 4.333,
			ja = 5.766
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play123071087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1015ui_story"]) and arg_356_1.var_.characterEffect1015ui_story == nil then
				arg_356_1.var_.characterEffect1015ui_story = arg_356_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1015ui_story"]) then
				if arg_356_1.var_.characterEffect1015ui_story and not isNil(arg_356_1.actors_["1015ui_story"]) then
					arg_356_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1015ui_story"]) and arg_356_1.var_.characterEffect1015ui_story then
				arg_356_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_359_2 = 0
			local var_359_3 = 0.5

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(123071086)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 20 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 20)

				if (20 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 20)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071086", "story_v_out_123071.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071086", "story_v_out_123071.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_out_123071", "123071086", "story_v_out_123071.awb")

						arg_356_1:RecordAudio("123071086", var_359_9)
						arg_356_1:RecordAudio("123071086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_123071", "123071086", "story_v_out_123071.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_123071", "123071086", "story_v_out_123071.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play123071087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 123071087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play123071088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1015ui_story"]) and arg_360_1.var_.characterEffect1015ui_story == nil then
				arg_360_1.var_.characterEffect1015ui_story = arg_360_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1015ui_story"]) then
				if arg_360_1.var_.characterEffect1015ui_story and not isNil(arg_360_1.actors_["1015ui_story"]) then
					arg_360_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1015ui_story"]) and arg_360_1.var_.characterEffect1015ui_story then
				arg_360_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.3

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(123071087).content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 12 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 12)

				if (12 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 12)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_6 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_6 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_6

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_6 and arg_360_1.time_ < var_363_1 + var_363_6 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play123071088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 123071088
		arg_364_1.duration_ = 8.4

		local var_364_0 = {
			zh = 6.133,
			ja = 8.4
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play123071089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1015ui_story = arg_364_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).z)
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles = arg_364_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1015ui_story"].transform.position).z)
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1015ui_story"].transform.localEulerAngles = arg_364_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_367_1 = arg_364_1.actors_["1015ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_1) and arg_364_1.var_.characterEffect1015ui_story == nil then
				arg_364_1.var_.characterEffect1015ui_story = var_367_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_2 and not isNil(var_367_1) then
				if arg_364_1.var_.characterEffect1015ui_story and not isNil(var_367_1) then
					arg_364_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_2)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_2 and arg_364_1.time_ < 0 + var_367_2 + arg_367_0 and not isNil(var_367_1) and arg_364_1.var_.characterEffect1015ui_story then
				arg_364_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_367_3 = arg_364_1.actors_["1093ui_story"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1093ui_story = var_367_3.localPosition
			end

			local var_367_4 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				var_367_3.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_364_1.time_ - 0) / var_367_4)
				var_367_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_3.position).x, (manager.ui.mainCamera.transform.position - var_367_3.position).y, (manager.ui.mainCamera.transform.position - var_367_3.position).z)
				var_367_3.localEulerAngles.z = 0
				var_367_3.localEulerAngles.x = 0
				var_367_3.localEulerAngles = var_367_3.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				var_367_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_367_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_3.position).x, (manager.ui.mainCamera.transform.position - var_367_3.position).y, (manager.ui.mainCamera.transform.position - var_367_3.position).z)
				var_367_3.localEulerAngles.z = 0
				var_367_3.localEulerAngles.x = 0
				var_367_3.localEulerAngles = var_367_3.localEulerAngles
			end

			local var_367_5 = arg_364_1.actors_["1093ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.characterEffect1093ui_story == nil then
				arg_364_1.var_.characterEffect1093ui_story = var_367_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_6 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_6 and not isNil(var_367_5) then
				if arg_364_1.var_.characterEffect1093ui_story and not isNil(var_367_5) then
					arg_364_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_364_1.time_ >= 0 + var_367_6 and arg_364_1.time_ < 0 + var_367_6 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.characterEffect1093ui_story then
				arg_364_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_367_8 = 0
			local var_367_9 = 0.65

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_10 = arg_364_1:GetWordFromCfg(123071088)
				local var_367_11 = arg_364_1:FormatText(var_367_10.content)

				arg_364_1.text_.text = var_367_11

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_13 = 26 <= 0 and var_367_9 or var_367_9 * (utf8.len(var_367_11) / 26)

				if (26 <= 0 and var_367_9 or var_367_9 * (utf8.len(var_367_11) / 26)) > 0 and var_367_9 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_8
					end
				end

				arg_364_1.text_.text = var_367_11
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071088", "story_v_out_123071.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071088", "story_v_out_123071.awb") / 1000

					if var_367_14 + var_367_8 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_8
					end

					if var_367_10.prefab_name ~= "" and arg_364_1.actors_[var_367_10.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_10.prefab_name].transform, "story_v_out_123071", "123071088", "story_v_out_123071.awb")

						arg_364_1:RecordAudio("123071088", var_367_15)
						arg_364_1:RecordAudio("123071088", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_123071", "123071088", "story_v_out_123071.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_123071", "123071088", "story_v_out_123071.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_9, arg_364_1.talkMaxDuration)

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_8) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_8 + var_367_16 and arg_364_1.time_ < var_367_8 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play123071089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 123071089
		arg_368_1.duration_ = 13.27

		local var_368_0 = {
			zh = 9.466,
			ja = 13.266
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play123071090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1015ui_story = arg_368_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).z)
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles = arg_368_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_368_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1015ui_story"].transform.position).z)
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1015ui_story"].transform.localEulerAngles = arg_368_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["1015ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1015ui_story == nil then
				arg_368_1.var_.characterEffect1015ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect1015ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1015ui_story then
				arg_368_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_4 = arg_368_1.actors_["1093ui_story"].transform

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1093ui_story = var_371_4.localPosition
			end

			local var_371_5 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_5 then
				var_371_4.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_368_1.time_ - 0) / var_371_5)
				var_371_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_4.position).x, (manager.ui.mainCamera.transform.position - var_371_4.position).y, (manager.ui.mainCamera.transform.position - var_371_4.position).z)
				var_371_4.localEulerAngles.z = 0
				var_371_4.localEulerAngles.x = 0
				var_371_4.localEulerAngles = var_371_4.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_5 and arg_368_1.time_ < 0 + var_371_5 + arg_371_0 then
				var_371_4.localPosition = Vector3.New(0, 100, 0)
				var_371_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_4.position).x, (manager.ui.mainCamera.transform.position - var_371_4.position).y, (manager.ui.mainCamera.transform.position - var_371_4.position).z)
				var_371_4.localEulerAngles.z = 0
				var_371_4.localEulerAngles.x = 0
				var_371_4.localEulerAngles = var_371_4.localEulerAngles
			end

			local var_371_6 = arg_368_1.actors_["1093ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_6) and arg_368_1.var_.characterEffect1093ui_story == nil then
				arg_368_1.var_.characterEffect1093ui_story = var_371_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_7 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 and not isNil(var_371_6) then
				if arg_368_1.var_.characterEffect1093ui_story and not isNil(var_371_6) then
					arg_368_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_368_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_7)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 and not isNil(var_371_6) and arg_368_1.var_.characterEffect1093ui_story then
				arg_368_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_368_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_371_8 = 0
			local var_371_9 = 1.075

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_10 = arg_368_1:GetWordFromCfg(123071089)
				local var_371_11 = arg_368_1:FormatText(var_371_10.content)

				arg_368_1.text_.text = var_371_11

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_13 = 43 <= 0 and var_371_9 or var_371_9 * (utf8.len(var_371_11) / 43)

				if (43 <= 0 and var_371_9 or var_371_9 * (utf8.len(var_371_11) / 43)) > 0 and var_371_9 < var_371_13 then
					arg_368_1.talkMaxDuration = var_371_13

					if var_371_13 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_13 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_11
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071089", "story_v_out_123071.awb") ~= 0 then
					local var_371_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071089", "story_v_out_123071.awb") / 1000

					if var_371_14 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_8
					end

					if var_371_10.prefab_name ~= "" and arg_368_1.actors_[var_371_10.prefab_name] ~= nil then
						local var_371_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_10.prefab_name].transform, "story_v_out_123071", "123071089", "story_v_out_123071.awb")

						arg_368_1:RecordAudio("123071089", var_371_15)
						arg_368_1:RecordAudio("123071089", var_371_15)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_123071", "123071089", "story_v_out_123071.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_123071", "123071089", "story_v_out_123071.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_16 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_16 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_16

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_16 and arg_368_1.time_ < var_371_8 + var_371_16 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play123071090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 123071090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play123071091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1015ui_story"]) and arg_372_1.var_.characterEffect1015ui_story == nil then
				arg_372_1.var_.characterEffect1015ui_story = arg_372_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1015ui_story"]) then
				if arg_372_1.var_.characterEffect1015ui_story and not isNil(arg_372_1.actors_["1015ui_story"]) then
					arg_372_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1015ui_story"]) and arg_372_1.var_.characterEffect1015ui_story then
				arg_372_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.9

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(123071090).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 36 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 36)

				if (36 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 36)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play123071091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 123071091
		arg_376_1.duration_ = 3.87

		local var_376_0 = {
			zh = 3.866,
			ja = 3.3
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play123071092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1050ui_story = arg_376_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).z)
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles = arg_376_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_376_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["1050ui_story"].transform.position).z)
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["1050ui_story"].transform.localEulerAngles = arg_376_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_379_1 = arg_376_1.actors_["1050ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1050ui_story == nil then
				arg_376_1.var_.characterEffect1050ui_story = var_379_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_2 and not isNil(var_379_1) then
				if arg_376_1.var_.characterEffect1050ui_story and not isNil(var_379_1) then
					arg_376_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_2 and arg_376_1.time_ < 0 + var_379_2 + arg_379_0 and not isNil(var_379_1) and arg_376_1.var_.characterEffect1050ui_story then
				arg_376_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_379_4 = arg_376_1.actors_["1015ui_story"].transform

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1015ui_story = var_379_4.localPosition
			end

			local var_379_5 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_5 then
				var_379_4.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_376_1.time_ - 0) / var_379_5)
				var_379_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_379_4.position).x, (manager.ui.mainCamera.transform.position - var_379_4.position).y, (manager.ui.mainCamera.transform.position - var_379_4.position).z)
				var_379_4.localEulerAngles.z = 0
				var_379_4.localEulerAngles.x = 0
				var_379_4.localEulerAngles = var_379_4.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_5 and arg_376_1.time_ < 0 + var_379_5 + arg_379_0 then
				var_379_4.localPosition = Vector3.New(0, 100, 0)
				var_379_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_379_4.position).x, (manager.ui.mainCamera.transform.position - var_379_4.position).y, (manager.ui.mainCamera.transform.position - var_379_4.position).z)
				var_379_4.localEulerAngles.z = 0
				var_379_4.localEulerAngles.x = 0
				var_379_4.localEulerAngles = var_379_4.localEulerAngles
			end

			local var_379_6 = arg_376_1.actors_["1015ui_story"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_6) and arg_376_1.var_.characterEffect1015ui_story == nil then
				arg_376_1.var_.characterEffect1015ui_story = var_379_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_7 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 and not isNil(var_379_6) then
				if arg_376_1.var_.characterEffect1015ui_story and not isNil(var_379_6) then
					arg_376_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_376_1.time_ - 0) / var_379_7)
				end
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 and not isNil(var_379_6) and arg_376_1.var_.characterEffect1015ui_story then
				arg_376_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_379_8 = 0
			local var_379_9 = 0.375

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_8 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_10 = arg_376_1:GetWordFromCfg(123071091)
				local var_379_11 = arg_376_1:FormatText(var_379_10.content)

				arg_376_1.text_.text = var_379_11

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_13 = 15 <= 0 and var_379_9 or var_379_9 * (utf8.len(var_379_11) / 15)

				if (15 <= 0 and var_379_9 or var_379_9 * (utf8.len(var_379_11) / 15)) > 0 and var_379_9 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_8 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_8
					end
				end

				arg_376_1.text_.text = var_379_11
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071091", "story_v_out_123071.awb") ~= 0 then
					local var_379_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071091", "story_v_out_123071.awb") / 1000

					if var_379_14 + var_379_8 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_8
					end

					if var_379_10.prefab_name ~= "" and arg_376_1.actors_[var_379_10.prefab_name] ~= nil then
						local var_379_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_10.prefab_name].transform, "story_v_out_123071", "123071091", "story_v_out_123071.awb")

						arg_376_1:RecordAudio("123071091", var_379_15)
						arg_376_1:RecordAudio("123071091", var_379_15)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_123071", "123071091", "story_v_out_123071.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_123071", "123071091", "story_v_out_123071.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_16 = math.max(var_379_9, arg_376_1.talkMaxDuration)

			if var_379_8 <= arg_376_1.time_ and arg_376_1.time_ < var_379_8 + var_379_16 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_8) / var_379_16

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_8 + var_379_16 and arg_376_1.time_ < var_379_8 + var_379_16 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play123071092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 123071092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play123071093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1050ui_story"]) and arg_380_1.var_.characterEffect1050ui_story == nil then
				arg_380_1.var_.characterEffect1050ui_story = arg_380_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1050ui_story"]) then
				if arg_380_1.var_.characterEffect1050ui_story and not isNil(arg_380_1.actors_["1050ui_story"]) then
					arg_380_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1050ui_story"]) and arg_380_1.var_.characterEffect1050ui_story then
				arg_380_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.4

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(123071092).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 16 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 16)

				if (16 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 16)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play123071093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 123071093
		arg_384_1.duration_ = 8.73

		local var_384_0 = {
			zh = 8.733,
			ja = 7.2
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play123071094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1015ui_story = arg_384_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).z)
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles = arg_384_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_384_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1015ui_story"].transform.position).z)
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1015ui_story"].transform.localEulerAngles = arg_384_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_387_1 = arg_384_1.actors_["1015ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1015ui_story == nil then
				arg_384_1.var_.characterEffect1015ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect1015ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1015ui_story then
				arg_384_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_387_4 = arg_384_1.actors_["1050ui_story"].transform

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1050ui_story = var_387_4.localPosition
			end

			local var_387_5 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_5 then
				var_387_4.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_384_1.time_ - 0) / var_387_5)
				var_387_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_387_4.position).x, (manager.ui.mainCamera.transform.position - var_387_4.position).y, (manager.ui.mainCamera.transform.position - var_387_4.position).z)
				var_387_4.localEulerAngles.z = 0
				var_387_4.localEulerAngles.x = 0
				var_387_4.localEulerAngles = var_387_4.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_5 and arg_384_1.time_ < 0 + var_387_5 + arg_387_0 then
				var_387_4.localPosition = Vector3.New(0, 100, 0)
				var_387_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_387_4.position).x, (manager.ui.mainCamera.transform.position - var_387_4.position).y, (manager.ui.mainCamera.transform.position - var_387_4.position).z)
				var_387_4.localEulerAngles.z = 0
				var_387_4.localEulerAngles.x = 0
				var_387_4.localEulerAngles = var_387_4.localEulerAngles
			end

			local var_387_6 = arg_384_1.actors_["1050ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect1050ui_story == nil then
				arg_384_1.var_.characterEffect1050ui_story = var_387_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_7 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 and not isNil(var_387_6) then
				if arg_384_1.var_.characterEffect1050ui_story and not isNil(var_387_6) then
					arg_384_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_7)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 and not isNil(var_387_6) and arg_384_1.var_.characterEffect1050ui_story then
				arg_384_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_387_8 = 0
			local var_387_9 = 1.1

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_8 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_10 = arg_384_1:GetWordFromCfg(123071093)
				local var_387_11 = arg_384_1:FormatText(var_387_10.content)

				arg_384_1.text_.text = var_387_11

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_13 = 44 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 44)

				if (44 <= 0 and var_387_9 or var_387_9 * (utf8.len(var_387_11) / 44)) > 0 and var_387_9 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_8
					end
				end

				arg_384_1.text_.text = var_387_11
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071093", "story_v_out_123071.awb") ~= 0 then
					local var_387_14 = manager.audio:GetVoiceLength("story_v_out_123071", "123071093", "story_v_out_123071.awb") / 1000

					if var_387_14 + var_387_8 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_14 + var_387_8
					end

					if var_387_10.prefab_name ~= "" and arg_384_1.actors_[var_387_10.prefab_name] ~= nil then
						local var_387_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_10.prefab_name].transform, "story_v_out_123071", "123071093", "story_v_out_123071.awb")

						arg_384_1:RecordAudio("123071093", var_387_15)
						arg_384_1:RecordAudio("123071093", var_387_15)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_123071", "123071093", "story_v_out_123071.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_123071", "123071093", "story_v_out_123071.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_16 = math.max(var_387_9, arg_384_1.talkMaxDuration)

			if var_387_8 <= arg_384_1.time_ and arg_384_1.time_ < var_387_8 + var_387_16 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_8) / var_387_16

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_8 + var_387_16 and arg_384_1.time_ < var_387_8 + var_387_16 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play123071094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 123071094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play123071095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1015ui_story"]) and arg_388_1.var_.characterEffect1015ui_story == nil then
				arg_388_1.var_.characterEffect1015ui_story = arg_388_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1015ui_story"]) then
				if arg_388_1.var_.characterEffect1015ui_story and not isNil(arg_388_1.actors_["1015ui_story"]) then
					arg_388_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1015ui_story"]) and arg_388_1.var_.characterEffect1015ui_story then
				arg_388_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_391_1 = 0
			local var_391_2 = 0.425

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(123071094).content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_5 = 17 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 17)

				if (17 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_3) / 17)) > 0 and var_391_2 < var_391_5 then
					arg_388_1.talkMaxDuration = var_391_5

					if var_391_5 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_6 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_6 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_6

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_6 and arg_388_1.time_ < var_391_1 + var_391_6 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play123071095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 123071095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play123071096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.25

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(123071095).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 10 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 10)

				if (10 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 10)) > 0 and var_395_0 < var_395_3 then
					arg_392_1.talkMaxDuration = var_395_3

					if var_395_3 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_3 + 0
					end
				end

				arg_392_1.text_.text = var_395_1
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_4 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_4

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play123071096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 123071096
		arg_396_1.duration_ = 7.07

		local var_396_0 = {
			zh = 4.766,
			ja = 7.066
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play123071097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1015ui_story"]) and arg_396_1.var_.characterEffect1015ui_story == nil then
				arg_396_1.var_.characterEffect1015ui_story = arg_396_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1015ui_story"]) then
				if arg_396_1.var_.characterEffect1015ui_story and not isNil(arg_396_1.actors_["1015ui_story"]) then
					arg_396_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1015ui_story"]) and arg_396_1.var_.characterEffect1015ui_story then
				arg_396_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_399_2 = 0
			local var_399_3 = 0.625

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_2 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_4 = arg_396_1:GetWordFromCfg(123071096)
				local var_399_5 = arg_396_1:FormatText(var_399_4.content)

				arg_396_1.text_.text = var_399_5

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_7 = 25 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 25)

				if (25 <= 0 and var_399_3 or var_399_3 * (utf8.len(var_399_5) / 25)) > 0 and var_399_3 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_2
					end
				end

				arg_396_1.text_.text = var_399_5
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071096", "story_v_out_123071.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071096", "story_v_out_123071.awb") / 1000

					if var_399_8 + var_399_2 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_2
					end

					if var_399_4.prefab_name ~= "" and arg_396_1.actors_[var_399_4.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_4.prefab_name].transform, "story_v_out_123071", "123071096", "story_v_out_123071.awb")

						arg_396_1:RecordAudio("123071096", var_399_9)
						arg_396_1:RecordAudio("123071096", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_123071", "123071096", "story_v_out_123071.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_123071", "123071096", "story_v_out_123071.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_10 = math.max(var_399_3, arg_396_1.talkMaxDuration)

			if var_399_2 <= arg_396_1.time_ and arg_396_1.time_ < var_399_2 + var_399_10 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_2) / var_399_10

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_2 + var_399_10 and arg_396_1.time_ < var_399_2 + var_399_10 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play123071097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 123071097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play123071098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1015ui_story"]) and arg_400_1.var_.characterEffect1015ui_story == nil then
				arg_400_1.var_.characterEffect1015ui_story = arg_400_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1015ui_story"]) then
				if arg_400_1.var_.characterEffect1015ui_story and not isNil(arg_400_1.actors_["1015ui_story"]) then
					arg_400_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_400_1.time_ - 0) / var_403_0)
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1015ui_story"]) and arg_400_1.var_.characterEffect1015ui_story then
				arg_400_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_403_1 = 0
			local var_403_2 = 1.15

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_3 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(123071097).content)

				arg_400_1.text_.text = var_403_3

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_5 = 46 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 46)

				if (46 <= 0 and var_403_2 or var_403_2 * (utf8.len(var_403_3) / 46)) > 0 and var_403_2 < var_403_5 then
					arg_400_1.talkMaxDuration = var_403_5

					if var_403_5 + var_403_1 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + var_403_1
					end
				end

				arg_400_1.text_.text = var_403_3
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_6 = math.max(var_403_2, arg_400_1.talkMaxDuration)

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_6 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_1) / var_403_6

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_1 + var_403_6 and arg_400_1.time_ < var_403_1 + var_403_6 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play123071098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 123071098
		arg_404_1.duration_ = 9.9

		local var_404_0 = {
			zh = 6.033,
			ja = 9.9
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play123071099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1015ui_story"]) and arg_404_1.var_.characterEffect1015ui_story == nil then
				arg_404_1.var_.characterEffect1015ui_story = arg_404_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1015ui_story"]) then
				if arg_404_1.var_.characterEffect1015ui_story and not isNil(arg_404_1.actors_["1015ui_story"]) then
					arg_404_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1015ui_story"]) and arg_404_1.var_.characterEffect1015ui_story then
				arg_404_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_407_2 = 0
			local var_407_3 = 0.825

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_4 = arg_404_1:GetWordFromCfg(123071098)
				local var_407_5 = arg_404_1:FormatText(var_407_4.content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 33 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 33)

				if (33 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 33)) > 0 and var_407_3 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071098", "story_v_out_123071.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071098", "story_v_out_123071.awb") / 1000

					if var_407_8 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_2
					end

					if var_407_4.prefab_name ~= "" and arg_404_1.actors_[var_407_4.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_4.prefab_name].transform, "story_v_out_123071", "123071098", "story_v_out_123071.awb")

						arg_404_1:RecordAudio("123071098", var_407_9)
						arg_404_1:RecordAudio("123071098", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_123071", "123071098", "story_v_out_123071.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_123071", "123071098", "story_v_out_123071.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_10 and arg_404_1.time_ < var_407_2 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play123071099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 123071099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play123071100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1015ui_story"]) and arg_408_1.var_.characterEffect1015ui_story == nil then
				arg_408_1.var_.characterEffect1015ui_story = arg_408_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1015ui_story"]) then
				if arg_408_1.var_.characterEffect1015ui_story and not isNil(arg_408_1.actors_["1015ui_story"]) then
					arg_408_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1015ui_story"]) and arg_408_1.var_.characterEffect1015ui_story then
				arg_408_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_411_1 = 0
			local var_411_2 = 0.225

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(123071099).content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 9 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 9)

				if (9 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 9)) > 0 and var_411_2 < var_411_5 then
					arg_408_1.talkMaxDuration = var_411_5

					if var_411_5 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_6 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_6 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_6

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_6 and arg_408_1.time_ < var_411_1 + var_411_6 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play123071100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 123071100
		arg_412_1.duration_ = 11.63

		local var_412_0 = {
			zh = 11.633,
			ja = 10.833
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play123071101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["1015ui_story"]) and arg_412_1.var_.characterEffect1015ui_story == nil then
				arg_412_1.var_.characterEffect1015ui_story = arg_412_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_0 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["1015ui_story"]) then
				if arg_412_1.var_.characterEffect1015ui_story and not isNil(arg_412_1.actors_["1015ui_story"]) then
					arg_412_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["1015ui_story"]) and arg_412_1.var_.characterEffect1015ui_story then
				arg_412_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_415_2 = 0
			local var_415_3 = 1.375

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_2 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_4 = arg_412_1:GetWordFromCfg(123071100)
				local var_415_5 = arg_412_1:FormatText(var_415_4.content)

				arg_412_1.text_.text = var_415_5

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_7 = 55 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 55)

				if (55 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 55)) > 0 and var_415_3 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_2
					end
				end

				arg_412_1.text_.text = var_415_5
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071100", "story_v_out_123071.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071100", "story_v_out_123071.awb") / 1000

					if var_415_8 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_2
					end

					if var_415_4.prefab_name ~= "" and arg_412_1.actors_[var_415_4.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_4.prefab_name].transform, "story_v_out_123071", "123071100", "story_v_out_123071.awb")

						arg_412_1:RecordAudio("123071100", var_415_9)
						arg_412_1:RecordAudio("123071100", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_123071", "123071100", "story_v_out_123071.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_123071", "123071100", "story_v_out_123071.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_3, arg_412_1.talkMaxDuration)

			if var_415_2 <= arg_412_1.time_ and arg_412_1.time_ < var_415_2 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_2) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_2 + var_415_10 and arg_412_1.time_ < var_415_2 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play123071101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 123071101
		arg_416_1.duration_ = 12.9

		local var_416_0 = {
			zh = 12.9,
			ja = 10.166
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play123071102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 1.525

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:GetWordFromCfg(123071101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 61 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 61)

				if (61 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 61)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071101", "story_v_out_123071.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071101", "story_v_out_123071.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_123071", "123071101", "story_v_out_123071.awb")

						arg_416_1:RecordAudio("123071101", var_419_6)
						arg_416_1:RecordAudio("123071101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_123071", "123071101", "story_v_out_123071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_123071", "123071101", "story_v_out_123071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play123071102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 123071102
		arg_420_1.duration_ = 3.77

		local var_420_0 = {
			zh = 3.566,
			ja = 3.766
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play123071103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.475

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_1 = arg_420_1:GetWordFromCfg(123071102)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 19 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 19)

				if (19 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 19)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071102", "story_v_out_123071.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071102", "story_v_out_123071.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_123071", "123071102", "story_v_out_123071.awb")

						arg_420_1:RecordAudio("123071102", var_423_6)
						arg_420_1:RecordAudio("123071102", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_123071", "123071102", "story_v_out_123071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_123071", "123071102", "story_v_out_123071.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play123071103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 123071103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play123071104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1015ui_story"]) and arg_424_1.var_.characterEffect1015ui_story == nil then
				arg_424_1.var_.characterEffect1015ui_story = arg_424_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1015ui_story"]) then
				if arg_424_1.var_.characterEffect1015ui_story and not isNil(arg_424_1.actors_["1015ui_story"]) then
					arg_424_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_0)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1015ui_story"]) and arg_424_1.var_.characterEffect1015ui_story then
				arg_424_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_427_1 = 0
			local var_427_2 = 0.25

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(123071103).content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 10 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 10)

				if (10 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 10)) > 0 and var_427_2 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_6 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_6 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_6

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_6 and arg_424_1.time_ < var_427_1 + var_427_6 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play123071104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 123071104
		arg_428_1.duration_ = 3.1

		local var_428_0 = {
			zh = 3.1,
			ja = 2.766
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play123071105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1015ui_story"]) and arg_428_1.var_.characterEffect1015ui_story == nil then
				arg_428_1.var_.characterEffect1015ui_story = arg_428_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1015ui_story"]) then
				if arg_428_1.var_.characterEffect1015ui_story and not isNil(arg_428_1.actors_["1015ui_story"]) then
					arg_428_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1015ui_story"]) and arg_428_1.var_.characterEffect1015ui_story then
				arg_428_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_431_2 = 0
			local var_431_3 = 0.45

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_2 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_4 = arg_428_1:GetWordFromCfg(123071104)
				local var_431_5 = arg_428_1:FormatText(var_431_4.content)

				arg_428_1.text_.text = var_431_5

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 18 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 18)

				if (18 <= 0 and var_431_3 or var_431_3 * (utf8.len(var_431_5) / 18)) > 0 and var_431_3 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_2
					end
				end

				arg_428_1.text_.text = var_431_5
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071104", "story_v_out_123071.awb") ~= 0 then
					local var_431_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071104", "story_v_out_123071.awb") / 1000

					if var_431_8 + var_431_2 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_8 + var_431_2
					end

					if var_431_4.prefab_name ~= "" and arg_428_1.actors_[var_431_4.prefab_name] ~= nil then
						local var_431_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_4.prefab_name].transform, "story_v_out_123071", "123071104", "story_v_out_123071.awb")

						arg_428_1:RecordAudio("123071104", var_431_9)
						arg_428_1:RecordAudio("123071104", var_431_9)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_123071", "123071104", "story_v_out_123071.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_123071", "123071104", "story_v_out_123071.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_10 = math.max(var_431_3, arg_428_1.talkMaxDuration)

			if var_431_2 <= arg_428_1.time_ and arg_428_1.time_ < var_431_2 + var_431_10 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_2) / var_431_10

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_2 + var_431_10 and arg_428_1.time_ < var_431_2 + var_431_10 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play123071105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 123071105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play123071106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1015ui_story"]) and arg_432_1.var_.characterEffect1015ui_story == nil then
				arg_432_1.var_.characterEffect1015ui_story = arg_432_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1015ui_story"]) then
				if arg_432_1.var_.characterEffect1015ui_story and not isNil(arg_432_1.actors_["1015ui_story"]) then
					arg_432_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1015ui_story"]) and arg_432_1.var_.characterEffect1015ui_story then
				arg_432_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_435_1 = 0
			local var_435_2 = 0.15

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(123071105).content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 6 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 6)

				if (6 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 6)) > 0 and var_435_2 < var_435_5 then
					arg_432_1.talkMaxDuration = var_435_5

					if var_435_5 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_6 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_6 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_6

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_6 and arg_432_1.time_ < var_435_1 + var_435_6 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play123071106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 123071106
		arg_436_1.duration_ = 10.77

		local var_436_0 = {
			zh = 10.766,
			ja = 9.7
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
				arg_436_0:Play123071107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["1015ui_story"]) and arg_436_1.var_.characterEffect1015ui_story == nil then
				arg_436_1.var_.characterEffect1015ui_story = arg_436_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["1015ui_story"]) then
				if arg_436_1.var_.characterEffect1015ui_story and not isNil(arg_436_1.actors_["1015ui_story"]) then
					arg_436_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["1015ui_story"]) and arg_436_1.var_.characterEffect1015ui_story then
				arg_436_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_2")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_439_2 = 0
			local var_439_3 = 1.075

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_2 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_4 = arg_436_1:GetWordFromCfg(123071106)
				local var_439_5 = arg_436_1:FormatText(var_439_4.content)

				arg_436_1.text_.text = var_439_5

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_7 = 43 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 43)

				if (43 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_5) / 43)) > 0 and var_439_3 < var_439_7 then
					arg_436_1.talkMaxDuration = var_439_7

					if var_439_7 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_7 + var_439_2
					end
				end

				arg_436_1.text_.text = var_439_5
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071106", "story_v_out_123071.awb") ~= 0 then
					local var_439_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071106", "story_v_out_123071.awb") / 1000

					if var_439_8 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_8 + var_439_2
					end

					if var_439_4.prefab_name ~= "" and arg_436_1.actors_[var_439_4.prefab_name] ~= nil then
						local var_439_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_4.prefab_name].transform, "story_v_out_123071", "123071106", "story_v_out_123071.awb")

						arg_436_1:RecordAudio("123071106", var_439_9)
						arg_436_1:RecordAudio("123071106", var_439_9)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_123071", "123071106", "story_v_out_123071.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_123071", "123071106", "story_v_out_123071.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_3, arg_436_1.talkMaxDuration)

			if var_439_2 <= arg_436_1.time_ and arg_436_1.time_ < var_439_2 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_2) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_2 + var_439_10 and arg_436_1.time_ < var_439_2 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play123071107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 123071107
		arg_440_1.duration_ = 10.53

		local var_440_0 = {
			zh = 10.2,
			ja = 10.533
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
				arg_440_0:Play123071108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 1.275

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_1 = arg_440_1:GetWordFromCfg(123071107)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 51 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 51)

				if (51 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 51)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071107", "story_v_out_123071.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071107", "story_v_out_123071.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_123071", "123071107", "story_v_out_123071.awb")

						arg_440_1:RecordAudio("123071107", var_443_6)
						arg_440_1:RecordAudio("123071107", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_123071", "123071107", "story_v_out_123071.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_123071", "123071107", "story_v_out_123071.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play123071108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 123071108
		arg_444_1.duration_ = 7.87

		local var_444_0 = {
			zh = 6.033,
			ja = 7.866
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play123071109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_447_0 = 0
			local var_447_1 = 0.725

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_2 = arg_444_1:GetWordFromCfg(123071108)
				local var_447_3 = arg_444_1:FormatText(var_447_2.content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 29 <= 0 and var_447_1 or var_447_1 * (utf8.len(var_447_3) / 29)

				if (29 <= 0 and var_447_1 or var_447_1 * (utf8.len(var_447_3) / 29)) > 0 and var_447_1 < var_447_5 then
					arg_444_1.talkMaxDuration = var_447_5

					if var_447_5 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071108", "story_v_out_123071.awb") ~= 0 then
					local var_447_6 = manager.audio:GetVoiceLength("story_v_out_123071", "123071108", "story_v_out_123071.awb") / 1000

					if var_447_6 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_0
					end

					if var_447_2.prefab_name ~= "" and arg_444_1.actors_[var_447_2.prefab_name] ~= nil then
						local var_447_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_2.prefab_name].transform, "story_v_out_123071", "123071108", "story_v_out_123071.awb")

						arg_444_1:RecordAudio("123071108", var_447_7)
						arg_444_1:RecordAudio("123071108", var_447_7)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_123071", "123071108", "story_v_out_123071.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_123071", "123071108", "story_v_out_123071.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_8 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_8 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_8

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_8 and arg_444_1.time_ < var_447_0 + var_447_8 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play123071109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 123071109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play123071110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["1015ui_story"]) and arg_448_1.var_.characterEffect1015ui_story == nil then
				arg_448_1.var_.characterEffect1015ui_story = arg_448_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["1015ui_story"]) then
				if arg_448_1.var_.characterEffect1015ui_story and not isNil(arg_448_1.actors_["1015ui_story"]) then
					arg_448_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_448_1.time_ - 0) / var_451_0)
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["1015ui_story"]) and arg_448_1.var_.characterEffect1015ui_story then
				arg_448_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_451_1 = 0
			local var_451_2 = 0.5

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_3 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(123071109).content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 20 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 20)

				if (20 <= 0 and var_451_2 or var_451_2 * (utf8.len(var_451_3) / 20)) > 0 and var_451_2 < var_451_5 then
					arg_448_1.talkMaxDuration = var_451_5

					if var_451_5 + var_451_1 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + var_451_1
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_6 = math.max(var_451_2, arg_448_1.talkMaxDuration)

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_6 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_1) / var_451_6

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_1 + var_451_6 and arg_448_1.time_ < var_451_1 + var_451_6 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play123071110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 123071110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play123071111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.225

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_1 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(123071110).content)

				arg_452_1.text_.text = var_455_1

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_3 = 9 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 9)

				if (9 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 9)) > 0 and var_455_0 < var_455_3 then
					arg_452_1.talkMaxDuration = var_455_3

					if var_455_3 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_3 + 0
					end
				end

				arg_452_1.text_.text = var_455_1
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_4 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_4

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play123071111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 123071111
		arg_456_1.duration_ = 7.13

		local var_456_0 = {
			zh = 2.4,
			ja = 7.133
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
				arg_456_0:Play123071112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["1015ui_story"]) and arg_456_1.var_.characterEffect1015ui_story == nil then
				arg_456_1.var_.characterEffect1015ui_story = arg_456_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_0 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["1015ui_story"]) then
				if arg_456_1.var_.characterEffect1015ui_story and not isNil(arg_456_1.actors_["1015ui_story"]) then
					arg_456_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["1015ui_story"]) and arg_456_1.var_.characterEffect1015ui_story then
				arg_456_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_459_2 = 0
			local var_459_3 = 0.275

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_2 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_4 = arg_456_1:GetWordFromCfg(123071111)
				local var_459_5 = arg_456_1:FormatText(var_459_4.content)

				arg_456_1.text_.text = var_459_5

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_7 = 11 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 11)

				if (11 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 11)) > 0 and var_459_3 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_2
					end
				end

				arg_456_1.text_.text = var_459_5
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071111", "story_v_out_123071.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071111", "story_v_out_123071.awb") / 1000

					if var_459_8 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_2
					end

					if var_459_4.prefab_name ~= "" and arg_456_1.actors_[var_459_4.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_4.prefab_name].transform, "story_v_out_123071", "123071111", "story_v_out_123071.awb")

						arg_456_1:RecordAudio("123071111", var_459_9)
						arg_456_1:RecordAudio("123071111", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_123071", "123071111", "story_v_out_123071.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_123071", "123071111", "story_v_out_123071.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_3, arg_456_1.talkMaxDuration)

			if var_459_2 <= arg_456_1.time_ and arg_456_1.time_ < var_459_2 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_2) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_2 + var_459_10 and arg_456_1.time_ < var_459_2 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play123071112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 123071112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play123071113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["1015ui_story"]) and arg_460_1.var_.characterEffect1015ui_story == nil then
				arg_460_1.var_.characterEffect1015ui_story = arg_460_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_0 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["1015ui_story"]) then
				if arg_460_1.var_.characterEffect1015ui_story and not isNil(arg_460_1.actors_["1015ui_story"]) then
					arg_460_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_460_1.time_ - 0) / var_463_0)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["1015ui_story"]) and arg_460_1.var_.characterEffect1015ui_story then
				arg_460_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_463_1 = 0
			local var_463_2 = 0.175

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

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(123071112).content)

				arg_460_1.text_.text = var_463_3

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 7 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 7)

				if (7 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 7)) > 0 and var_463_2 < var_463_5 then
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
	Play123071113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 123071113
		arg_464_1.duration_ = 6.13

		local var_464_0 = {
			zh = 4.633,
			ja = 6.133
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
				arg_464_0:Play123071114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1015ui_story"]) and arg_464_1.var_.characterEffect1015ui_story == nil then
				arg_464_1.var_.characterEffect1015ui_story = arg_464_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1015ui_story"]) then
				if arg_464_1.var_.characterEffect1015ui_story and not isNil(arg_464_1.actors_["1015ui_story"]) then
					arg_464_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1015ui_story"]) and arg_464_1.var_.characterEffect1015ui_story then
				arg_464_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_467_2 = 0
			local var_467_3 = 0.625

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_2 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_4 = arg_464_1:GetWordFromCfg(123071113)
				local var_467_5 = arg_464_1:FormatText(var_467_4.content)

				arg_464_1.text_.text = var_467_5

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_7 = 25 <= 0 and var_467_3 or var_467_3 * (utf8.len(var_467_5) / 25)

				if (25 <= 0 and var_467_3 or var_467_3 * (utf8.len(var_467_5) / 25)) > 0 and var_467_3 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_2 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_2
					end
				end

				arg_464_1.text_.text = var_467_5
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071113", "story_v_out_123071.awb") ~= 0 then
					local var_467_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071113", "story_v_out_123071.awb") / 1000

					if var_467_8 + var_467_2 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_8 + var_467_2
					end

					if var_467_4.prefab_name ~= "" and arg_464_1.actors_[var_467_4.prefab_name] ~= nil then
						local var_467_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_4.prefab_name].transform, "story_v_out_123071", "123071113", "story_v_out_123071.awb")

						arg_464_1:RecordAudio("123071113", var_467_9)
						arg_464_1:RecordAudio("123071113", var_467_9)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_123071", "123071113", "story_v_out_123071.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_123071", "123071113", "story_v_out_123071.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_10 = math.max(var_467_3, arg_464_1.talkMaxDuration)

			if var_467_2 <= arg_464_1.time_ and arg_464_1.time_ < var_467_2 + var_467_10 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_2) / var_467_10

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_2 + var_467_10 and arg_464_1.time_ < var_467_2 + var_467_10 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play123071114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 123071114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play123071115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1015ui_story"]) and arg_468_1.var_.characterEffect1015ui_story == nil then
				arg_468_1.var_.characterEffect1015ui_story = arg_468_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_0 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1015ui_story"]) then
				if arg_468_1.var_.characterEffect1015ui_story and not isNil(arg_468_1.actors_["1015ui_story"]) then
					arg_468_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_0)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1015ui_story"]) and arg_468_1.var_.characterEffect1015ui_story then
				arg_468_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_471_1 = 0
			local var_471_2 = 0.625

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_3 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(123071114).content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 25 <= 0 and var_471_2 or var_471_2 * (utf8.len(var_471_3) / 25)

				if (25 <= 0 and var_471_2 or var_471_2 * (utf8.len(var_471_3) / 25)) > 0 and var_471_2 < var_471_5 then
					arg_468_1.talkMaxDuration = var_471_5

					if var_471_5 + var_471_1 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + var_471_1
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_6 = math.max(var_471_2, arg_468_1.talkMaxDuration)

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_6 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_1) / var_471_6

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_1 + var_471_6 and arg_468_1.time_ < var_471_1 + var_471_6 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play123071115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 123071115
		arg_472_1.duration_ = 10.47

		local var_472_0 = {
			zh = 10.466,
			ja = 8.533
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play123071116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["1015ui_story"]) and arg_472_1.var_.characterEffect1015ui_story == nil then
				arg_472_1.var_.characterEffect1015ui_story = arg_472_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_0 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["1015ui_story"]) then
				if arg_472_1.var_.characterEffect1015ui_story and not isNil(arg_472_1.actors_["1015ui_story"]) then
					arg_472_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["1015ui_story"]) and arg_472_1.var_.characterEffect1015ui_story then
				arg_472_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_475_2 = 0
			local var_475_3 = 1.375

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_2 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_4 = arg_472_1:GetWordFromCfg(123071115)
				local var_475_5 = arg_472_1:FormatText(var_475_4.content)

				arg_472_1.text_.text = var_475_5

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_7 = 55 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 55)

				if (55 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 55)) > 0 and var_475_3 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_2
					end
				end

				arg_472_1.text_.text = var_475_5
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071115", "story_v_out_123071.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071115", "story_v_out_123071.awb") / 1000

					if var_475_8 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_2
					end

					if var_475_4.prefab_name ~= "" and arg_472_1.actors_[var_475_4.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_4.prefab_name].transform, "story_v_out_123071", "123071115", "story_v_out_123071.awb")

						arg_472_1:RecordAudio("123071115", var_475_9)
						arg_472_1:RecordAudio("123071115", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_123071", "123071115", "story_v_out_123071.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_123071", "123071115", "story_v_out_123071.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_3, arg_472_1.talkMaxDuration)

			if var_475_2 <= arg_472_1.time_ and arg_472_1.time_ < var_475_2 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_2) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_2 + var_475_10 and arg_472_1.time_ < var_475_2 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play123071116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 123071116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play123071117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1015ui_story"]) and arg_476_1.var_.characterEffect1015ui_story == nil then
				arg_476_1.var_.characterEffect1015ui_story = arg_476_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1015ui_story"]) then
				if arg_476_1.var_.characterEffect1015ui_story and not isNil(arg_476_1.actors_["1015ui_story"]) then
					arg_476_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1015ui_story"]) and arg_476_1.var_.characterEffect1015ui_story then
				arg_476_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_479_1 = 0
			local var_479_2 = 0.775

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(123071116).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 31 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 31)

				if (31 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 31)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play123071117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 123071117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play123071118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.375

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_1 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(123071117).content)

				arg_480_1.text_.text = var_483_1

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_3 = 15 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 15)

				if (15 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_1) / 15)) > 0 and var_483_0 < var_483_3 then
					arg_480_1.talkMaxDuration = var_483_3

					if var_483_3 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_3 + 0
					end
				end

				arg_480_1.text_.text = var_483_1
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_4 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_4

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play123071118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 123071118
		arg_484_1.duration_ = 3.33

		local var_484_0 = {
			zh = 1.999999999999,
			ja = 3.333
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play123071119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["1015ui_story"]) and arg_484_1.var_.characterEffect1015ui_story == nil then
				arg_484_1.var_.characterEffect1015ui_story = arg_484_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_0 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["1015ui_story"]) then
				if arg_484_1.var_.characterEffect1015ui_story and not isNil(arg_484_1.actors_["1015ui_story"]) then
					arg_484_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["1015ui_story"]) and arg_484_1.var_.characterEffect1015ui_story then
				arg_484_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_487_2 = 0
			local var_487_3 = 0.15

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_2 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_4 = arg_484_1:GetWordFromCfg(123071118)
				local var_487_5 = arg_484_1:FormatText(var_487_4.content)

				arg_484_1.text_.text = var_487_5

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_7 = 6 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_5) / 6)

				if (6 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_5) / 6)) > 0 and var_487_3 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_2 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_2
					end
				end

				arg_484_1.text_.text = var_487_5
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071118", "story_v_out_123071.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_123071", "123071118", "story_v_out_123071.awb") / 1000

					if var_487_8 + var_487_2 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_2
					end

					if var_487_4.prefab_name ~= "" and arg_484_1.actors_[var_487_4.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_4.prefab_name].transform, "story_v_out_123071", "123071118", "story_v_out_123071.awb")

						arg_484_1:RecordAudio("123071118", var_487_9)
						arg_484_1:RecordAudio("123071118", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_123071", "123071118", "story_v_out_123071.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_123071", "123071118", "story_v_out_123071.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_3, arg_484_1.talkMaxDuration)

			if var_487_2 <= arg_484_1.time_ and arg_484_1.time_ < var_487_2 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_2) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_2 + var_487_10 and arg_484_1.time_ < var_487_2 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play123071119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 123071119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play123071120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos1015ui_story = arg_488_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_491_0 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				arg_488_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).z)
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles = arg_488_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				arg_488_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_488_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1015ui_story"].transform.position).z)
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1015ui_story"].transform.localEulerAngles = arg_488_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_491_1 = arg_488_1.actors_["1015ui_story"]

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1015ui_story == nil then
				arg_488_1.var_.characterEffect1015ui_story = var_491_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_2 and not isNil(var_491_1) then
				if arg_488_1.var_.characterEffect1015ui_story and not isNil(var_491_1) then
					arg_488_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_2)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_2 and arg_488_1.time_ < 0 + var_491_2 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect1015ui_story then
				arg_488_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_491_3 = 0
			local var_491_4 = 1.075

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_3 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_5 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(123071119).content)

				arg_488_1.text_.text = var_491_5

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_7 = 43 <= 0 and var_491_4 or var_491_4 * (utf8.len(var_491_5) / 43)

				if (43 <= 0 and var_491_4 or var_491_4 * (utf8.len(var_491_5) / 43)) > 0 and var_491_4 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_3 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_3
					end
				end

				arg_488_1.text_.text = var_491_5
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_8 = math.max(var_491_4, arg_488_1.talkMaxDuration)

			if var_491_3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_3 + var_491_8 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_3) / var_491_8

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_3 + var_491_8 and arg_488_1.time_ < var_491_3 + var_491_8 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play123071120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 123071120
		arg_492_1.duration_ = 10.33

		local var_492_0 = {
			zh = 10.333,
			ja = 9.8
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
				arg_492_0:Play123071121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos1093ui_story = arg_492_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_495_0 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 then
				arg_492_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_492_1.time_ - 0) / var_495_0)
				arg_492_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).z)
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles = arg_492_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 then
				arg_492_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_492_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1093ui_story"].transform.position).z)
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1093ui_story"].transform.localEulerAngles = arg_492_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_495_1 = arg_492_1.actors_["1093ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect1093ui_story == nil then
				arg_492_1.var_.characterEffect1093ui_story = var_495_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_2 and not isNil(var_495_1) then
				if arg_492_1.var_.characterEffect1093ui_story and not isNil(var_495_1) then
					arg_492_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= 0 + var_495_2 and arg_492_1.time_ < 0 + var_495_2 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect1093ui_story then
				arg_492_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_495_4 = 0
			local var_495_5 = 1.175

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_4 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_6 = arg_492_1:GetWordFromCfg(123071120)
				local var_495_7 = arg_492_1:FormatText(var_495_6.content)

				arg_492_1.text_.text = var_495_7

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_9 = 47 <= 0 and var_495_5 or var_495_5 * (utf8.len(var_495_7) / 47)

				if (47 <= 0 and var_495_5 or var_495_5 * (utf8.len(var_495_7) / 47)) > 0 and var_495_5 < var_495_9 then
					arg_492_1.talkMaxDuration = var_495_9

					if var_495_9 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_9 + var_495_4
					end
				end

				arg_492_1.text_.text = var_495_7
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071120", "story_v_out_123071.awb") ~= 0 then
					local var_495_10 = manager.audio:GetVoiceLength("story_v_out_123071", "123071120", "story_v_out_123071.awb") / 1000

					if var_495_10 + var_495_4 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_10 + var_495_4
					end

					if var_495_6.prefab_name ~= "" and arg_492_1.actors_[var_495_6.prefab_name] ~= nil then
						local var_495_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_6.prefab_name].transform, "story_v_out_123071", "123071120", "story_v_out_123071.awb")

						arg_492_1:RecordAudio("123071120", var_495_11)
						arg_492_1:RecordAudio("123071120", var_495_11)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_123071", "123071120", "story_v_out_123071.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_123071", "123071120", "story_v_out_123071.awb")
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
				actorName = "1093ui_story",
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
	Play123071121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 123071121
		arg_496_1.duration_ = 5.6

		local var_496_0 = {
			zh = 5.6,
			ja = 3.766
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
				arg_496_0:Play123071122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.65

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_1 = arg_496_1:GetWordFromCfg(123071121)
				local var_499_2 = arg_496_1:FormatText(var_499_1.content)

				arg_496_1.text_.text = var_499_2

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 26 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 26)

				if (26 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 26)) > 0 and var_499_0 < var_499_4 then
					arg_496_1.talkMaxDuration = var_499_4

					if var_499_4 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_4 + 0
					end
				end

				arg_496_1.text_.text = var_499_2
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071121", "story_v_out_123071.awb") ~= 0 then
					local var_499_5 = manager.audio:GetVoiceLength("story_v_out_123071", "123071121", "story_v_out_123071.awb") / 1000

					if var_499_5 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_5 + 0
					end

					if var_499_1.prefab_name ~= "" and arg_496_1.actors_[var_499_1.prefab_name] ~= nil then
						local var_499_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_1.prefab_name].transform, "story_v_out_123071", "123071121", "story_v_out_123071.awb")

						arg_496_1:RecordAudio("123071121", var_499_6)
						arg_496_1:RecordAudio("123071121", var_499_6)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_123071", "123071121", "story_v_out_123071.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_123071", "123071121", "story_v_out_123071.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_7 and arg_496_1.time_ < 0 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play123071122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 123071122
		arg_500_1.duration_ = 3.5

		local var_500_0 = {
			zh = 3,
			ja = 3.5
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
				arg_500_0:Play123071123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.var_.moveOldPos1050ui_story = arg_500_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_503_0 = 0.001

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 then
				arg_500_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_500_1.time_ - 0) / var_503_0)
				arg_500_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).z)
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles = arg_500_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 then
				arg_500_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_500_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["1050ui_story"].transform.position).z)
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_500_1.actors_["1050ui_story"].transform.localEulerAngles = arg_500_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_503_1 = arg_500_1.actors_["1050ui_story"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect1050ui_story == nil then
				arg_500_1.var_.characterEffect1050ui_story = var_503_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_2 and not isNil(var_503_1) then
				if arg_500_1.var_.characterEffect1050ui_story and not isNil(var_503_1) then
					arg_500_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_500_1.time_ >= 0 + var_503_2 and arg_500_1.time_ < 0 + var_503_2 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect1050ui_story then
				arg_500_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_503_4 = arg_500_1.actors_["1093ui_story"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_4) and arg_500_1.var_.characterEffect1093ui_story == nil then
				arg_500_1.var_.characterEffect1093ui_story = var_503_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_5 = 0.200000002980232

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_5 and not isNil(var_503_4) then
				if arg_500_1.var_.characterEffect1093ui_story and not isNil(var_503_4) then
					arg_500_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_500_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_500_1.time_ - 0) / var_503_5)
				end
			end

			if arg_500_1.time_ >= 0 + var_503_5 and arg_500_1.time_ < 0 + var_503_5 + arg_503_0 and not isNil(var_503_4) and arg_500_1.var_.characterEffect1093ui_story then
				arg_500_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_500_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_503_6 = 0
			local var_503_7 = 0.4

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_6 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_8 = arg_500_1:GetWordFromCfg(123071122)
				local var_503_9 = arg_500_1:FormatText(var_503_8.content)

				arg_500_1.text_.text = var_503_9

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_11 = 16 <= 0 and var_503_7 or var_503_7 * (utf8.len(var_503_9) / 16)

				if (16 <= 0 and var_503_7 or var_503_7 * (utf8.len(var_503_9) / 16)) > 0 and var_503_7 < var_503_11 then
					arg_500_1.talkMaxDuration = var_503_11

					if var_503_11 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_11 + var_503_6
					end
				end

				arg_500_1.text_.text = var_503_9
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071122", "story_v_out_123071.awb") ~= 0 then
					local var_503_12 = manager.audio:GetVoiceLength("story_v_out_123071", "123071122", "story_v_out_123071.awb") / 1000

					if var_503_12 + var_503_6 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_12 + var_503_6
					end

					if var_503_8.prefab_name ~= "" and arg_500_1.actors_[var_503_8.prefab_name] ~= nil then
						local var_503_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_8.prefab_name].transform, "story_v_out_123071", "123071122", "story_v_out_123071.awb")

						arg_500_1:RecordAudio("123071122", var_503_13)
						arg_500_1:RecordAudio("123071122", var_503_13)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_123071", "123071122", "story_v_out_123071.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_123071", "123071122", "story_v_out_123071.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_14 = math.max(var_503_7, arg_500_1.talkMaxDuration)

			if var_503_6 <= arg_500_1.time_ and arg_500_1.time_ < var_503_6 + var_503_14 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_6) / var_503_14

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_6 + var_503_14 and arg_500_1.time_ < var_503_6 + var_503_14 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play123071123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 123071123
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play123071124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(arg_504_1.actors_["1050ui_story"]) and arg_504_1.var_.characterEffect1050ui_story == nil then
				arg_504_1.var_.characterEffect1050ui_story = arg_504_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_0 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 and not isNil(arg_504_1.actors_["1050ui_story"]) then
				if arg_504_1.var_.characterEffect1050ui_story and not isNil(arg_504_1.actors_["1050ui_story"]) then
					arg_504_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_504_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_504_1.time_ - 0) / var_507_0)
				end
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 and not isNil(arg_504_1.actors_["1050ui_story"]) and arg_504_1.var_.characterEffect1050ui_story then
				arg_504_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_504_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_507_1 = 0
			local var_507_2 = 0.25

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_3 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(123071123).content)

				arg_504_1.text_.text = var_507_3

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 10 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 10)

				if (10 <= 0 and var_507_2 or var_507_2 * (utf8.len(var_507_3) / 10)) > 0 and var_507_2 < var_507_5 then
					arg_504_1.talkMaxDuration = var_507_5

					if var_507_5 + var_507_1 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + var_507_1
					end
				end

				arg_504_1.text_.text = var_507_3
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_6 = math.max(var_507_2, arg_504_1.talkMaxDuration)

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_6 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_1) / var_507_6

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_1 + var_507_6 and arg_504_1.time_ < var_507_1 + var_507_6 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play123071124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 123071124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play123071125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0.775

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_1 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(123071124).content)

				arg_508_1.text_.text = var_511_1

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_3 = 31 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 31)

				if (31 <= 0 and var_511_0 or var_511_0 * (utf8.len(var_511_1) / 31)) > 0 and var_511_0 < var_511_3 then
					arg_508_1.talkMaxDuration = var_511_3

					if var_511_3 + 0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_3 + 0
					end
				end

				arg_508_1.text_.text = var_511_1
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_4 = math.max(var_511_0, arg_508_1.talkMaxDuration)

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_4 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - 0) / var_511_4

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= 0 + var_511_4 and arg_508_1.time_ < 0 + var_511_4 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play123071125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 123071125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play123071126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0.3

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_1 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(123071125).content)

				arg_512_1.text_.text = var_515_1

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_3 = 12 <= 0 and var_515_0 or var_515_0 * (utf8.len(var_515_1) / 12)

				if (12 <= 0 and var_515_0 or var_515_0 * (utf8.len(var_515_1) / 12)) > 0 and var_515_0 < var_515_3 then
					arg_512_1.talkMaxDuration = var_515_3

					if var_515_3 + 0 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_3 + 0
					end
				end

				arg_512_1.text_.text = var_515_1
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_4 = math.max(var_515_0, arg_512_1.talkMaxDuration)

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_4 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - 0) / var_515_4

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= 0 + var_515_4 and arg_512_1.time_ < 0 + var_515_4 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play123071126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 123071126
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play123071127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos1093ui_story = arg_516_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_519_0 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 then
				arg_516_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_516_1.time_ - 0) / var_519_0)
				arg_516_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).z)
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles = arg_516_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 then
				arg_516_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_516_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["1093ui_story"].transform.position).z)
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_516_1.actors_["1093ui_story"].transform.localEulerAngles = arg_516_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_519_1 = arg_516_1.actors_["1093ui_story"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_1) and arg_516_1.var_.characterEffect1093ui_story == nil then
				arg_516_1.var_.characterEffect1093ui_story = var_519_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_2 and not isNil(var_519_1) then
				if arg_516_1.var_.characterEffect1093ui_story and not isNil(var_519_1) then
					arg_516_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_2)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_2 and arg_516_1.time_ < 0 + var_519_2 + arg_519_0 and not isNil(var_519_1) and arg_516_1.var_.characterEffect1093ui_story then
				arg_516_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_519_3 = arg_516_1.actors_["1050ui_story"].transform

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos1050ui_story = var_519_3.localPosition
			end

			local var_519_4 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_4 then
				var_519_3.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_516_1.time_ - 0) / var_519_4)
				var_519_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_3.position).x, (manager.ui.mainCamera.transform.position - var_519_3.position).y, (manager.ui.mainCamera.transform.position - var_519_3.position).z)
				var_519_3.localEulerAngles.z = 0
				var_519_3.localEulerAngles.x = 0
				var_519_3.localEulerAngles = var_519_3.localEulerAngles
			end

			if arg_516_1.time_ >= 0 + var_519_4 and arg_516_1.time_ < 0 + var_519_4 + arg_519_0 then
				var_519_3.localPosition = Vector3.New(0, 100, 0)
				var_519_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_519_3.position).x, (manager.ui.mainCamera.transform.position - var_519_3.position).y, (manager.ui.mainCamera.transform.position - var_519_3.position).z)
				var_519_3.localEulerAngles.z = 0
				var_519_3.localEulerAngles.x = 0
				var_519_3.localEulerAngles = var_519_3.localEulerAngles
			end

			local var_519_5 = arg_516_1.actors_["1050ui_story"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_5) and arg_516_1.var_.characterEffect1050ui_story == nil then
				arg_516_1.var_.characterEffect1050ui_story = var_519_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_6 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_6 and not isNil(var_519_5) then
				if arg_516_1.var_.characterEffect1050ui_story and not isNil(var_519_5) then
					arg_516_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_516_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_516_1.time_ - 0) / var_519_6)
				end
			end

			if arg_516_1.time_ >= 0 + var_519_6 and arg_516_1.time_ < 0 + var_519_6 + arg_519_0 and not isNil(var_519_5) and arg_516_1.var_.characterEffect1050ui_story then
				arg_516_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_516_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_519_8 = 0
			local var_519_9 = 0.625

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_8 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_10 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(123071126).content)

				arg_516_1.text_.text = var_519_10

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_12 = 24 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_10) / 24)

				if (24 <= 0 and var_519_9 or var_519_9 * (utf8.len(var_519_10) / 24)) > 0 and var_519_9 < var_519_12 then
					arg_516_1.talkMaxDuration = var_519_12

					if var_519_12 + var_519_8 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_12 + var_519_8
					end
				end

				arg_516_1.text_.text = var_519_10
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_13 = math.max(var_519_9, arg_516_1.talkMaxDuration)

			if var_519_8 <= arg_516_1.time_ and arg_516_1.time_ < var_519_8 + var_519_13 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_8) / var_519_13

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_8 + var_519_13 and arg_516_1.time_ < var_519_8 + var_519_13 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play123071127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 123071127
		arg_520_1.duration_ = 2

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play123071128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos1093ui_story = arg_520_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_523_0 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 then
				arg_520_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_520_1.time_ - 0) / var_523_0)
				arg_520_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).z)
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles = arg_520_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 then
				arg_520_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_520_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1093ui_story"].transform.position).z)
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1093ui_story"].transform.localEulerAngles = arg_520_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_523_1 = arg_520_1.actors_["1093ui_story"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_1) and arg_520_1.var_.characterEffect1093ui_story == nil then
				arg_520_1.var_.characterEffect1093ui_story = var_523_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_2 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_2 and not isNil(var_523_1) then
				if arg_520_1.var_.characterEffect1093ui_story and not isNil(var_523_1) then
					arg_520_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_2 and arg_520_1.time_ < 0 + var_523_2 + arg_523_0 and not isNil(var_523_1) and arg_520_1.var_.characterEffect1093ui_story then
				arg_520_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_523_4 = 0
			local var_523_5 = 0.125

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_4 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_6 = arg_520_1:GetWordFromCfg(123071127)
				local var_523_7 = arg_520_1:FormatText(var_523_6.content)

				arg_520_1.text_.text = var_523_7

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_9 = 5 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 5)

				if (5 <= 0 and var_523_5 or var_523_5 * (utf8.len(var_523_7) / 5)) > 0 and var_523_5 < var_523_9 then
					arg_520_1.talkMaxDuration = var_523_9

					if var_523_9 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_9 + var_523_4
					end
				end

				arg_520_1.text_.text = var_523_7
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071127", "story_v_out_123071.awb") ~= 0 then
					local var_523_10 = manager.audio:GetVoiceLength("story_v_out_123071", "123071127", "story_v_out_123071.awb") / 1000

					if var_523_10 + var_523_4 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_10 + var_523_4
					end

					if var_523_6.prefab_name ~= "" and arg_520_1.actors_[var_523_6.prefab_name] ~= nil then
						local var_523_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_6.prefab_name].transform, "story_v_out_123071", "123071127", "story_v_out_123071.awb")

						arg_520_1:RecordAudio("123071127", var_523_11)
						arg_520_1:RecordAudio("123071127", var_523_11)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_123071", "123071127", "story_v_out_123071.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_123071", "123071127", "story_v_out_123071.awb")
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

		arg_520_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_520_1:InitPlayNodeList()
	end,
	Play123071128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 123071128
		arg_524_1.duration_ = 3

		local var_524_0 = {
			zh = 1.999999999999,
			ja = 3
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
			arg_524_1.auto_ = false
		end

		function arg_524_1.playNext_(arg_526_0)
			arg_524_1.onStoryFinished_()
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos1050ui_story = arg_524_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_527_0 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				arg_524_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1050ui_story, Vector3.New(0.7, -1, -6.1), (arg_524_1.time_ - 0) / var_527_0)
				arg_524_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).z)
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles = arg_524_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				arg_524_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6.1)
				arg_524_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["1050ui_story"].transform.position).z)
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["1050ui_story"].transform.localEulerAngles = arg_524_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_527_1 = arg_524_1.actors_["1050ui_story"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1050ui_story == nil then
				arg_524_1.var_.characterEffect1050ui_story = var_527_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_2 and not isNil(var_527_1) then
				if arg_524_1.var_.characterEffect1050ui_story and not isNil(var_527_1) then
					arg_524_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_524_1.time_ >= 0 + var_527_2 and arg_524_1.time_ < 0 + var_527_2 + arg_527_0 and not isNil(var_527_1) and arg_524_1.var_.characterEffect1050ui_story then
				arg_524_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action3_1")
			end

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_527_4 = arg_524_1.actors_["1093ui_story"]

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(var_527_4) and arg_524_1.var_.characterEffect1093ui_story == nil then
				arg_524_1.var_.characterEffect1093ui_story = var_527_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_5 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_5 and not isNil(var_527_4) then
				if arg_524_1.var_.characterEffect1093ui_story and not isNil(var_527_4) then
					arg_524_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_5)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_5 and arg_524_1.time_ < 0 + var_527_5 + arg_527_0 and not isNil(var_527_4) and arg_524_1.var_.characterEffect1093ui_story then
				arg_524_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_527_6 = 0
			local var_527_7 = 0.2

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_8 = arg_524_1:GetWordFromCfg(123071128)
				local var_527_9 = arg_524_1:FormatText(var_527_8.content)

				arg_524_1.text_.text = var_527_9

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_11 = 8 <= 0 and var_527_7 or var_527_7 * (utf8.len(var_527_9) / 8)

				if (8 <= 0 and var_527_7 or var_527_7 * (utf8.len(var_527_9) / 8)) > 0 and var_527_7 < var_527_11 then
					arg_524_1.talkMaxDuration = var_527_11

					if var_527_11 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_11 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_9
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123071", "123071128", "story_v_out_123071.awb") ~= 0 then
					local var_527_12 = manager.audio:GetVoiceLength("story_v_out_123071", "123071128", "story_v_out_123071.awb") / 1000

					if var_527_12 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_12 + var_527_6
					end

					if var_527_8.prefab_name ~= "" and arg_524_1.actors_[var_527_8.prefab_name] ~= nil then
						local var_527_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_8.prefab_name].transform, "story_v_out_123071", "123071128", "story_v_out_123071.awb")

						arg_524_1:RecordAudio("123071128", var_527_13)
						arg_524_1:RecordAudio("123071128", var_527_13)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_123071", "123071128", "story_v_out_123071.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_123071", "123071128", "story_v_out_123071.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_14 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_14 and arg_524_1.time_ < var_527_6 + var_527_14 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/K04f",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K06f"
	},
	voices = {
		"story_v_out_123071.awb"
	}
}
