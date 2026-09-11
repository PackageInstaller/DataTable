return {
	Play304101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304101001
		arg_1_1.duration_ = 7.91

		local var_1_0 = {
			zh = 7.708,
			ja = 7.908
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
				arg_1_0:Play304101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9002
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.B10 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10")
				var_4_0.name = "B10"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10

				arg_1_1.bgs_.B10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1148ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect444233

				if not arg_1_1.var_.effect444233 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_16.name = "444233"
					arg_1_1.var_.effect444233 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9002)
				end

				var_4_16.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect444234

				if not arg_1_1.var_.effect444234 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_18.name = "444234"
					arg_1_1.var_.effect444234 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9001)
				end

				var_4_18.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.433333333333334 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333334 + arg_4_0 then
				local var_4_20 = arg_1_1.var_.effect444235

				if not arg_1_1.var_.effect444235 then
					var_4_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_4_20.name = "444235"
					arg_1_1.var_.effect444235 = var_4_20
				else
					var_4_20.transform:SetParent(var_4_9000)
				end

				var_4_20.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_4_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				if arg_1_1.var_.effect444233 then
					Object.Destroy(arg_1_1.var_.effect444233)

					arg_1_1.var_.effect444233 = nil
				end
			end

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				if arg_1_1.var_.effect444234 then
					Object.Destroy(arg_1_1.var_.effect444234)

					arg_1_1.var_.effect444234 = nil
				end
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				if arg_1_1.var_.effect444235 then
					Object.Destroy(arg_1_1.var_.effect444235)

					arg_1_1.var_.effect444235 = nil
				end
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_machinegun_b", "")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_29 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_31 = 1.375
			local var_4_32 = 0.625

			if 1.375 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_33 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_33:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_34 = arg_1_1:GetWordFromCfg(304101001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 25 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 25)

				if (25 <= 0 and var_4_32 or var_4_32 * (utf8.len(var_4_35) / 25)) > 0 and var_4_32 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_31 = var_4_31 + 0.3

					if var_4_37 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_31
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101001", "story_v_out_304101.awb") ~= 0 then
					local var_4_38 = manager.audio:GetVoiceLength("story_v_out_304101", "304101001", "story_v_out_304101.awb") / 1000

					if var_4_38 + var_4_31 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_31
					end

					if var_4_34.prefab_name ~= "" and arg_1_1.actors_[var_4_34.prefab_name] ~= nil then
						local var_4_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_34.prefab_name].transform, "story_v_out_304101", "304101001", "story_v_out_304101.awb")

						arg_1_1:RecordAudio("304101001", var_4_39)
						arg_1_1:RecordAudio("304101001", var_4_39)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304101", "304101001", "story_v_out_304101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304101", "304101001", "story_v_out_304101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_40 = var_4_31 + 0.3
			local var_4_41 = math.max(var_4_32, arg_1_1.talkMaxDuration)

			if var_4_31 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_40) / var_4_41

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304101002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = arg_8_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(arg_8_1.actors_["1148ui_story"]) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_8_1.time_ and arg_8_1.time_ <= 0.2 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story", "se_story_machinegun_a", "")
			end

			local var_11_2 = 0
			local var_11_3 = 0.825

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_4 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(304101002).content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 33 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 33)

				if (33 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 33)) > 0 and var_11_3 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_2 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_2
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_3, arg_8_1.talkMaxDuration)

			if var_11_2 <= arg_8_1.time_ and arg_8_1.time_ < var_11_2 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_2) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_2 + var_11_7 and arg_8_1.time_ < var_11_2 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304101003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0.2 < arg_12_1.time_ and arg_12_1.time_ <= 0.2 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if 0.5 < arg_12_1.time_ and arg_12_1.time_ <= 0.5 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun07", "")
			end

			local var_15_2 = 0
			local var_15_3 = 1.625

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(304101003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 65 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 65)

				if (65 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 65)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304101004
		arg_16_1.duration_ = 13.83

		local var_16_0 = {
			zh = 6.7,
			ja = 13.833
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
				arg_16_0:Play304101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1059ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1059ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1059ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1059ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1059ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1059ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.05, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1059ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1059ui_story then
				arg_16_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.925

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(304101004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 37 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 37)

				if (37 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 37)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101004", "story_v_out_304101.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_304101", "304101004", "story_v_out_304101.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_304101", "304101004", "story_v_out_304101.awb")

						arg_16_1:RecordAudio("304101004", var_19_15)
						arg_16_1:RecordAudio("304101004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304101", "304101004", "story_v_out_304101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304101", "304101004", "story_v_out_304101.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play304101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304101005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = arg_20_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) then
				if arg_20_1.var_.characterEffect1059ui_story and not isNil(arg_20_1.actors_["1059ui_story"]) then
					arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) and arg_20_1.var_.characterEffect1059ui_story then
				arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("calling")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(304101005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 19 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 19)

				if (19 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 19)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304101006
		arg_24_1.duration_ = 5.87

		local var_24_0 = {
			zh = 5.466,
			ja = 5.866
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
				arg_24_0:Play304101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1148ui_story = arg_24_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).z)
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles = arg_24_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_24_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1148ui_story"].transform.position).z)
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1148ui_story"].transform.localEulerAngles = arg_24_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["1059ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_1.localPosition
			end

			local var_27_2 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 then
				var_27_1.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_2)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 then
				var_27_1.localPosition = Vector3.New(0, 100, 0)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles
			end

			local var_27_3 = arg_24_1.actors_["1148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1148ui_story == nil then
				arg_24_1.var_.characterEffect1148ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect1148ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1148ui_story then
				arg_24_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_6 = 0
			local var_27_7 = 0.6

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(304101006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 24 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 24)

				if (24 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 24)) > 0 and var_27_7 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101006", "story_v_out_304101.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_304101", "304101006", "story_v_out_304101.awb") / 1000

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_304101", "304101006", "story_v_out_304101.awb")

						arg_24_1:RecordAudio("304101006", var_27_13)
						arg_24_1:RecordAudio("304101006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304101", "304101006", "story_v_out_304101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304101", "304101006", "story_v_out_304101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play304101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304101007
		arg_28_1.duration_ = 14.13

		local var_28_0 = {
			zh = 8.866,
			ja = 14.133
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
				arg_28_0:Play304101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1059ui_story"]) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = arg_28_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1059ui_story"]) then
				if arg_28_1.var_.characterEffect1059ui_story and not isNil(arg_28_1.actors_["1059ui_story"]) then
					arg_28_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1059ui_story"]) and arg_28_1.var_.characterEffect1059ui_story then
				arg_28_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1148ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1148ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_31_4 = arg_28_1.actors_["1148ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1148ui_story = var_31_4.localPosition
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_28_1.time_ - 0) / var_31_5)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			local var_31_6 = arg_28_1.actors_["1059ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1059ui_story = var_31_6.localPosition
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_28_1.time_ - 0) / var_31_7)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0.7, -1.05, -6)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action447")
			end

			local var_31_8 = 0
			local var_31_9 = 1.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(304101007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 45 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 45)

				if (45 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 45)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101007", "story_v_out_304101.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_304101", "304101007", "story_v_out_304101.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_304101", "304101007", "story_v_out_304101.awb")

						arg_28_1:RecordAudio("304101007", var_31_15)
						arg_28_1:RecordAudio("304101007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304101", "304101007", "story_v_out_304101.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304101", "304101007", "story_v_out_304101.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play304101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304101008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play304101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = arg_32_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) then
				if arg_32_1.var_.characterEffect1059ui_story and not isNil(arg_32_1.actors_["1059ui_story"]) then
					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) and arg_32_1.var_.characterEffect1059ui_story then
				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.85

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("calling")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(304101008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 34 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 34)

				if (34 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 34)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304101009
		arg_36_1.duration_ = 8.27

		local var_36_0 = {
			zh = 6.033,
			ja = 8.266
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
				arg_36_0:Play304101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) and arg_36_1.var_.characterEffect1148ui_story == nil then
				arg_36_1.var_.characterEffect1148ui_story = arg_36_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) then
				if arg_36_1.var_.characterEffect1148ui_story and not isNil(arg_36_1.actors_["1148ui_story"]) then
					arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1148ui_story"]) and arg_36_1.var_.characterEffect1148ui_story then
				arg_36_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_39_2 = 0
			local var_39_3 = 0.625

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(304101009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 25 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 25)

				if (25 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 25)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101009", "story_v_out_304101.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101009", "story_v_out_304101.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_304101", "304101009", "story_v_out_304101.awb")

						arg_36_1:RecordAudio("304101009", var_39_9)
						arg_36_1:RecordAudio("304101009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304101", "304101009", "story_v_out_304101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304101", "304101009", "story_v_out_304101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304101010
		arg_40_1.duration_ = 7.87

		local var_40_0 = {
			zh = 5.633,
			ja = 7.866
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
				arg_40_0:Play304101011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.625

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(304101010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 25 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 25)

				if (25 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 25)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101010", "story_v_out_304101.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_304101", "304101010", "story_v_out_304101.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_304101", "304101010", "story_v_out_304101.awb")

						arg_40_1:RecordAudio("304101010", var_43_6)
						arg_40_1:RecordAudio("304101010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304101", "304101010", "story_v_out_304101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304101", "304101010", "story_v_out_304101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304101011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148ui_story = arg_44_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).z)
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles = arg_44_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1148ui_story"].transform.position).z)
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1148ui_story"].transform.localEulerAngles = arg_44_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1059ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1059ui_story = var_47_1.localPosition
			end

			local var_47_2 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 then
				var_47_1.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_2)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 then
				var_47_1.localPosition = Vector3.New(0, 100, 0)
				var_47_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_1.position).x, (manager.ui.mainCamera.transform.position - var_47_1.position).y, (manager.ui.mainCamera.transform.position - var_47_1.position).z)
				var_47_1.localEulerAngles.z = 0
				var_47_1.localEulerAngles.x = 0
				var_47_1.localEulerAngles = var_47_1.localEulerAngles
			end

			local var_47_3 = arg_44_1.actors_["1148ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1148ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_4)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1148ui_story then
				arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_47_5 = 0
			local var_47_6 = 1.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(304101011).content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 61 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 61)

				if (61 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_7) / 61)) > 0 and var_47_6 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_10 and arg_44_1.time_ < var_47_5 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play304101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304101012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.025

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("calling")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(304101012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 41 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 41)

				if (41 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 41)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304101013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play304101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.925

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("calling")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(304101013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 37 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 37)

				if (37 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 37)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304101014
		arg_56_1.duration_ = 12.3

		local var_56_0 = {
			zh = 7.533,
			ja = 12.3
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
				arg_56_0:Play304101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148ui_story = arg_56_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).z)
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles = arg_56_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_56_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1148ui_story"].transform.position).z)
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1148ui_story"].transform.localEulerAngles = arg_56_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1148ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1148ui_story then
				arg_56_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_4 = 0
			local var_59_5 = 0.85

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(304101014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 34 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 34)

				if (34 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 34)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101014", "story_v_out_304101.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101014", "story_v_out_304101.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_304101", "304101014", "story_v_out_304101.awb")

						arg_56_1:RecordAudio("304101014", var_59_11)
						arg_56_1:RecordAudio("304101014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304101", "304101014", "story_v_out_304101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304101", "304101014", "story_v_out_304101.awb")
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

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play304101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304101015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play304101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = arg_60_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) then
				if arg_60_1.var_.characterEffect1148ui_story and not isNil(arg_60_1.actors_["1148ui_story"]) then
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.825

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("calling")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(304101015).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 33 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 33)

				if (33 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 33)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304101016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.5

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
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

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(304101016).content)

				arg_64_1.text_.text = var_67_1

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_3 = 20 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 20)

				if (20 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_1) / 20)) > 0 and var_67_0 < var_67_3 then
					arg_64_1.talkMaxDuration = var_67_3

					if var_67_3 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_3 + 0
					end
				end

				arg_64_1.text_.text = var_67_1
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_4 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_4

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304101017
		arg_68_1.duration_ = 12.13

		local var_68_0 = {
			zh = 8.233,
			ja = 12.133
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
				arg_68_0:Play304101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story == nil then
				arg_68_1.var_.characterEffect1148ui_story = arg_68_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) then
				if arg_68_1.var_.characterEffect1148ui_story and not isNil(arg_68_1.actors_["1148ui_story"]) then
					arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story then
				arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action475")
			end

			local var_71_2 = 0
			local var_71_3 = 0.825

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(304101017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 33 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 33)

				if (33 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 33)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101017", "story_v_out_304101.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_304101", "304101017", "story_v_out_304101.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_304101", "304101017", "story_v_out_304101.awb")

						arg_68_1:RecordAudio("304101017", var_71_9)
						arg_68_1:RecordAudio("304101017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304101", "304101017", "story_v_out_304101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304101", "304101017", "story_v_out_304101.awb")
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
	Play304101018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304101018
		arg_72_1.duration_ = 4.3

		local var_72_0 = {
			zh = 3.8,
			ja = 4.3
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
				arg_72_0:Play304101019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.3

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(304101018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 12 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 12)

				if (12 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 12)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101018", "story_v_out_304101.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_304101", "304101018", "story_v_out_304101.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_304101", "304101018", "story_v_out_304101.awb")

						arg_72_1:RecordAudio("304101018", var_75_6)
						arg_72_1:RecordAudio("304101018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304101", "304101018", "story_v_out_304101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304101", "304101018", "story_v_out_304101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304101019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304101019
		arg_76_1.duration_ = 6.73

		local var_76_0 = {
			zh = 3.466,
			ja = 6.733
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
				arg_76_0:Play304101020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = arg_76_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) then
				if arg_76_1.var_.characterEffect1059ui_story and not isNil(arg_76_1.actors_["1059ui_story"]) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1148ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1148ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_79_4 = 0
			local var_79_5 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1059")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_6 = arg_76_1:GetWordFromCfg(304101019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 15 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 15)

				if (15 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 15)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101019", "story_v_out_304101.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101019", "story_v_out_304101.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_304101", "304101019", "story_v_out_304101.awb")

						arg_76_1:RecordAudio("304101019", var_79_11)
						arg_76_1:RecordAudio("304101019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304101", "304101019", "story_v_out_304101.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304101", "304101019", "story_v_out_304101.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304101020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304101020
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play304101021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) and arg_80_1.var_.characterEffect1148ui_story == nil then
				arg_80_1.var_.characterEffect1148ui_story = arg_80_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) then
				if arg_80_1.var_.characterEffect1148ui_story and not isNil(arg_80_1.actors_["1148ui_story"]) then
					arg_80_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1148ui_story"]) and arg_80_1.var_.characterEffect1148ui_story then
				arg_80_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1059ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_4 = 0
			local var_83_5 = 0.05

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(304101020)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 2 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 2)

				if (2 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 2)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101020", "story_v_out_304101.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101020", "story_v_out_304101.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_304101", "304101020", "story_v_out_304101.awb")

						arg_80_1:RecordAudio("304101020", var_83_11)
						arg_80_1:RecordAudio("304101020", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304101", "304101020", "story_v_out_304101.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304101", "304101020", "story_v_out_304101.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play304101021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304101021
		arg_84_1.duration_ = 6

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304101022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_9000

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148ui_story = arg_84_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).z)
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles = arg_84_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1148ui_story"].transform.position).z)
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1148ui_story"].transform.localEulerAngles = arg_84_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1148ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect1148ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_2)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_87_3 = 0.533333333333333

			if 0.533333333333333 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = false

				arg_84_1:SetGaussion(false)
			end

			local var_87_4 = 0.4

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_4 then
				local var_87_5 = Color.New(1, 1, 1)

				var_87_5.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_3) / var_87_4)
				arg_84_1.mask_.color = var_87_5
			end

			if arg_84_1.time_ >= var_87_3 + var_87_4 and arg_84_1.time_ < var_87_3 + var_87_4 + arg_87_0 then
				local var_87_6 = Color.New(1, 1, 1)

				arg_84_1.mask_.enabled = false
				var_87_6.a = 0
				arg_84_1.mask_.color = var_87_6
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				local var_87_7 = arg_84_1.var_.effect嗒嘀嗒哒哒

				if not arg_84_1.var_.effect嗒嘀嗒哒哒 then
					var_87_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_87_7.name = "嗒嘀嗒哒哒"
					arg_84_1.var_.effect嗒嘀嗒哒哒 = var_87_7
				else
					var_87_7.transform:SetParent(var_87_9000)
				end

				var_87_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_87_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_87_7.transform.localScale = Vector3.New(var_87_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_87_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_87_7.transform.localScale.z)
			end

			if 0.752989433364322 < arg_84_1.time_ and arg_84_1.time_ <= 0.752989433364322 + arg_87_0 then
				if arg_84_1.var_.effect嗒嘀嗒哒哒 then
					Object.Destroy(arg_84_1.var_.effect嗒嘀嗒哒哒)

					arg_84_1.var_.effect嗒嘀嗒哒哒 = nil
				end
			end

			local var_87_10 = 0

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= var_87_10 + 1.43333333333333 and arg_84_1.time_ < var_87_10 + 1.43333333333333 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_11 = 1
			local var_87_12 = 0.925

			if 1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_11 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_13 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_13:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_14 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(304101021).content)

				arg_84_1.text_.text = var_87_14

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_16 = 37 <= 0 and var_87_12 or var_87_12 * (utf8.len(var_87_14) / 37)

				if (37 <= 0 and var_87_12 or var_87_12 * (utf8.len(var_87_14) / 37)) > 0 and var_87_12 < var_87_16 then
					arg_84_1.talkMaxDuration = var_87_16
					var_87_11 = var_87_11 + 0.3

					if var_87_16 + var_87_11 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_16 + var_87_11
					end
				end

				arg_84_1.text_.text = var_87_14
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_17 = var_87_11 + 0.3
			local var_87_18 = math.max(var_87_12, arg_84_1.talkMaxDuration)

			if var_87_11 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_17 + var_87_18 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_17) / var_87_18

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_17 + var_87_18 and arg_84_1.time_ < var_87_17 + var_87_18 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play304101022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 304101022
		arg_90_1.duration_ = 6

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play304101023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				local var_93_0 = arg_90_1.var_.effect热热热

				if not arg_90_1.var_.effect热热热 then
					var_93_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_93_0.name = "热热热"
					arg_90_1.var_.effect热热热 = var_93_0
				else
					var_93_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_93_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_93_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_93_0.transform.localScale = Vector3.New(var_93_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_93_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_93_0.transform.localScale.z)
			end

			if 1.7 < arg_90_1.time_ and arg_90_1.time_ <= 1.7 + arg_93_0 then
				if arg_90_1.var_.effect热热热 then
					Object.Destroy(arg_90_1.var_.effect热热热)

					arg_90_1.var_.effect热热热 = nil
				end
			end

			local var_93_3 = 0

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_3 + arg_93_0 then
				arg_90_1.allBtn_.enabled = false
			end

			if arg_90_1.time_ >= var_93_3 + 1.1 and arg_90_1.time_ < var_93_3 + 1.1 + arg_93_0 then
				arg_90_1.allBtn_.enabled = true
			end

			if arg_90_1.frameCnt_ <= 1 then
				arg_90_1.dialog_:SetActive(false)
			end

			local var_93_4 = 1
			local var_93_5 = 1.725

			if 1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0

				arg_90_1.dialog_:SetActive(true)

				arg_90_1.dialogCg_.alpha = 0

				local var_93_6 = LeanTween.value(arg_90_1.dialog_, 0, 1, 0.3)

				var_93_6:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_90_1.dialogCg_.alpha = arg_94_0
				end))
				var_93_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_90_1.dialog_)
					var_93_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_90_1.duration_ = arg_90_1.duration_ + 0.3

				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(304101022).content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 69 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 69)

				if (69 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 69)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9
					var_93_4 = var_93_4 + 0.3

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = var_93_4 + 0.3
			local var_93_11 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 + 0.3 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_10) / var_93_11

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play304101023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304101023
		arg_96_1.duration_ = 4.83

		local var_96_0 = {
			zh = 3.7,
			ja = 4.833
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play304101024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1148ui_story = arg_96_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).z)
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles = arg_96_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_96_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1148ui_story"].transform.position).z)
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1148ui_story"].transform.localEulerAngles = arg_96_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1148ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1148ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_99_4 = 0
			local var_99_5 = 0.325

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(304101023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)

				if (13 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 13)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101023", "story_v_out_304101.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101023", "story_v_out_304101.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_304101", "304101023", "story_v_out_304101.awb")

						arg_96_1:RecordAudio("304101023", var_99_11)
						arg_96_1:RecordAudio("304101023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_304101", "304101023", "story_v_out_304101.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_304101", "304101023", "story_v_out_304101.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play304101024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304101024
		arg_100_1.duration_ = 4.77

		local var_100_0 = {
			zh = 3.733,
			ja = 4.766
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
				arg_100_0:Play304101025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action425")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_103_0 = 0
			local var_103_1 = 0.4

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_2 = arg_100_1:GetWordFromCfg(304101024)
				local var_103_3 = arg_100_1:FormatText(var_103_2.content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 16 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 16)

				if (16 <= 0 and var_103_1 or var_103_1 * (utf8.len(var_103_3) / 16)) > 0 and var_103_1 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101024", "story_v_out_304101.awb") ~= 0 then
					local var_103_6 = manager.audio:GetVoiceLength("story_v_out_304101", "304101024", "story_v_out_304101.awb") / 1000

					if var_103_6 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_0
					end

					if var_103_2.prefab_name ~= "" and arg_100_1.actors_[var_103_2.prefab_name] ~= nil then
						local var_103_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_2.prefab_name].transform, "story_v_out_304101", "304101024", "story_v_out_304101.awb")

						arg_100_1:RecordAudio("304101024", var_103_7)
						arg_100_1:RecordAudio("304101024", var_103_7)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_304101", "304101024", "story_v_out_304101.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_304101", "304101024", "story_v_out_304101.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play304101025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304101025
		arg_104_1.duration_ = 11.2

		local var_104_0 = {
			zh = 6.833,
			ja = 11.2
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
				arg_104_0:Play304101026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if arg_104_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_107_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_104_1.stage_.transform)

				var_107_0.name = "1035ui_story"
				var_107_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["1035ui_story"] = var_107_0

				local var_107_1 = var_107_0:GetComponentInChildren(typeof(CharacterEffect))

				var_107_1.enabled = true

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end

				arg_104_1:ShowWeapon(var_107_1.transform, false)

				arg_104_1.var_["1035ui_story" .. "Animator"] = var_107_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_104_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_104_1.var_["1035ui_story" .. "LipSync"] = var_107_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_107_3 = arg_104_1.actors_["1035ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1035ui_story = var_107_3.localPosition
			end

			local var_107_4 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				var_107_3.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_104_1.time_ - 0) / var_107_4)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				var_107_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			local var_107_5 = arg_104_1.actors_["1148ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148ui_story = var_107_5.localPosition
			end

			local var_107_6 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_6 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_6)
				var_107_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_5.position).x, (manager.ui.mainCamera.transform.position - var_107_5.position).y, (manager.ui.mainCamera.transform.position - var_107_5.position).z)
				var_107_5.localEulerAngles.z = 0
				var_107_5.localEulerAngles.x = 0
				var_107_5.localEulerAngles = var_107_5.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_6 and arg_104_1.time_ < 0 + var_107_6 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(0, 100, 0)
				var_107_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_5.position).x, (manager.ui.mainCamera.transform.position - var_107_5.position).y, (manager.ui.mainCamera.transform.position - var_107_5.position).z)
				var_107_5.localEulerAngles.z = 0
				var_107_5.localEulerAngles.x = 0
				var_107_5.localEulerAngles = var_107_5.localEulerAngles
			end

			local var_107_7 = arg_104_1.actors_["1035ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1035ui_story == nil then
				arg_104_1.var_.characterEffect1035ui_story = var_107_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_8 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_8 and not isNil(var_107_7) then
				if arg_104_1.var_.characterEffect1035ui_story and not isNil(var_107_7) then
					arg_104_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_8 and arg_104_1.time_ < 0 + var_107_8 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1035ui_story then
				arg_104_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_107_10 = arg_104_1.actors_["1148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_10) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_11 and not isNil(var_107_10) then
				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_10) then
					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_11)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_11 and arg_104_1.time_ < 0 + var_107_11 + arg_107_0 and not isNil(var_107_10) and arg_104_1.var_.characterEffect1148ui_story then
				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_12 = 0
			local var_107_13 = 0.9

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:GetWordFromCfg(304101025)
				local var_107_15 = arg_104_1:FormatText(var_107_14.content)

				arg_104_1.text_.text = var_107_15

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_17 = 36 <= 0 and var_107_13 or var_107_13 * (utf8.len(var_107_15) / 36)

				if (36 <= 0 and var_107_13 or var_107_13 * (utf8.len(var_107_15) / 36)) > 0 and var_107_13 < var_107_17 then
					arg_104_1.talkMaxDuration = var_107_17

					if var_107_17 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_17 + var_107_12
					end
				end

				arg_104_1.text_.text = var_107_15
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101025", "story_v_out_304101.awb") ~= 0 then
					local var_107_18 = manager.audio:GetVoiceLength("story_v_out_304101", "304101025", "story_v_out_304101.awb") / 1000

					if var_107_18 + var_107_12 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_18 + var_107_12
					end

					if var_107_14.prefab_name ~= "" and arg_104_1.actors_[var_107_14.prefab_name] ~= nil then
						local var_107_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_14.prefab_name].transform, "story_v_out_304101", "304101025", "story_v_out_304101.awb")

						arg_104_1:RecordAudio("304101025", var_107_19)
						arg_104_1:RecordAudio("304101025", var_107_19)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_304101", "304101025", "story_v_out_304101.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_304101", "304101025", "story_v_out_304101.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_20 = math.max(var_107_13, arg_104_1.talkMaxDuration)

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_20 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_12) / var_107_20

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_12 + var_107_20 and arg_104_1.time_ < var_107_12 + var_107_20 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play304101026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304101026
		arg_108_1.duration_ = 5.7

		local var_108_0 = {
			zh = 5.7,
			ja = 5.233
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
				arg_108_0:Play304101027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.75

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(304101026)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 30 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 30)

				if (30 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 30)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101026", "story_v_out_304101.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_304101", "304101026", "story_v_out_304101.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_304101", "304101026", "story_v_out_304101.awb")

						arg_108_1:RecordAudio("304101026", var_111_6)
						arg_108_1:RecordAudio("304101026", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304101", "304101026", "story_v_out_304101.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304101", "304101026", "story_v_out_304101.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play304101027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304101027
		arg_112_1.duration_ = 5.33

		local var_112_0 = {
			zh = 4,
			ja = 5.333
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
				arg_112_0:Play304101028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1035ui_story = arg_112_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).z)
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles = arg_112_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1035ui_story"].transform.position).z)
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1035ui_story"].transform.localEulerAngles = arg_112_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1148ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1148ui_story = var_115_1.localPosition
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			local var_115_3 = arg_112_1.actors_["1148ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1148ui_story == nil then
				arg_112_1.var_.characterEffect1148ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect1148ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1148ui_story then
				arg_112_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_115_6 = arg_112_1.actors_["1035ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1035ui_story == nil then
				arg_112_1.var_.characterEffect1035ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect1035ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1035ui_story then
				arg_112_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_8 = 0
			local var_115_9 = 0.3

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(304101027)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 12 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 12)

				if (12 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 12)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101027", "story_v_out_304101.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_304101", "304101027", "story_v_out_304101.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_304101", "304101027", "story_v_out_304101.awb")

						arg_112_1:RecordAudio("304101027", var_115_15)
						arg_112_1:RecordAudio("304101027", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_304101", "304101027", "story_v_out_304101.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_304101", "304101027", "story_v_out_304101.awb")
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
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play304101028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 304101028
		arg_116_1.duration_ = 4.73

		local var_116_0 = {
			zh = 4.733,
			ja = 4.233
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
				arg_116_0:Play304101029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.475

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:GetWordFromCfg(304101028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 19 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 19)

				if (19 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 19)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101028", "story_v_out_304101.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_304101", "304101028", "story_v_out_304101.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_304101", "304101028", "story_v_out_304101.awb")

						arg_116_1:RecordAudio("304101028", var_119_6)
						arg_116_1:RecordAudio("304101028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_304101", "304101028", "story_v_out_304101.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_304101", "304101028", "story_v_out_304101.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play304101029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 304101029
		arg_120_1.duration_ = 5

		local var_120_0 = {
			zh = 3.466,
			ja = 5
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
				arg_120_0:Play304101030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1035ui_story = arg_120_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).z)
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles = arg_120_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1035ui_story"].transform.position).z)
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1035ui_story"].transform.localEulerAngles = arg_120_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1059ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1059ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0.7, -1.05, -6)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			local var_123_3 = arg_120_1.actors_["1059ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1059ui_story == nil then
				arg_120_1.var_.characterEffect1059ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect1059ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1059ui_story then
				arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_123_6 = arg_120_1.actors_["1148ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1148ui_story == nil then
				arg_120_1.var_.characterEffect1148ui_story = var_123_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_7 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 and not isNil(var_123_6) then
				if arg_120_1.var_.characterEffect1148ui_story and not isNil(var_123_6) then
					arg_120_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_7)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 and not isNil(var_123_6) and arg_120_1.var_.characterEffect1148ui_story then
				arg_120_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_2")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_8 = 0
			local var_123_9 = 0.375

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(304101029)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 15 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 15)

				if (15 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 15)) > 0 and var_123_9 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101029", "story_v_out_304101.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_304101", "304101029", "story_v_out_304101.awb") / 1000

					if var_123_14 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_8
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_304101", "304101029", "story_v_out_304101.awb")

						arg_120_1:RecordAudio("304101029", var_123_15)
						arg_120_1:RecordAudio("304101029", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_304101", "304101029", "story_v_out_304101.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_304101", "304101029", "story_v_out_304101.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_8) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_8 + var_123_16 and arg_120_1.time_ < var_123_8 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play304101030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 304101030
		arg_124_1.duration_ = 4.03

		local var_124_0 = {
			zh = 3.266,
			ja = 4.033
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
				arg_124_0:Play304101031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1148ui_story"]) and arg_124_1.var_.characterEffect1148ui_story == nil then
				arg_124_1.var_.characterEffect1148ui_story = arg_124_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1148ui_story"]) then
				if arg_124_1.var_.characterEffect1148ui_story and not isNil(arg_124_1.actors_["1148ui_story"]) then
					arg_124_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1148ui_story"]) and arg_124_1.var_.characterEffect1148ui_story then
				arg_124_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["1059ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1059ui_story == nil then
				arg_124_1.var_.characterEffect1059ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_3 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.characterEffect1059ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_3)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1059ui_story then
				arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_127_4 = 0
			local var_127_5 = 0.4

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(304101030)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 16 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 16)

				if (16 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 16)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101030", "story_v_out_304101.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101030", "story_v_out_304101.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_304101", "304101030", "story_v_out_304101.awb")

						arg_124_1:RecordAudio("304101030", var_127_11)
						arg_124_1:RecordAudio("304101030", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_304101", "304101030", "story_v_out_304101.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_304101", "304101030", "story_v_out_304101.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play304101031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 304101031
		arg_128_1.duration_ = 6.23

		local var_128_0 = {
			zh = 4.033,
			ja = 6.233
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
				arg_128_0:Play304101032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1059ui_story"]) and arg_128_1.var_.characterEffect1059ui_story == nil then
				arg_128_1.var_.characterEffect1059ui_story = arg_128_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1059ui_story"]) then
				if arg_128_1.var_.characterEffect1059ui_story and not isNil(arg_128_1.actors_["1059ui_story"]) then
					arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1059ui_story"]) and arg_128_1.var_.characterEffect1059ui_story then
				arg_128_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1148ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1148ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1148ui_story then
				arg_128_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_131_4 = 0
			local var_131_5 = 0.5

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(304101031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 20 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 20)

				if (20 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 20)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101031", "story_v_out_304101.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_304101", "304101031", "story_v_out_304101.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_304101", "304101031", "story_v_out_304101.awb")

						arg_128_1:RecordAudio("304101031", var_131_11)
						arg_128_1:RecordAudio("304101031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_304101", "304101031", "story_v_out_304101.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_304101", "304101031", "story_v_out_304101.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play304101032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 304101032
		arg_132_1.duration_ = 6.5

		local var_132_0 = {
			zh = 4.266,
			ja = 6.5
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
			arg_132_1.auto_ = false
		end

		function arg_132_1.playNext_(arg_134_0)
			arg_132_1.onStoryFinished_()
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_0 = 0
			local var_135_1 = 0.55

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(304101032)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 22 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 22)

				if (22 <= 0 and var_135_1 or var_135_1 * (utf8.len(var_135_3) / 22)) > 0 and var_135_1 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304101", "304101032", "story_v_out_304101.awb") ~= 0 then
					local var_135_6 = manager.audio:GetVoiceLength("story_v_out_304101", "304101032", "story_v_out_304101.awb") / 1000

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end

					if var_135_2.prefab_name ~= "" and arg_132_1.actors_[var_135_2.prefab_name] ~= nil then
						local var_135_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_2.prefab_name].transform, "story_v_out_304101", "304101032", "story_v_out_304101.awb")

						arg_132_1:RecordAudio("304101032", var_135_7)
						arg_132_1:RecordAudio("304101032", var_135_7)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_304101", "304101032", "story_v_out_304101.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_304101", "304101032", "story_v_out_304101.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_8 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_8 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_8

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_8 and arg_132_1.time_ < var_135_0 + var_135_8 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10"
	},
	voices = {
		"story_v_out_304101.awb"
	}
}
