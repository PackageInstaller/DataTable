return {
	Play103042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103042001
		arg_1_1.duration_ = 6.13

		local var_1_0 = {
			ja = 5.566,
			ko = 4.966,
			zh = 6.133,
			en = 6
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
				arg_1_0:Play103042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
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

			local var_4_8 = "B08b"

			if arg_1_1.bgs_.B08b == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.B08b

				arg_1_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.35

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(103042001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 14 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 14)

				if (14 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 14)) > 0 and var_4_14 < var_4_19 then
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

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042001", "story_v_out_103042.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_103042", "103042001", "story_v_out_103042.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_103042", "103042001", "story_v_out_103042.awb")

						arg_1_1:RecordAudio("103042001", var_4_21)
						arg_1_1:RecordAudio("103042001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103042", "103042001", "story_v_out_103042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103042", "103042001", "story_v_out_103042.awb")
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
	Play103042002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103042002
		arg_8_1.duration_ = 9.27

		local var_8_0 = {
			ja = 9.266,
			ko = 4.633,
			zh = 5.266,
			en = 5.9
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103042003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.45

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(103042002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 18 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 18)

				if (18 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 18)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042002", "story_v_out_103042.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_103042", "103042002", "story_v_out_103042.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_103042", "103042002", "story_v_out_103042.awb")

						arg_8_1:RecordAudio("103042002", var_11_6)
						arg_8_1:RecordAudio("103042002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103042", "103042002", "story_v_out_103042.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103042", "103042002", "story_v_out_103042.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play103042003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103042003
		arg_12_1.duration_ = 4.47

		local var_12_0 = {
			ja = 4.1,
			ko = 4.4,
			zh = 2.966,
			en = 4.466
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
				arg_12_0:Play103042004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1084ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1084ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1084ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_15_3 = 0
			local var_15_4 = 0.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_5 = arg_12_1:GetWordFromCfg(103042003)
				local var_15_6 = arg_12_1:FormatText(var_15_5.content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_8 = 13 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 13)

				if (13 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 13)) > 0 and var_15_4 < var_15_8 then
					arg_12_1.talkMaxDuration = var_15_8

					if var_15_8 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_3
					end
				end

				arg_12_1.text_.text = var_15_6
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042003", "story_v_out_103042.awb") ~= 0 then
					local var_15_9 = manager.audio:GetVoiceLength("story_v_out_103042", "103042003", "story_v_out_103042.awb") / 1000

					if var_15_9 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_9 + var_15_3
					end

					if var_15_5.prefab_name ~= "" and arg_12_1.actors_[var_15_5.prefab_name] ~= nil then
						local var_15_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_5.prefab_name].transform, "story_v_out_103042", "103042003", "story_v_out_103042.awb")

						arg_12_1:RecordAudio("103042003", var_15_10)
						arg_12_1:RecordAudio("103042003", var_15_10)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103042", "103042003", "story_v_out_103042.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103042", "103042003", "story_v_out_103042.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_4, arg_12_1.talkMaxDuration)

			if var_15_3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_3 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_3) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_3 + var_15_11 and arg_12_1.time_ < var_15_3 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play103042004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103042004
		arg_16_1.duration_ = 12.8

		local var_16_0 = {
			ja = 9.433,
			ko = 12,
			zh = 12.8,
			en = 12.666
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
				arg_16_0:Play103042005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.075

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4010")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(103042004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 39 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 39)

				if (39 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 39)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042004", "story_v_out_103042.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_103042", "103042004", "story_v_out_103042.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_103042", "103042004", "story_v_out_103042.awb")

						arg_16_1:RecordAudio("103042004", var_19_6)
						arg_16_1:RecordAudio("103042004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103042", "103042004", "story_v_out_103042.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103042", "103042004", "story_v_out_103042.awb")
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
	Play103042005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103042005
		arg_20_1.duration_ = 2.5

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.233,
			en = 2.5
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
				arg_20_0:Play103042006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "3008ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["3008ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["3008ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["3008ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["3008ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect3008ui_story then
				arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["3008ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_6.localPosition
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_20_1.time_ - 0) / var_23_7)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, -1.51, -4.3)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_8 = 0
			local var_23_9 = 0.2

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(103042005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 8 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 8)

				if (8 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 8)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042005", "story_v_out_103042.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_103042", "103042005", "story_v_out_103042.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_103042", "103042005", "story_v_out_103042.awb")

						arg_20_1:RecordAudio("103042005", var_23_15)
						arg_20_1:RecordAudio("103042005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_103042", "103042005", "story_v_out_103042.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_103042", "103042005", "story_v_out_103042.awb")
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play103042006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103042006
		arg_24_1.duration_ = 4.87

		local var_24_0 = {
			ja = 4.866,
			ko = 4.4,
			zh = 3.9,
			en = 3.6
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play103042007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action442")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_0 = 0
			local var_27_1 = 0.45

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(103042006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 18 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 18)

				if (18 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 18)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042006", "story_v_out_103042.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_103042", "103042006", "story_v_out_103042.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_103042", "103042006", "story_v_out_103042.awb")

						arg_24_1:RecordAudio("103042006", var_27_7)
						arg_24_1:RecordAudio("103042006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103042", "103042006", "story_v_out_103042.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103042", "103042006", "story_v_out_103042.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103042007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103042007
		arg_28_1.duration_ = 3.3

		local var_28_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_28_0:Play103042008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1019ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1019ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1019ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1019ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1019ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_31_6 = arg_28_1.actors_["3008ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 and not isNil(var_31_6) then
				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_7)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_31_8 = arg_28_1.actors_["3008ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, 100, 0)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_31_10 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_10.localPosition
			end

			local var_31_11 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_11 then
				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_28_1.time_ - 0) / var_31_11)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_11 and arg_28_1.time_ < 0 + var_31_11 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.075

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(103042007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 3 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 3)

				if (3 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 3)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042007", "story_v_out_103042.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_103042", "103042007", "story_v_out_103042.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_103042", "103042007", "story_v_out_103042.awb")

						arg_28_1:RecordAudio("103042007", var_31_19)
						arg_28_1:RecordAudio("103042007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103042", "103042007", "story_v_out_103042.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103042", "103042007", "story_v_out_103042.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_20 and arg_28_1.time_ < var_31_12 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play103042008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103042008
		arg_32_1.duration_ = 4.5

		local var_32_0 = {
			ja = 4.5,
			ko = 3,
			zh = 3.1,
			en = 3.933
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
				arg_32_0:Play103042009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1011ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1011ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1011ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1011ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1011ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1011ui_story then
				arg_32_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_35_6 = arg_32_1.actors_["1019ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 and not isNil(var_35_6) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_7)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_35_8 = arg_32_1.actors_["1011ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_35_10 = 0
			local var_35_11 = 0.3

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_12 = arg_32_1:GetWordFromCfg(103042008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 12 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 12)

				if (12 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 12)) > 0 and var_35_11 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042008", "story_v_out_103042.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_103042", "103042008", "story_v_out_103042.awb") / 1000

					if var_35_16 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_10
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_103042", "103042008", "story_v_out_103042.awb")

						arg_32_1:RecordAudio("103042008", var_35_17)
						arg_32_1:RecordAudio("103042008", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103042", "103042008", "story_v_out_103042.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103042", "103042008", "story_v_out_103042.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_18 and arg_32_1.time_ < var_35_10 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play103042009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103042009
		arg_36_1.duration_ = 7.87

		local var_36_0 = {
			ja = 5.533,
			ko = 2.933,
			zh = 6.033,
			en = 7.866
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
				arg_36_0:Play103042010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "4010ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["4010ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["4010ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["4010ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["4010ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect4010ui_story == nil then
				arg_36_1.var_.characterEffect4010ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect4010ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect4010ui_story then
				arg_36_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_39_6 = arg_36_1.actors_["1011ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, 100, 0)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			local var_39_8 = arg_36_1.actors_["1019ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_8.localPosition
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_9)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, 100, 0)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			local var_39_10 = arg_36_1.actors_["4010ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4010ui_story = var_39_10.localPosition
			end

			local var_39_11 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_11 then
				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_36_1.time_ - 0) / var_39_11)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_11 and arg_36_1.time_ < 0 + var_39_11 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, -1.59, -5.2)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action8_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_39_12 = 0
			local var_39_13 = 0.45

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(103042009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 18 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 18)

				if (18 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 18)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042009", "story_v_out_103042.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_103042", "103042009", "story_v_out_103042.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_103042", "103042009", "story_v_out_103042.awb")

						arg_36_1:RecordAudio("103042009", var_39_19)
						arg_36_1:RecordAudio("103042009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103042", "103042009", "story_v_out_103042.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103042", "103042009", "story_v_out_103042.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play103042010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103042010
		arg_40_1.duration_ = 8.33

		local var_40_0 = {
			ja = 6.4,
			ko = 5.633,
			zh = 5.433,
			en = 8.333
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
				arg_40_0:Play103042011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_43_0 = 0
			local var_43_1 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(103042010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 20 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 20)

				if (20 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 20)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042010", "story_v_out_103042.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_103042", "103042010", "story_v_out_103042.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_103042", "103042010", "story_v_out_103042.awb")

						arg_40_1:RecordAudio("103042010", var_43_7)
						arg_40_1:RecordAudio("103042010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103042", "103042010", "story_v_out_103042.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103042", "103042010", "story_v_out_103042.awb")
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
	Play103042011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103042011
		arg_44_1.duration_ = 7.53

		local var_44_0 = {
			ja = 6.533,
			ko = 7.533,
			zh = 5.066,
			en = 4.833
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
				arg_44_0:Play103042012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["3008ui_story"]) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = arg_44_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["3008ui_story"]) then
				if arg_44_1.var_.characterEffect3008ui_story and not isNil(arg_44_1.actors_["3008ui_story"]) then
					arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["3008ui_story"]) and arg_44_1.var_.characterEffect3008ui_story then
				arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["4010ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect4010ui_story then
				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["3008ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos3008ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0.7, -1.51, -4.3)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_47_6 = arg_44_1.actors_["4010ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos4010ui_story = var_47_6.localPosition
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_7)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0, 100, 0)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			local var_47_8 = 0
			local var_47_9 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(103042011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_13 = 27 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 27)

				if (27 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 27)) > 0 and var_47_9 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042011", "story_v_out_103042.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_103042", "103042011", "story_v_out_103042.awb") / 1000

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end

					if var_47_10.prefab_name ~= "" and arg_44_1.actors_[var_47_10.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_10.prefab_name].transform, "story_v_out_103042", "103042011", "story_v_out_103042.awb")

						arg_44_1:RecordAudio("103042011", var_47_15)
						arg_44_1:RecordAudio("103042011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103042", "103042011", "story_v_out_103042.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103042", "103042011", "story_v_out_103042.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_16 and arg_44_1.time_ < var_47_8 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play103042012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103042012
		arg_48_1.duration_ = 7.4

		local var_48_0 = {
			ja = 4,
			ko = 4.166,
			zh = 3.666,
			en = 7.4
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
				arg_48_0:Play103042013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = arg_48_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) then
				if arg_48_1.var_.characterEffect4010ui_story and not isNil(arg_48_1.actors_["4010ui_story"]) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["3008ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_48_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_48_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["4010ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos4010ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_6 = 0
			local var_51_7 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(103042012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 15 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 15)

				if (15 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 15)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042012", "story_v_out_103042.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_103042", "103042012", "story_v_out_103042.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_103042", "103042012", "story_v_out_103042.awb")

						arg_48_1:RecordAudio("103042012", var_51_13)
						arg_48_1:RecordAudio("103042012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103042", "103042012", "story_v_out_103042.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103042", "103042012", "story_v_out_103042.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play103042013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103042013
		arg_52_1.duration_ = 5.7

		local var_52_0 = {
			ja = 5.266,
			ko = 4.933,
			zh = 3.9,
			en = 5.7
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
				arg_52_0:Play103042014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = arg_52_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) then
				if arg_52_1.var_.characterEffect3008ui_story and not isNil(arg_52_1.actors_["3008ui_story"]) then
					arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) and arg_52_1.var_.characterEffect3008ui_story then
				arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["4010ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_52_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_52_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			local var_55_4 = 0
			local var_55_5 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(103042013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)

				if (19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042013", "story_v_out_103042.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042013", "story_v_out_103042.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_103042", "103042013", "story_v_out_103042.awb")

						arg_52_1:RecordAudio("103042013", var_55_11)
						arg_52_1:RecordAudio("103042013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103042", "103042013", "story_v_out_103042.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103042", "103042013", "story_v_out_103042.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play103042014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103042014
		arg_56_1.duration_ = 8.5

		local var_56_0 = {
			ja = 5.933,
			ko = 8.5,
			zh = 6.866,
			en = 5.7
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
				arg_56_0:Play103042015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = arg_56_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) then
				if arg_56_1.var_.characterEffect4010ui_story and not isNil(arg_56_1.actors_["4010ui_story"]) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["3008ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect3008ui_story == nil then
				arg_56_1.var_.characterEffect3008ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect3008ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_56_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect3008ui_story then
				arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_56_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.825

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(103042014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 32 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 32)

				if (32 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 32)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042014", "story_v_out_103042.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042014", "story_v_out_103042.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_103042", "103042014", "story_v_out_103042.awb")

						arg_56_1:RecordAudio("103042014", var_59_11)
						arg_56_1:RecordAudio("103042014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103042", "103042014", "story_v_out_103042.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103042", "103042014", "story_v_out_103042.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103042015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103042015
		arg_60_1.duration_ = 2.7

		local var_60_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_60_0:Play103042016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = arg_60_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) then
				if arg_60_1.var_.characterEffect3008ui_story and not isNil(arg_60_1.actors_["3008ui_story"]) then
					arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) and arg_60_1.var_.characterEffect3008ui_story then
				arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["4010ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect4010ui_story == nil then
				arg_60_1.var_.characterEffect4010ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect4010ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_60_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect4010ui_story then
				arg_60_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_60_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_2")
			end

			local var_63_4 = 0
			local var_63_5 = 0.15

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(103042015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 6 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 6)

				if (6 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 6)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042015", "story_v_out_103042.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042015", "story_v_out_103042.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_103042", "103042015", "story_v_out_103042.awb")

						arg_60_1:RecordAudio("103042015", var_63_11)
						arg_60_1:RecordAudio("103042015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103042", "103042015", "story_v_out_103042.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103042", "103042015", "story_v_out_103042.awb")
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

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play103042016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103042016
		arg_64_1.duration_ = 3.4

		local var_64_0 = {
			ja = 2.766,
			ko = 3.2,
			zh = 2.9,
			en = 3.4
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
				arg_64_0:Play103042017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if arg_64_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_67_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_64_1.stage_.transform)

				var_67_0.name = "3009ui_story"
				var_67_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["3009ui_story"] = var_67_0

				local var_67_1 = var_67_0:GetComponentInChildren(typeof(CharacterEffect))

				var_67_1.enabled = true

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end

				arg_64_1:ShowWeapon(var_67_1.transform, false)

				arg_64_1.var_["3009ui_story" .. "Animator"] = var_67_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_64_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_64_1.var_["3009ui_story" .. "LipSync"] = var_67_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_67_3 = arg_64_1.actors_["3009ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect3009ui_story == nil then
				arg_64_1.var_.characterEffect3009ui_story = var_67_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_4 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 and not isNil(var_67_3) then
				if arg_64_1.var_.characterEffect3009ui_story and not isNil(var_67_3) then
					arg_64_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect3009ui_story then
				arg_64_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_67_6 = arg_64_1.actors_["3008ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos3008ui_story = var_67_6.localPosition
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_6.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_7)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_6.localPosition = Vector3.New(0, 100, 0)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			local var_67_8 = arg_64_1.actors_["3009ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos3009ui_story = var_67_8.localPosition

				arg_64_1:ShowWeapon(arg_64_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_67_9 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_9 then
				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_64_1.time_ - 0) / var_67_9)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_9 and arg_64_1.time_ < 0 + var_67_9 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action4_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_67_10 = 0
			local var_67_11 = 0.325

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_12 = arg_64_1:GetWordFromCfg(103042016)
				local var_67_13 = arg_64_1:FormatText(var_67_12.content)

				arg_64_1.text_.text = var_67_13

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 13 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 13)

				if (13 <= 0 and var_67_11 or var_67_11 * (utf8.len(var_67_13) / 13)) > 0 and var_67_11 < var_67_15 then
					arg_64_1.talkMaxDuration = var_67_15

					if var_67_15 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_15 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_13
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042016", "story_v_out_103042.awb") ~= 0 then
					local var_67_16 = manager.audio:GetVoiceLength("story_v_out_103042", "103042016", "story_v_out_103042.awb") / 1000

					if var_67_16 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_10
					end

					if var_67_12.prefab_name ~= "" and arg_64_1.actors_[var_67_12.prefab_name] ~= nil then
						local var_67_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_12.prefab_name].transform, "story_v_out_103042", "103042016", "story_v_out_103042.awb")

						arg_64_1:RecordAudio("103042016", var_67_17)
						arg_64_1:RecordAudio("103042016", var_67_17)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103042", "103042016", "story_v_out_103042.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103042", "103042016", "story_v_out_103042.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_18 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_18

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_18 and arg_64_1.time_ < var_67_10 + var_67_18 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play103042017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103042017
		arg_68_1.duration_ = 5.23

		local var_68_0 = {
			ja = 4.833,
			ko = 5.233,
			zh = 3.433,
			en = 3.133
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
				arg_68_0:Play103042018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story == nil then
				arg_68_1.var_.characterEffect4010ui_story = arg_68_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) then
				if arg_68_1.var_.characterEffect4010ui_story and not isNil(arg_68_1.actors_["4010ui_story"]) then
					arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story then
				arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["3009ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect3009ui_story == nil then
				arg_68_1.var_.characterEffect3009ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect3009ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_68_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect3009ui_story then
				arg_68_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_68_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.475

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(103042017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 19 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 19)

				if (19 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 19)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042017", "story_v_out_103042.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_103042", "103042017", "story_v_out_103042.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_103042", "103042017", "story_v_out_103042.awb")

						arg_68_1:RecordAudio("103042017", var_71_11)
						arg_68_1:RecordAudio("103042017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103042", "103042017", "story_v_out_103042.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103042", "103042017", "story_v_out_103042.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play103042018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103042018
		arg_72_1.duration_ = 7.67

		local var_72_0 = {
			ja = 6.299999999999,
			ko = 7.666,
			zh = 6.6,
			en = 6.366
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
				arg_72_0:Play103042019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 1.79999995231628 < arg_72_1.time_ and arg_72_1.time_ <= 1.79999995231628 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 1.79999995231628 <= arg_72_1.time_ and arg_72_1.time_ < 1.79999995231628 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 1.79999995231628 + var_75_0 and arg_72_1.time_ < 1.79999995231628 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_75_2 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_3 = 2

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_3 then
				local var_75_4 = Color.New(0, 0, 0)

				var_75_4.a = Mathf.Lerp(0, 1, (arg_72_1.time_ - var_75_2) / var_75_3)
				arg_72_1.mask_.color = var_75_4
			end

			if arg_72_1.time_ >= var_75_2 + var_75_3 and arg_72_1.time_ < var_75_2 + var_75_3 + arg_75_0 then
				local var_75_5 = Color.New(0, 0, 0)

				var_75_5.a = 1
				arg_72_1.mask_.color = var_75_5
			end

			local var_75_6 = 2

			if 2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_7 = 2

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_7 then
				local var_75_8 = Color.New(0, 0, 0)

				var_75_8.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_6) / var_75_7)
				arg_72_1.mask_.color = var_75_8
			end

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				local var_75_9 = Color.New(0, 0, 0)

				arg_72_1.mask_.enabled = false
				var_75_9.a = 0
				arg_72_1.mask_.color = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["4010ui_story"].transform

			if 1.967 < arg_72_1.time_ and arg_72_1.time_ <= 1.967 + arg_75_0 then
				arg_72_1.var_.moveOldPos4010ui_story = var_75_10.localPosition
			end

			local var_75_11 = 0.001

			if 1.967 <= arg_72_1.time_ and arg_72_1.time_ < 1.967 + var_75_11 then
				var_75_10.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 1.967) / var_75_11)
				var_75_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_10.position).x, (manager.ui.mainCamera.transform.position - var_75_10.position).y, (manager.ui.mainCamera.transform.position - var_75_10.position).z)
				var_75_10.localEulerAngles.z = 0
				var_75_10.localEulerAngles.x = 0
				var_75_10.localEulerAngles = var_75_10.localEulerAngles
			end

			if arg_72_1.time_ >= 1.967 + var_75_11 and arg_72_1.time_ < 1.967 + var_75_11 + arg_75_0 then
				var_75_10.localPosition = Vector3.New(0, 100, 0)
				var_75_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_10.position).x, (manager.ui.mainCamera.transform.position - var_75_10.position).y, (manager.ui.mainCamera.transform.position - var_75_10.position).z)
				var_75_10.localEulerAngles.z = 0
				var_75_10.localEulerAngles.x = 0
				var_75_10.localEulerAngles = var_75_10.localEulerAngles
			end

			local var_75_12 = arg_72_1.actors_["3009ui_story"].transform

			if 1.967 < arg_72_1.time_ and arg_72_1.time_ <= 1.967 + arg_75_0 then
				arg_72_1.var_.moveOldPos3009ui_story = var_75_12.localPosition
			end

			local var_75_13 = 0.001

			if 1.967 <= arg_72_1.time_ and arg_72_1.time_ < 1.967 + var_75_13 then
				var_75_12.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 1.967) / var_75_13)
				var_75_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_12.position).x, (manager.ui.mainCamera.transform.position - var_75_12.position).y, (manager.ui.mainCamera.transform.position - var_75_12.position).z)
				var_75_12.localEulerAngles.z = 0
				var_75_12.localEulerAngles.x = 0
				var_75_12.localEulerAngles = var_75_12.localEulerAngles
			end

			if arg_72_1.time_ >= 1.967 + var_75_13 and arg_72_1.time_ < 1.967 + var_75_13 + arg_75_0 then
				var_75_12.localPosition = Vector3.New(0, 100, 0)
				var_75_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_12.position).x, (manager.ui.mainCamera.transform.position - var_75_12.position).y, (manager.ui.mainCamera.transform.position - var_75_12.position).z)
				var_75_12.localEulerAngles.z = 0
				var_75_12.localEulerAngles.x = 0
				var_75_12.localEulerAngles = var_75_12.localEulerAngles
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_75_14 = arg_72_1.actors_["1084ui_story"].transform

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_14.localPosition
			end

			local var_75_15 = 0.001

			if 3.8 <= arg_72_1.time_ and arg_72_1.time_ < 3.8 + var_75_15 then
				var_75_14.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_72_1.time_ - 3.8) / var_75_15)
				var_75_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_14.position).x, (manager.ui.mainCamera.transform.position - var_75_14.position).y, (manager.ui.mainCamera.transform.position - var_75_14.position).z)
				var_75_14.localEulerAngles.z = 0
				var_75_14.localEulerAngles.x = 0
				var_75_14.localEulerAngles = var_75_14.localEulerAngles
			end

			if arg_72_1.time_ >= 3.8 + var_75_15 and arg_72_1.time_ < 3.8 + var_75_15 + arg_75_0 then
				var_75_14.localPosition = Vector3.New(0, -0.97, -6)
				var_75_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_14.position).x, (manager.ui.mainCamera.transform.position - var_75_14.position).y, (manager.ui.mainCamera.transform.position - var_75_14.position).z)
				var_75_14.localEulerAngles.z = 0
				var_75_14.localEulerAngles.x = 0
				var_75_14.localEulerAngles = var_75_14.localEulerAngles
			end

			if 3.8 < arg_72_1.time_ and arg_72_1.time_ <= 3.8 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_16 = 4
			local var_75_17 = 0.35

			if 4 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_18 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_18:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_19 = arg_72_1:GetWordFromCfg(103042018)
				local var_75_20 = arg_72_1:FormatText(var_75_19.content)

				arg_72_1.text_.text = var_75_20

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_22 = 12 <= 0 and var_75_17 or var_75_17 * (utf8.len(var_75_20) / 12)

				if (12 <= 0 and var_75_17 or var_75_17 * (utf8.len(var_75_20) / 12)) > 0 and var_75_17 < var_75_22 then
					arg_72_1.talkMaxDuration = var_75_22
					var_75_16 = var_75_16 + 0.3

					if var_75_22 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_22 + var_75_16
					end
				end

				arg_72_1.text_.text = var_75_20
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042018", "story_v_out_103042.awb") ~= 0 then
					local var_75_23 = manager.audio:GetVoiceLength("story_v_out_103042", "103042018", "story_v_out_103042.awb") / 1000

					if var_75_23 + var_75_16 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_23 + var_75_16
					end

					if var_75_19.prefab_name ~= "" and arg_72_1.actors_[var_75_19.prefab_name] ~= nil then
						local var_75_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_19.prefab_name].transform, "story_v_out_103042", "103042018", "story_v_out_103042.awb")

						arg_72_1:RecordAudio("103042018", var_75_24)
						arg_72_1:RecordAudio("103042018", var_75_24)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103042", "103042018", "story_v_out_103042.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103042", "103042018", "story_v_out_103042.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_25 = var_75_16 + 0.3
			local var_75_26 = math.max(var_75_17, arg_72_1.talkMaxDuration)

			if var_75_16 + 0.3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_25 + var_75_26 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_25) / var_75_26

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_25 + var_75_26 and arg_72_1.time_ < var_75_25 + var_75_26 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play103042019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 103042019
		arg_78_1.duration_ = 7.2

		local var_78_0 = {
			ja = 7.2,
			ko = 5.4,
			zh = 4.433,
			en = 5.7
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play103042020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = arg_78_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) then
				if arg_78_1.var_.characterEffect1019ui_story and not isNil(arg_78_1.actors_["1019ui_story"]) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1019ui_story"]) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1084ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1084ui_story = var_81_2.localPosition
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_3)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, 100, 0)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_81_4 = arg_78_1.actors_["1019ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1019ui_story = var_81_4.localPosition
			end

			local var_81_5 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_5 then
				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_78_1.time_ - 0) / var_81_5)
				var_81_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_4.position).x, (manager.ui.mainCamera.transform.position - var_81_4.position).y, (manager.ui.mainCamera.transform.position - var_81_4.position).z)
				var_81_4.localEulerAngles.z = 0
				var_81_4.localEulerAngles.x = 0
				var_81_4.localEulerAngles = var_81_4.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_5 and arg_78_1.time_ < 0 + var_81_5 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_81_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_4.position).x, (manager.ui.mainCamera.transform.position - var_81_4.position).y, (manager.ui.mainCamera.transform.position - var_81_4.position).z)
				var_81_4.localEulerAngles.z = 0
				var_81_4.localEulerAngles.x = 0
				var_81_4.localEulerAngles = var_81_4.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_81_6 = 0
			local var_81_7 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(103042019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 28 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_9) / 28)

				if (28 <= 0 and var_81_7 or var_81_7 * (utf8.len(var_81_9) / 28)) > 0 and var_81_7 < var_81_11 then
					arg_78_1.talkMaxDuration = var_81_11

					if var_81_11 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042019", "story_v_out_103042.awb") ~= 0 then
					local var_81_12 = manager.audio:GetVoiceLength("story_v_out_103042", "103042019", "story_v_out_103042.awb") / 1000

					if var_81_12 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_6
					end

					if var_81_8.prefab_name ~= "" and arg_78_1.actors_[var_81_8.prefab_name] ~= nil then
						local var_81_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_8.prefab_name].transform, "story_v_out_103042", "103042019", "story_v_out_103042.awb")

						arg_78_1:RecordAudio("103042019", var_81_13)
						arg_78_1:RecordAudio("103042019", var_81_13)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_103042", "103042019", "story_v_out_103042.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_103042", "103042019", "story_v_out_103042.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_14 and arg_78_1.time_ < var_81_6 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play103042020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 103042020
		arg_82_1.duration_ = 2.87

		local var_82_0 = {
			ja = 2.866,
			ko = 2.666,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play103042021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_85_0 = 0
			local var_85_1 = 0.275

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(103042020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 11 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 11)

				if (11 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 11)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103042", "103042020", "story_v_out_103042.awb") ~= 0 then
					local var_85_6 = manager.audio:GetVoiceLength("story_v_out_103042", "103042020", "story_v_out_103042.awb") / 1000

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end

					if var_85_2.prefab_name ~= "" and arg_82_1.actors_[var_85_2.prefab_name] ~= nil then
						local var_85_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_2.prefab_name].transform, "story_v_out_103042", "103042020", "story_v_out_103042.awb")

						arg_82_1:RecordAudio("103042020", var_85_7)
						arg_82_1:RecordAudio("103042020", var_85_7)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_103042", "103042020", "story_v_out_103042.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_103042", "103042020", "story_v_out_103042.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play103042021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 103042021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
			arg_86_1.auto_ = false
		end

		function arg_86_1.playNext_(arg_88_0)
			arg_86_1.onStoryFinished_()
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = arg_86_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) then
				if arg_86_1.var_.characterEffect1019ui_story and not isNil(arg_86_1.actors_["1019ui_story"]) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1019ui_story"]) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_89_1 = 0
			local var_89_2 = 0.625

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(103042021).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 25 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 25)

				if (25 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 25)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_103042.awb"
	}
}
