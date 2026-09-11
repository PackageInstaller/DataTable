return {
	Play1104703001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104703001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104703002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST15 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_4_0.name = "ST15"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST15 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST15

				arg_1_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST15" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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
			local var_4_14 = 0.775

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

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1104703001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 31 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 31)

				if (31 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 31)) > 0 and var_4_14 < var_4_18 then
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
	Play1104703002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104703002
		arg_8_1.duration_ = 4.03

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104703003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.3

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(1104703002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 12 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 12)

				if (12 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 12)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703002", "story_v_side_new_1104703.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703002", "story_v_side_new_1104703.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_side_new_1104703", "1104703002", "story_v_side_new_1104703.awb")

						arg_8_1:RecordAudio("1104703002", var_11_6)
						arg_8_1:RecordAudio("1104703002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703002", "story_v_side_new_1104703.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703002", "story_v_side_new_1104703.awb")
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
	Play1104703003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104703003
		arg_12_1.duration_ = 6.5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104703004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_9001
			local var_15_9000

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_0 = arg_12_1.var_.effectshuihuasijian1

				if not arg_12_1.var_.effectshuihuasijian1 then
					var_15_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_15_0.name = "shuihuasijian1"
					arg_12_1.var_.effectshuihuasijian1 = var_15_0
				else
					var_15_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_15_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.499999999999 < arg_12_1.time_ and arg_12_1.time_ <= 1.499999999999 + arg_15_0 then
				local var_15_2 = arg_12_1.var_.effectshuihuasijian2

				if not arg_12_1.var_.effectshuihuasijian2 then
					var_15_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_15_2.name = "shuihuasijian2"
					arg_12_1.var_.effectshuihuasijian2 = var_15_2
				else
					var_15_2.transform:SetParent(var_15_9001)
				end

				var_15_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.9 < arg_12_1.time_ and arg_12_1.time_ <= 2.9 + arg_15_0 then
				if arg_12_1.var_.effectshuihuasijian2 then
					Object.Destroy(arg_12_1.var_.effectshuihuasijian2)

					arg_12_1.var_.effectshuihuasijian2 = nil
				end
			end

			if 1.5 < arg_12_1.time_ and arg_12_1.time_ <= 1.5 + arg_15_0 then
				if arg_12_1.var_.effectshuihuasijian1 then
					Object.Destroy(arg_12_1.var_.effectshuihuasijian1)

					arg_12_1.var_.effectshuihuasijian1 = nil
				end
			end

			if 0.633333333333333 < arg_12_1.time_ and arg_12_1.time_ <= 0.633333333333333 + arg_15_0 then
				local var_15_6 = arg_12_1.var_.effectshuihuasijian3

				if not arg_12_1.var_.effectshuihuasijian3 then
					var_15_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_15_6.name = "shuihuasijian3"
					arg_12_1.var_.effectshuihuasijian3 = var_15_6
				else
					var_15_6.transform:SetParent(var_15_9000)
				end

				var_15_6.transform.localPosition = Vector3.New(0, 0, -1.14)
				var_15_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.3 < arg_12_1.time_ and arg_12_1.time_ <= 0.3 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			local var_15_9 = 1.499999999999
			local var_15_10 = 0.925

			if 1.499999999999 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_11 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1104703003).content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 37 <= 0 and var_15_10 or var_15_10 * (utf8.len(var_15_11) / 37)

				if (37 <= 0 and var_15_10 or var_15_10 * (utf8.len(var_15_11) / 37)) > 0 and var_15_10 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_9 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_9
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_10, arg_12_1.talkMaxDuration)

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_9) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_9 + var_15_14 and arg_12_1.time_ < var_15_9 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1104703004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104703004
		arg_16_1.duration_ = 3.63

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104703005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.3

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(1104703004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 12 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 12)

				if (12 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 12)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703004", "story_v_side_new_1104703.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703004", "story_v_side_new_1104703.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_side_new_1104703", "1104703004", "story_v_side_new_1104703.awb")

						arg_16_1:RecordAudio("1104703004", var_19_6)
						arg_16_1:RecordAudio("1104703004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703004", "story_v_side_new_1104703.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703004", "story_v_side_new_1104703.awb")
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
	Play1104703005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104703005
		arg_20_1.duration_ = 3.73

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104703006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.2

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(1104703005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 8 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 8)

				if (8 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 8)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703005", "story_v_side_new_1104703.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703005", "story_v_side_new_1104703.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_side_new_1104703", "1104703005", "story_v_side_new_1104703.awb")

						arg_20_1:RecordAudio("1104703005", var_23_6)
						arg_20_1:RecordAudio("1104703005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703005", "story_v_side_new_1104703.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703005", "story_v_side_new_1104703.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1104703006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104703006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104703007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.825

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(1104703006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 33)

				if (33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 33)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104703007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104703007
		arg_28_1.duration_ = 6.1

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104703008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["104701ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104701ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "104701ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "104701ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["104701ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["104701ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["104701ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["104701ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["104701ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos104701ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			local var_31_5 = arg_28_1.actors_["104701ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect104701ui_story == nil then
				arg_28_1.var_.characterEffect104701ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect104701ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect104701ui_story then
				arg_28_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				if arg_28_1.var_.effectshuihuasijian3 then
					Object.Destroy(arg_28_1.var_.effectshuihuasijian3)

					arg_28_1.var_.effectshuihuasijian3 = nil
				end
			end

			local var_31_9 = 0
			local var_31_10 = 0.525

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
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

				local var_31_11 = arg_28_1:GetWordFromCfg(1104703007)
				local var_31_12 = arg_28_1:FormatText(var_31_11.content)

				arg_28_1.text_.text = var_31_12

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 21 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_12) / 21)

				if (21 <= 0 and var_31_10 or var_31_10 * (utf8.len(var_31_12) / 21)) > 0 and var_31_10 < var_31_14 then
					arg_28_1.talkMaxDuration = var_31_14

					if var_31_14 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_9
					end
				end

				arg_28_1.text_.text = var_31_12
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703007", "story_v_side_new_1104703.awb") ~= 0 then
					local var_31_15 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703007", "story_v_side_new_1104703.awb") / 1000

					if var_31_15 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_9
					end

					if var_31_11.prefab_name ~= "" and arg_28_1.actors_[var_31_11.prefab_name] ~= nil then
						local var_31_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_11.prefab_name].transform, "story_v_side_new_1104703", "1104703007", "story_v_side_new_1104703.awb")

						arg_28_1:RecordAudio("1104703007", var_31_16)
						arg_28_1:RecordAudio("1104703007", var_31_16)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703007", "story_v_side_new_1104703.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703007", "story_v_side_new_1104703.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_17 = math.max(var_31_10, arg_28_1.talkMaxDuration)

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_17 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_17

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_17 and arg_28_1.time_ < var_31_9 + var_31_17 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104703008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104703009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["104701ui_story"]) and arg_32_1.var_.characterEffect104701ui_story == nil then
				arg_32_1.var_.characterEffect104701ui_story = arg_32_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["104701ui_story"]) then
				if arg_32_1.var_.characterEffect104701ui_story and not isNil(arg_32_1.actors_["104701ui_story"]) then
					arg_32_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_32_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["104701ui_story"]) and arg_32_1.var_.characterEffect104701ui_story then
				arg_32_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_32_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.5

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

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(1104703008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 20 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 20)

				if (20 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 20)) > 0 and var_35_2 < var_35_5 then
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
	Play1104703009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104703009
		arg_36_1.duration_ = 3.7

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104703010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["104701ui_story"]) and arg_36_1.var_.characterEffect104701ui_story == nil then
				arg_36_1.var_.characterEffect104701ui_story = arg_36_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["104701ui_story"]) then
				if arg_36_1.var_.characterEffect104701ui_story and not isNil(arg_36_1.actors_["104701ui_story"]) then
					arg_36_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["104701ui_story"]) and arg_36_1.var_.characterEffect104701ui_story then
				arg_36_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.3

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(1104703009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 12 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 12)

				if (12 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 12)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703009", "story_v_side_new_1104703.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703009", "story_v_side_new_1104703.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_side_new_1104703", "1104703009", "story_v_side_new_1104703.awb")

						arg_36_1:RecordAudio("1104703009", var_39_9)
						arg_36_1:RecordAudio("1104703009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703009", "story_v_side_new_1104703.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703009", "story_v_side_new_1104703.awb")
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
	Play1104703010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104703010
		arg_40_1.duration_ = 7.63

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104703011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_0 = 0
			local var_43_1 = 0.65

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
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

				local var_43_2 = arg_40_1:GetWordFromCfg(1104703010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 26 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 26)

				if (26 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 26)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703010", "story_v_side_new_1104703.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703010", "story_v_side_new_1104703.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_side_new_1104703", "1104703010", "story_v_side_new_1104703.awb")

						arg_40_1:RecordAudio("1104703010", var_43_7)
						arg_40_1:RecordAudio("1104703010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703010", "story_v_side_new_1104703.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703010", "story_v_side_new_1104703.awb")
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
	Play1104703011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104703011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104703012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["104701ui_story"]) and arg_44_1.var_.characterEffect104701ui_story == nil then
				arg_44_1.var_.characterEffect104701ui_story = arg_44_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["104701ui_story"]) then
				if arg_44_1.var_.characterEffect104701ui_story and not isNil(arg_44_1.actors_["104701ui_story"]) then
					arg_44_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_44_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["104701ui_story"]) and arg_44_1.var_.characterEffect104701ui_story then
				arg_44_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_44_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.05

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

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1104703011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 2 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 2)

				if (2 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 2)) > 0 and var_47_2 < var_47_5 then
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
	Play1104703012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104703012
		arg_48_1.duration_ = 3.13

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104703013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["104701ui_story"]) and arg_48_1.var_.characterEffect104701ui_story == nil then
				arg_48_1.var_.characterEffect104701ui_story = arg_48_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["104701ui_story"]) then
				if arg_48_1.var_.characterEffect104701ui_story and not isNil(arg_48_1.actors_["104701ui_story"]) then
					arg_48_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["104701ui_story"]) and arg_48_1.var_.characterEffect104701ui_story then
				arg_48_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.2

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

				local var_51_4 = arg_48_1:GetWordFromCfg(1104703012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 8 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 8)

				if (8 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 8)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703012", "story_v_side_new_1104703.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703012", "story_v_side_new_1104703.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_side_new_1104703", "1104703012", "story_v_side_new_1104703.awb")

						arg_48_1:RecordAudio("1104703012", var_51_9)
						arg_48_1:RecordAudio("1104703012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703012", "story_v_side_new_1104703.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703012", "story_v_side_new_1104703.awb")
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
	Play1104703013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104703013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104703014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["104701ui_story"]) and arg_52_1.var_.characterEffect104701ui_story == nil then
				arg_52_1.var_.characterEffect104701ui_story = arg_52_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["104701ui_story"]) then
				if arg_52_1.var_.characterEffect104701ui_story and not isNil(arg_52_1.actors_["104701ui_story"]) then
					arg_52_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_52_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["104701ui_story"]) and arg_52_1.var_.characterEffect104701ui_story then
				arg_52_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_52_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.175

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
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

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(1104703013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 7 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 7)

				if (7 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 7)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104703014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104703014
		arg_56_1.duration_ = 7.93

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104703015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["104701ui_story"]) and arg_56_1.var_.characterEffect104701ui_story == nil then
				arg_56_1.var_.characterEffect104701ui_story = arg_56_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["104701ui_story"]) then
				if arg_56_1.var_.characterEffect104701ui_story and not isNil(arg_56_1.actors_["104701ui_story"]) then
					arg_56_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["104701ui_story"]) and arg_56_1.var_.characterEffect104701ui_story then
				arg_56_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action429")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.875

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(1104703014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 35 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 35)

				if (35 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 35)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703014", "story_v_side_new_1104703.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703014", "story_v_side_new_1104703.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_side_new_1104703", "1104703014", "story_v_side_new_1104703.awb")

						arg_56_1:RecordAudio("1104703014", var_59_9)
						arg_56_1:RecordAudio("1104703014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703014", "story_v_side_new_1104703.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703014", "story_v_side_new_1104703.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104703015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104703015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104703016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["104701ui_story"]) and arg_60_1.var_.characterEffect104701ui_story == nil then
				arg_60_1.var_.characterEffect104701ui_story = arg_60_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["104701ui_story"]) then
				if arg_60_1.var_.characterEffect104701ui_story and not isNil(arg_60_1.actors_["104701ui_story"]) then
					arg_60_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_60_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["104701ui_story"]) and arg_60_1.var_.characterEffect104701ui_story then
				arg_60_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_60_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.075

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

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(1104703015).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 3 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 3)

				if (3 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 3)) > 0 and var_63_2 < var_63_5 then
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
	Play1104703016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104703016
		arg_64_1.duration_ = 7.93

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104703017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos104701ui_story = arg_64_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).z)
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles = arg_64_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_64_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["104701ui_story"].transform.position).z)
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["104701ui_story"].transform.localEulerAngles = arg_64_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["104701ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect104701ui_story == nil then
				arg_64_1.var_.characterEffect104701ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect104701ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect104701ui_story then
				arg_64_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_4 = 0
			local var_67_5 = 0.675

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(1104703016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 27 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 27)

				if (27 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 27)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703016", "story_v_side_new_1104703.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703016", "story_v_side_new_1104703.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_side_new_1104703", "1104703016", "story_v_side_new_1104703.awb")

						arg_64_1:RecordAudio("1104703016", var_67_11)
						arg_64_1:RecordAudio("1104703016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703016", "story_v_side_new_1104703.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703016", "story_v_side_new_1104703.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104703017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104703017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104703018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["104701ui_story"]) and arg_68_1.var_.characterEffect104701ui_story == nil then
				arg_68_1.var_.characterEffect104701ui_story = arg_68_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["104701ui_story"]) then
				if arg_68_1.var_.characterEffect104701ui_story and not isNil(arg_68_1.actors_["104701ui_story"]) then
					arg_68_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_68_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["104701ui_story"]) and arg_68_1.var_.characterEffect104701ui_story then
				arg_68_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_68_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.2

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(1104703017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 8 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 8)

				if (8 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 8)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104703018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104703018
		arg_72_1.duration_ = 6

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104703019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["104701ui_story"]) and arg_72_1.var_.characterEffect104701ui_story == nil then
				arg_72_1.var_.characterEffect104701ui_story = arg_72_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["104701ui_story"]) then
				if arg_72_1.var_.characterEffect104701ui_story and not isNil(arg_72_1.actors_["104701ui_story"]) then
					arg_72_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["104701ui_story"]) and arg_72_1.var_.characterEffect104701ui_story then
				arg_72_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.675

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(1104703018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 27 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 27)

				if (27 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 27)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703018", "story_v_side_new_1104703.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703018", "story_v_side_new_1104703.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_side_new_1104703", "1104703018", "story_v_side_new_1104703.awb")

						arg_72_1:RecordAudio("1104703018", var_75_9)
						arg_72_1:RecordAudio("1104703018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703018", "story_v_side_new_1104703.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703018", "story_v_side_new_1104703.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104703019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104703019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104703020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["104701ui_story"]) and arg_76_1.var_.characterEffect104701ui_story == nil then
				arg_76_1.var_.characterEffect104701ui_story = arg_76_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["104701ui_story"]) then
				if arg_76_1.var_.characterEffect104701ui_story and not isNil(arg_76_1.actors_["104701ui_story"]) then
					arg_76_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_76_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["104701ui_story"]) and arg_76_1.var_.characterEffect104701ui_story then
				arg_76_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_76_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(1104703019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 16 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 16)

				if (16 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 16)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1104703020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104703020
		arg_80_1.duration_ = 4.47

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104703021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["104701ui_story"]) and arg_80_1.var_.characterEffect104701ui_story == nil then
				arg_80_1.var_.characterEffect104701ui_story = arg_80_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["104701ui_story"]) then
				if arg_80_1.var_.characterEffect104701ui_story and not isNil(arg_80_1.actors_["104701ui_story"]) then
					arg_80_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["104701ui_story"]) and arg_80_1.var_.characterEffect104701ui_story then
				arg_80_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_2 = 0
			local var_83_3 = 0.525

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(1104703020)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 21 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 21)

				if (21 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 21)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703020", "story_v_side_new_1104703.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703020", "story_v_side_new_1104703.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_side_new_1104703", "1104703020", "story_v_side_new_1104703.awb")

						arg_80_1:RecordAudio("1104703020", var_83_9)
						arg_80_1:RecordAudio("1104703020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703020", "story_v_side_new_1104703.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703020", "story_v_side_new_1104703.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104703021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104703021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1104703022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["104701ui_story"]) and arg_84_1.var_.characterEffect104701ui_story == nil then
				arg_84_1.var_.characterEffect104701ui_story = arg_84_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["104701ui_story"]) then
				if arg_84_1.var_.characterEffect104701ui_story and not isNil(arg_84_1.actors_["104701ui_story"]) then
					arg_84_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_84_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["104701ui_story"]) and arg_84_1.var_.characterEffect104701ui_story then
				arg_84_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_84_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_87_1 = arg_84_1.actors_["104701ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos104701ui_story = var_87_1.localPosition
			end

			local var_87_2 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_2)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			local var_87_3 = 0
			local var_87_4 = 0.675

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(1104703021).content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 27 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 27)

				if (27 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 27)) > 0 and var_87_4 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_3 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_3
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_4, arg_84_1.talkMaxDuration)

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_3) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_3 + var_87_8 and arg_84_1.time_ < var_87_3 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104703022
		arg_88_1.duration_ = 8.07

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104703023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos104701ui_story = arg_88_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).z)
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles = arg_88_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_88_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["104701ui_story"].transform.position).z)
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["104701ui_story"].transform.localEulerAngles = arg_88_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["104701ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect104701ui_story == nil then
				arg_88_1.var_.characterEffect104701ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect104701ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect104701ui_story then
				arg_88_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_91_4 = 0
			local var_91_5 = 0.8

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(1104703022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 32 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 32)

				if (32 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 32)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703022", "story_v_side_new_1104703.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703022", "story_v_side_new_1104703.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_side_new_1104703", "1104703022", "story_v_side_new_1104703.awb")

						arg_88_1:RecordAudio("1104703022", var_91_11)
						arg_88_1:RecordAudio("1104703022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703022", "story_v_side_new_1104703.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703022", "story_v_side_new_1104703.awb")
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

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104703023
		arg_92_1.duration_ = 10.3

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104703024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos104701ui_story = arg_92_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).z)
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles = arg_92_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_92_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["104701ui_story"].transform.position).z)
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["104701ui_story"].transform.localEulerAngles = arg_92_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action434")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_95_1 = 0
			local var_95_2 = 1.2

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
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

				local var_95_3 = arg_92_1:GetWordFromCfg(1104703023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 48 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 48)

				if (48 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 48)) > 0 and var_95_2 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703023", "story_v_side_new_1104703.awb") ~= 0 then
					local var_95_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703023", "story_v_side_new_1104703.awb") / 1000

					if var_95_7 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_1
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_side_new_1104703", "1104703023", "story_v_side_new_1104703.awb")

						arg_92_1:RecordAudio("1104703023", var_95_8)
						arg_92_1:RecordAudio("1104703023", var_95_8)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703023", "story_v_side_new_1104703.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703023", "story_v_side_new_1104703.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_9 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_9 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_9

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_9 and arg_92_1.time_ < var_95_1 + var_95_9 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104703024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104703025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["104701ui_story"]) and arg_96_1.var_.characterEffect104701ui_story == nil then
				arg_96_1.var_.characterEffect104701ui_story = arg_96_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["104701ui_story"]) then
				if arg_96_1.var_.characterEffect104701ui_story and not isNil(arg_96_1.actors_["104701ui_story"]) then
					arg_96_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_96_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["104701ui_story"]) and arg_96_1.var_.characterEffect104701ui_story then
				arg_96_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_96_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.55

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

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(1104703024).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 22 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 22)

				if (22 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 22)) > 0 and var_99_2 < var_99_5 then
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
	Play1104703025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104703025
		arg_100_1.duration_ = 4.3

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104703026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["104701ui_story"]) and arg_100_1.var_.characterEffect104701ui_story == nil then
				arg_100_1.var_.characterEffect104701ui_story = arg_100_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["104701ui_story"]) then
				if arg_100_1.var_.characterEffect104701ui_story and not isNil(arg_100_1.actors_["104701ui_story"]) then
					arg_100_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["104701ui_story"]) and arg_100_1.var_.characterEffect104701ui_story then
				arg_100_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action446")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.4

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

				local var_103_4 = arg_100_1:GetWordFromCfg(1104703025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 16 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 16)

				if (16 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 16)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703025", "story_v_side_new_1104703.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703025", "story_v_side_new_1104703.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_side_new_1104703", "1104703025", "story_v_side_new_1104703.awb")

						arg_100_1:RecordAudio("1104703025", var_103_9)
						arg_100_1:RecordAudio("1104703025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703025", "story_v_side_new_1104703.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703025", "story_v_side_new_1104703.awb")
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
	Play1104703026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104703026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104703027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["104701ui_story"]) and arg_104_1.var_.characterEffect104701ui_story == nil then
				arg_104_1.var_.characterEffect104701ui_story = arg_104_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["104701ui_story"]) then
				if arg_104_1.var_.characterEffect104701ui_story and not isNil(arg_104_1.actors_["104701ui_story"]) then
					arg_104_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_104_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["104701ui_story"]) and arg_104_1.var_.characterEffect104701ui_story then
				arg_104_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_104_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_107_1 = arg_104_1.actors_["104701ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos104701ui_story = var_107_1.localPosition
			end

			local var_107_2 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 then
				var_107_1.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_2)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 then
				var_107_1.localPosition = Vector3.New(0, 100, 0)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles
			end

			local var_107_3 = 0
			local var_107_4 = 1.025

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_3 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_5 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(1104703026).content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 41 <= 0 and var_107_4 or var_107_4 * (utf8.len(var_107_5) / 41)

				if (41 <= 0 and var_107_4 or var_107_4 * (utf8.len(var_107_5) / 41)) > 0 and var_107_4 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_3 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_3
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_4, arg_104_1.talkMaxDuration)

			if var_107_3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_3 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_3) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_3 + var_107_8 and arg_104_1.time_ < var_107_3 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104703027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1104703028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(1104703027).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 25 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 25)

				if (25 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 25)) > 0 and var_111_0 < var_111_3 then
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
	Play1104703028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104703028
		arg_112_1.duration_ = 8.3

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104703029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos104701ui_story = arg_112_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).z)
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles = arg_112_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_112_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["104701ui_story"].transform.position).z)
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["104701ui_story"].transform.localEulerAngles = arg_112_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["104701ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect104701ui_story == nil then
				arg_112_1.var_.characterEffect104701ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect104701ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect104701ui_story then
				arg_112_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_4 = 0
			local var_115_5 = 0.975

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(1104703028)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 39 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 39)

				if (39 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 39)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703028", "story_v_side_new_1104703.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703028", "story_v_side_new_1104703.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_side_new_1104703", "1104703028", "story_v_side_new_1104703.awb")

						arg_112_1:RecordAudio("1104703028", var_115_11)
						arg_112_1:RecordAudio("1104703028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703028", "story_v_side_new_1104703.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703028", "story_v_side_new_1104703.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104703029
		arg_116_1.duration_ = 6.5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104703030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_0 = 0
			local var_119_1 = 0.775

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(1104703029)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 31 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 31)

				if (31 <= 0 and var_119_1 or var_119_1 * (utf8.len(var_119_3) / 31)) > 0 and var_119_1 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703029", "story_v_side_new_1104703.awb") ~= 0 then
					local var_119_6 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703029", "story_v_side_new_1104703.awb") / 1000

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end

					if var_119_2.prefab_name ~= "" and arg_116_1.actors_[var_119_2.prefab_name] ~= nil then
						local var_119_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_2.prefab_name].transform, "story_v_side_new_1104703", "1104703029", "story_v_side_new_1104703.awb")

						arg_116_1:RecordAudio("1104703029", var_119_7)
						arg_116_1:RecordAudio("1104703029", var_119_7)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703029", "story_v_side_new_1104703.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703029", "story_v_side_new_1104703.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_8 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_8 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_8

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_8 and arg_116_1.time_ < var_119_0 + var_119_8 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104703030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104703030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104703031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["104701ui_story"]) and arg_120_1.var_.characterEffect104701ui_story == nil then
				arg_120_1.var_.characterEffect104701ui_story = arg_120_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["104701ui_story"]) then
				if arg_120_1.var_.characterEffect104701ui_story and not isNil(arg_120_1.actors_["104701ui_story"]) then
					arg_120_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_120_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["104701ui_story"]) and arg_120_1.var_.characterEffect104701ui_story then
				arg_120_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_120_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["104701ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos104701ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, 100, 0)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if 0.8 < arg_120_1.time_ and arg_120_1.time_ <= 0.8 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_148", "se_story_148_foley_gun_drop", "")
			end

			local var_123_4 = 0
			local var_123_5 = 0.8

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(1104703030).content)

				arg_120_1.text_.text = var_123_6

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_8 = 32 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_6) / 32)

				if (32 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_6) / 32)) > 0 and var_123_5 < var_123_8 then
					arg_120_1.talkMaxDuration = var_123_8

					if var_123_8 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_6
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_9 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_9 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_9

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_9 and arg_120_1.time_ < var_123_4 + var_123_9 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104703031
		arg_124_1.duration_ = 4.1

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104703032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.5

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(1104703031)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 20 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 20)

				if (20 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 20)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703031", "story_v_side_new_1104703.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703031", "story_v_side_new_1104703.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_side_new_1104703", "1104703031", "story_v_side_new_1104703.awb")

						arg_124_1:RecordAudio("1104703031", var_127_6)
						arg_124_1:RecordAudio("1104703031", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703031", "story_v_side_new_1104703.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703031", "story_v_side_new_1104703.awb")
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
	Play1104703032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104703032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104703033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.825

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(1104703032).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 33 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 33)

				if (33 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 33)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104703033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1104703033
		arg_132_1.duration_ = 3.43

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1104703034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos104701ui_story = arg_132_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).z)
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles = arg_132_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_132_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["104701ui_story"].transform.position).z)
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["104701ui_story"].transform.localEulerAngles = arg_132_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["104701ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect104701ui_story == nil then
				arg_132_1.var_.characterEffect104701ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect104701ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect104701ui_story then
				arg_132_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_4 = 0
			local var_135_5 = 0.325

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(1104703033)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 13 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 13)

				if (13 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 13)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703033", "story_v_side_new_1104703.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703033", "story_v_side_new_1104703.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_side_new_1104703", "1104703033", "story_v_side_new_1104703.awb")

						arg_132_1:RecordAudio("1104703033", var_135_11)
						arg_132_1:RecordAudio("1104703033", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703033", "story_v_side_new_1104703.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703033", "story_v_side_new_1104703.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play1104703034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1104703034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1104703035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["104701ui_story"]) and arg_136_1.var_.characterEffect104701ui_story == nil then
				arg_136_1.var_.characterEffect104701ui_story = arg_136_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["104701ui_story"]) then
				if arg_136_1.var_.characterEffect104701ui_story and not isNil(arg_136_1.actors_["104701ui_story"]) then
					arg_136_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_136_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["104701ui_story"]) and arg_136_1.var_.characterEffect104701ui_story then
				arg_136_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_136_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.425

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(1104703034).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 17 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 17)

				if (17 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 17)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1104703035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1104703035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1104703036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos104701ui_story = arg_140_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).z)
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles = arg_140_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["104701ui_story"].transform.position).z)
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["104701ui_story"].transform.localEulerAngles = arg_140_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_143_1 = 0
			local var_143_2 = 0.925

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1104703035).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 37 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 37)

				if (37 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 37)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play1104703036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1104703036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1104703037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 1.425

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1104703036).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 57 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 57)

				if (57 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 57)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1104703037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1104703037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1104703038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.175

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(1104703037).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 7 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 7)

				if (7 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 7)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1104703038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104703038
		arg_152_1.duration_ = 3.77

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1104703039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos104701ui_story = arg_152_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).z)
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles = arg_152_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_152_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["104701ui_story"].transform.position).z)
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["104701ui_story"].transform.localEulerAngles = arg_152_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["104701ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect104701ui_story == nil then
				arg_152_1.var_.characterEffect104701ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect104701ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect104701ui_story then
				arg_152_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.375

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(1104703038)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 15 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 15)

				if (15 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 15)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703038", "story_v_side_new_1104703.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703038", "story_v_side_new_1104703.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_side_new_1104703", "1104703038", "story_v_side_new_1104703.awb")

						arg_152_1:RecordAudio("1104703038", var_155_11)
						arg_152_1:RecordAudio("1104703038", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703038", "story_v_side_new_1104703.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703038", "story_v_side_new_1104703.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play1104703039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104703039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104703040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["104701ui_story"]) and arg_156_1.var_.characterEffect104701ui_story == nil then
				arg_156_1.var_.characterEffect104701ui_story = arg_156_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["104701ui_story"]) then
				if arg_156_1.var_.characterEffect104701ui_story and not isNil(arg_156_1.actors_["104701ui_story"]) then
					arg_156_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_156_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["104701ui_story"]) and arg_156_1.var_.characterEffect104701ui_story then
				arg_156_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_156_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.2

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(1104703039).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 8 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 8)

				if (8 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 8)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104703040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104703040
		arg_160_1.duration_ = 5.27

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104703041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos104701ui_story = arg_160_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).z)
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles = arg_160_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_160_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["104701ui_story"].transform.position).z)
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["104701ui_story"].transform.localEulerAngles = arg_160_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["104701ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect104701ui_story == nil then
				arg_160_1.var_.characterEffect104701ui_story = var_163_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 and not isNil(var_163_1) then
				if arg_160_1.var_.characterEffect104701ui_story and not isNil(var_163_1) then
					arg_160_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect104701ui_story then
				arg_160_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_163_4 = 0
			local var_163_5 = 0.6

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_6 = arg_160_1:GetWordFromCfg(1104703040)
				local var_163_7 = arg_160_1:FormatText(var_163_6.content)

				arg_160_1.text_.text = var_163_7

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 24 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 24)

				if (24 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_7) / 24)) > 0 and var_163_5 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_7
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703040", "story_v_side_new_1104703.awb") ~= 0 then
					local var_163_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703040", "story_v_side_new_1104703.awb") / 1000

					if var_163_10 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_4
					end

					if var_163_6.prefab_name ~= "" and arg_160_1.actors_[var_163_6.prefab_name] ~= nil then
						local var_163_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_6.prefab_name].transform, "story_v_side_new_1104703", "1104703040", "story_v_side_new_1104703.awb")

						arg_160_1:RecordAudio("1104703040", var_163_11)
						arg_160_1:RecordAudio("1104703040", var_163_11)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703040", "story_v_side_new_1104703.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703040", "story_v_side_new_1104703.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_12 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_12 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_12

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_12 and arg_160_1.time_ < var_163_4 + var_163_12 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104703041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1104703041
		arg_164_1.duration_ = 1

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"

			SetActive(arg_164_1.choicesGo_, true)

			for iter_165_0, iter_165_1 in ipairs(arg_164_1.choices_) do
				SetActive(iter_165_1.go, iter_165_0 <= 2)
			end

			arg_164_1.choices_[1].txt.text = arg_164_1:FormatText(StoryChoiceCfg[1655].name)
			arg_164_1.choices_[2].txt.text = arg_164_1:FormatText(StoryChoiceCfg[1656].name)
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1104703042(arg_164_1)
			end

			if arg_166_0 == 2 then
				arg_164_0:Play1104703043(arg_164_1)
			end

			arg_164_1:RecordChoiceLog(1104703041, 1655, 1656)
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["104701ui_story"]) and arg_164_1.var_.characterEffect104701ui_story == nil then
				arg_164_1.var_.characterEffect104701ui_story = arg_164_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["104701ui_story"]) then
				if arg_164_1.var_.characterEffect104701ui_story and not isNil(arg_164_1.actors_["104701ui_story"]) then
					arg_164_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["104701ui_story"]) and arg_164_1.var_.characterEffect104701ui_story then
				arg_164_1.var_.characterEffect104701ui_story.fillFlat = false
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1104703042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1104703042
		arg_168_1.duration_ = 4.03

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1104703044(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos104701ui_story = arg_168_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).z)
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles = arg_168_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_168_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["104701ui_story"].transform.position).z)
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["104701ui_story"].transform.localEulerAngles = arg_168_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["104701ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect104701ui_story == nil then
				arg_168_1.var_.characterEffect104701ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect104701ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect104701ui_story then
				arg_168_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_4 = 0
			local var_171_5 = 0.475

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(1104703042)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 19 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 19)

				if (19 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 19)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703042", "story_v_side_new_1104703.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703042", "story_v_side_new_1104703.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_side_new_1104703", "1104703042", "story_v_side_new_1104703.awb")

						arg_168_1:RecordAudio("1104703042", var_171_11)
						arg_168_1:RecordAudio("1104703042", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703042", "story_v_side_new_1104703.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703042", "story_v_side_new_1104703.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play1104703044 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1104703044
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1104703045(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["104701ui_story"]) and arg_172_1.var_.characterEffect104701ui_story == nil then
				arg_172_1.var_.characterEffect104701ui_story = arg_172_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["104701ui_story"]) then
				if arg_172_1.var_.characterEffect104701ui_story and not isNil(arg_172_1.actors_["104701ui_story"]) then
					arg_172_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_172_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["104701ui_story"]) and arg_172_1.var_.characterEffect104701ui_story then
				arg_172_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_172_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_175_1 = arg_172_1.actors_["104701ui_story"].transform

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos104701ui_story = var_175_1.localPosition
			end

			local var_175_2 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 then
				var_175_1.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_2)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 then
				var_175_1.localPosition = Vector3.New(0, 100, 0)
				var_175_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_175_1.position).x, (manager.ui.mainCamera.transform.position - var_175_1.position).y, (manager.ui.mainCamera.transform.position - var_175_1.position).z)
				var_175_1.localEulerAngles.z = 0
				var_175_1.localEulerAngles.x = 0
				var_175_1.localEulerAngles = var_175_1.localEulerAngles
			end

			if 0.3 < arg_172_1.time_ and arg_172_1.time_ <= 0.3 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_175_4 = 0
			local var_175_5 = 0.55

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(1104703044).content)

				arg_172_1.text_.text = var_175_6

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_8 = 22 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_6) / 22)

				if (22 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_6) / 22)) > 0 and var_175_5 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_6
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_9 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_9 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_9

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_9 and arg_172_1.time_ < var_175_4 + var_175_9 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1104703045 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1104703045
		arg_176_1.duration_ = 4.67

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1104703046(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos104701ui_story = arg_176_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).z)
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles = arg_176_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_176_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["104701ui_story"].transform.position).z)
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["104701ui_story"].transform.localEulerAngles = arg_176_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["104701ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect104701ui_story == nil then
				arg_176_1.var_.characterEffect104701ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect104701ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect104701ui_story then
				arg_176_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_179_4 = 0
			local var_179_5 = 0.5

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(1104703045)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 20 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 20)

				if (20 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 20)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703045", "story_v_side_new_1104703.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703045", "story_v_side_new_1104703.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_side_new_1104703", "1104703045", "story_v_side_new_1104703.awb")

						arg_176_1:RecordAudio("1104703045", var_179_11)
						arg_176_1:RecordAudio("1104703045", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703045", "story_v_side_new_1104703.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703045", "story_v_side_new_1104703.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play1104703046 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104703046
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1104703047(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["104701ui_story"]) and arg_180_1.var_.characterEffect104701ui_story == nil then
				arg_180_1.var_.characterEffect104701ui_story = arg_180_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["104701ui_story"]) then
				if arg_180_1.var_.characterEffect104701ui_story and not isNil(arg_180_1.actors_["104701ui_story"]) then
					arg_180_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_180_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["104701ui_story"]) and arg_180_1.var_.characterEffect104701ui_story then
				arg_180_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_180_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.5

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(1104703046).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 20 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 20)

				if (20 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 20)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104703047 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1104703047
		arg_184_1.duration_ = 5.93

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1104703048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["104701ui_story"]) and arg_184_1.var_.characterEffect104701ui_story == nil then
				arg_184_1.var_.characterEffect104701ui_story = arg_184_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["104701ui_story"]) then
				if arg_184_1.var_.characterEffect104701ui_story and not isNil(arg_184_1.actors_["104701ui_story"]) then
					arg_184_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["104701ui_story"]) and arg_184_1.var_.characterEffect104701ui_story then
				arg_184_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_187_2 = 0
			local var_187_3 = 0.725

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(1104703047)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 29 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 29)

				if (29 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 29)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703047", "story_v_side_new_1104703.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703047", "story_v_side_new_1104703.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_side_new_1104703", "1104703047", "story_v_side_new_1104703.awb")

						arg_184_1:RecordAudio("1104703047", var_187_9)
						arg_184_1:RecordAudio("1104703047", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703047", "story_v_side_new_1104703.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703047", "story_v_side_new_1104703.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1104703048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1104703048
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1104703049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["104701ui_story"]) and arg_188_1.var_.characterEffect104701ui_story == nil then
				arg_188_1.var_.characterEffect104701ui_story = arg_188_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["104701ui_story"]) then
				if arg_188_1.var_.characterEffect104701ui_story and not isNil(arg_188_1.actors_["104701ui_story"]) then
					arg_188_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_188_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["104701ui_story"]) and arg_188_1.var_.characterEffect104701ui_story then
				arg_188_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_188_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.625

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(1104703048).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 25 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 25)

				if (25 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 25)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1104703049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1104703049
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1104703050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.55

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(1104703049).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 22 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 22)

				if (22 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 22)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1104703050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1104703050
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1104703051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.175

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_1 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(1104703050).content)

				arg_196_1.text_.text = var_199_1

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_3 = 7 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 7)

				if (7 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 7)) > 0 and var_199_0 < var_199_3 then
					arg_196_1.talkMaxDuration = var_199_3

					if var_199_3 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_3 + 0
					end
				end

				arg_196_1.text_.text = var_199_1
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_4 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_4

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1104703051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1104703051
		arg_200_1.duration_ = 2.9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1104703052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["104701ui_story"]) and arg_200_1.var_.characterEffect104701ui_story == nil then
				arg_200_1.var_.characterEffect104701ui_story = arg_200_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["104701ui_story"]) then
				if arg_200_1.var_.characterEffect104701ui_story and not isNil(arg_200_1.actors_["104701ui_story"]) then
					arg_200_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["104701ui_story"]) and arg_200_1.var_.characterEffect104701ui_story then
				arg_200_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_2 = 0
			local var_203_3 = 0.325

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_2 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_4 = arg_200_1:GetWordFromCfg(1104703051)
				local var_203_5 = arg_200_1:FormatText(var_203_4.content)

				arg_200_1.text_.text = var_203_5

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_7 = 13 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_5) / 13)

				if (13 <= 0 and var_203_3 or var_203_3 * (utf8.len(var_203_5) / 13)) > 0 and var_203_3 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_2
					end
				end

				arg_200_1.text_.text = var_203_5
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703051", "story_v_side_new_1104703.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703051", "story_v_side_new_1104703.awb") / 1000

					if var_203_8 + var_203_2 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_2
					end

					if var_203_4.prefab_name ~= "" and arg_200_1.actors_[var_203_4.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_4.prefab_name].transform, "story_v_side_new_1104703", "1104703051", "story_v_side_new_1104703.awb")

						arg_200_1:RecordAudio("1104703051", var_203_9)
						arg_200_1:RecordAudio("1104703051", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703051", "story_v_side_new_1104703.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703051", "story_v_side_new_1104703.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_3, arg_200_1.talkMaxDuration)

			if var_203_2 <= arg_200_1.time_ and arg_200_1.time_ < var_203_2 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_2) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_2 + var_203_10 and arg_200_1.time_ < var_203_2 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1104703052 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1104703052
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1104703053(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["104701ui_story"]) and arg_204_1.var_.characterEffect104701ui_story == nil then
				arg_204_1.var_.characterEffect104701ui_story = arg_204_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["104701ui_story"]) then
				if arg_204_1.var_.characterEffect104701ui_story and not isNil(arg_204_1.actors_["104701ui_story"]) then
					arg_204_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_204_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["104701ui_story"]) and arg_204_1.var_.characterEffect104701ui_story then
				arg_204_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_204_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_207_1 = arg_204_1.actors_["104701ui_story"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos104701ui_story = var_207_1.localPosition
			end

			local var_207_2 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 then
				var_207_1.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_204_1.time_ - 0) / var_207_2)
				var_207_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_1.position).x, (manager.ui.mainCamera.transform.position - var_207_1.position).y, (manager.ui.mainCamera.transform.position - var_207_1.position).z)
				var_207_1.localEulerAngles.z = 0
				var_207_1.localEulerAngles.x = 0
				var_207_1.localEulerAngles = var_207_1.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 then
				var_207_1.localPosition = Vector3.New(0, 100, 0)
				var_207_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_207_1.position).x, (manager.ui.mainCamera.transform.position - var_207_1.position).y, (manager.ui.mainCamera.transform.position - var_207_1.position).z)
				var_207_1.localEulerAngles.z = 0
				var_207_1.localEulerAngles.x = 0
				var_207_1.localEulerAngles = var_207_1.localEulerAngles
			end

			if 0.1 < arg_204_1.time_ and arg_204_1.time_ <= 0.1 + arg_207_0 then
				arg_204_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep_sand", "")
			end

			local var_207_4 = 0
			local var_207_5 = 0.525

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(1104703052).content)

				arg_204_1.text_.text = var_207_6

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_8 = 21 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_6) / 21)

				if (21 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_6) / 21)) > 0 and var_207_5 < var_207_8 then
					arg_204_1.talkMaxDuration = var_207_8

					if var_207_8 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_6
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_9 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_9 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_9

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_9 and arg_204_1.time_ < var_207_4 + var_207_9 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play1104703053 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1104703053
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1104703054(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.1

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(1104703053).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 4 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 4)

				if (4 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 4)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1104703054 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1104703054
		arg_212_1.duration_ = 7.6

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1104703055(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos104701ui_story = arg_212_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).z)
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles = arg_212_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_212_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["104701ui_story"].transform.position).z)
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["104701ui_story"].transform.localEulerAngles = arg_212_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["104701ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect104701ui_story == nil then
				arg_212_1.var_.characterEffect104701ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect104701ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect104701ui_story then
				arg_212_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_215_4 = 0
			local var_215_5 = 0.775

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(1104703054)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 31 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 31)

				if (31 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 31)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703054", "story_v_side_new_1104703.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703054", "story_v_side_new_1104703.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_side_new_1104703", "1104703054", "story_v_side_new_1104703.awb")

						arg_212_1:RecordAudio("1104703054", var_215_11)
						arg_212_1:RecordAudio("1104703054", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703054", "story_v_side_new_1104703.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703054", "story_v_side_new_1104703.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play1104703055 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1104703055
		arg_216_1.duration_ = 5.4

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1104703056(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["104701ui_story"]) and arg_216_1.var_.characterEffect104701ui_story == nil then
				arg_216_1.var_.characterEffect104701ui_story = arg_216_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.034000001847744

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["104701ui_story"]) then
				if arg_216_1.var_.characterEffect104701ui_story and not isNil(arg_216_1.actors_["104701ui_story"]) then
					arg_216_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_216_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["104701ui_story"]) and arg_216_1.var_.characterEffect104701ui_story then
				arg_216_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_216_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_219_1 = arg_216_1.actors_["104701ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos104701ui_story = var_219_1.localPosition
			end

			local var_219_2 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 then
				var_219_1.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_2)
				var_219_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_1.position).x, (manager.ui.mainCamera.transform.position - var_219_1.position).y, (manager.ui.mainCamera.transform.position - var_219_1.position).z)
				var_219_1.localEulerAngles.z = 0
				var_219_1.localEulerAngles.x = 0
				var_219_1.localEulerAngles = var_219_1.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 then
				var_219_1.localPosition = Vector3.New(0, 100, 0)
				var_219_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_1.position).x, (manager.ui.mainCamera.transform.position - var_219_1.position).y, (manager.ui.mainCamera.transform.position - var_219_1.position).z)
				var_219_1.localEulerAngles.z = 0
				var_219_1.localEulerAngles.x = 0
				var_219_1.localEulerAngles = var_219_1.localEulerAngles
			end

			local var_219_3 = manager.ui.mainCamera.transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.shakeOldPos = var_219_3.localPosition
			end

			local var_219_4 = 0.4

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				local var_219_5, var_219_6 = math.modf((arg_216_1.time_ - 0) / 0.066)

				var_219_3.localPosition = Vector3.New(var_219_6 * 0.13, var_219_6 * 0.13, var_219_6 * 0.13) + arg_216_1.var_.shakeOldPos
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				var_219_3.localPosition = arg_216_1.var_.shakeOldPos
			end

			local var_219_7 = 0

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				arg_216_1.allBtn_.enabled = false
			end

			if arg_216_1.time_ >= var_219_7 + 0.4 and arg_216_1.time_ < var_219_7 + 0.4 + arg_219_0 then
				arg_216_1.allBtn_.enabled = true
			end

			if 0.6 < arg_216_1.time_ and arg_216_1.time_ <= 0.6 + arg_219_0 then
				arg_216_1:AudioAction("play", "effect", "se_story_140", "se_story_140_catch", "")
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_9 = 0.4
			local var_219_10 = 0.975

			if 0.4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_11 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_11:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_12 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(1104703055).content)

				arg_216_1.text_.text = var_219_12

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_14 = 39 <= 0 and var_219_10 or var_219_10 * (utf8.len(var_219_12) / 39)

				if (39 <= 0 and var_219_10 or var_219_10 * (utf8.len(var_219_12) / 39)) > 0 and var_219_10 < var_219_14 then
					arg_216_1.talkMaxDuration = var_219_14
					var_219_9 = var_219_9 + 0.3

					if var_219_14 + var_219_9 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_9
					end
				end

				arg_216_1.text_.text = var_219_12
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_15 = var_219_9 + 0.3
			local var_219_16 = math.max(var_219_10, arg_216_1.talkMaxDuration)

			if var_219_9 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_15 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_15) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_15 + var_219_16 and arg_216_1.time_ < var_219_15 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play1104703056 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104703056
		arg_222_1.duration_ = 2.63

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104703057(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos104701ui_story = arg_222_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).z)
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles = arg_222_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_222_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["104701ui_story"].transform.position).z)
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["104701ui_story"].transform.localEulerAngles = arg_222_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["104701ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect104701ui_story == nil then
				arg_222_1.var_.characterEffect104701ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect104701ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect104701ui_story then
				arg_222_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_225_4 = 0
			local var_225_5 = 0.175

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(1104703056)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 7 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 7)

				if (7 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 7)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703056", "story_v_side_new_1104703.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703056", "story_v_side_new_1104703.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_side_new_1104703", "1104703056", "story_v_side_new_1104703.awb")

						arg_222_1:RecordAudio("1104703056", var_225_11)
						arg_222_1:RecordAudio("1104703056", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703056", "story_v_side_new_1104703.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703056", "story_v_side_new_1104703.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104703057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104703057
		arg_226_1.duration_ = 2.77

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104703058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["104701ui_story"]) and arg_226_1.var_.characterEffect104701ui_story == nil then
				arg_226_1.var_.characterEffect104701ui_story = arg_226_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["104701ui_story"]) then
				if arg_226_1.var_.characterEffect104701ui_story and not isNil(arg_226_1.actors_["104701ui_story"]) then
					arg_226_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_226_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["104701ui_story"]) and arg_226_1.var_.characterEffect104701ui_story then
				arg_226_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_226_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_229_1 = arg_226_1.actors_["104701ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos104701ui_story = var_229_1.localPosition
			end

			local var_229_2 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 then
				var_229_1.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_2)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 then
				var_229_1.localPosition = Vector3.New(0, 100, 0)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			local var_229_3 = 0
			local var_229_4 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_3 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_5 = arg_226_1:GetWordFromCfg(1104703057)
				local var_229_6 = arg_226_1:FormatText(var_229_5.content)

				arg_226_1.text_.text = var_229_6

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_8 = 13 <= 0 and var_229_4 or var_229_4 * (utf8.len(var_229_6) / 13)

				if (13 <= 0 and var_229_4 or var_229_4 * (utf8.len(var_229_6) / 13)) > 0 and var_229_4 < var_229_8 then
					arg_226_1.talkMaxDuration = var_229_8

					if var_229_8 + var_229_3 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_3
					end
				end

				arg_226_1.text_.text = var_229_6
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703057", "story_v_side_new_1104703.awb") ~= 0 then
					local var_229_9 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703057", "story_v_side_new_1104703.awb") / 1000

					if var_229_9 + var_229_3 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_3
					end

					if var_229_5.prefab_name ~= "" and arg_226_1.actors_[var_229_5.prefab_name] ~= nil then
						local var_229_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_5.prefab_name].transform, "story_v_side_new_1104703", "1104703057", "story_v_side_new_1104703.awb")

						arg_226_1:RecordAudio("1104703057", var_229_10)
						arg_226_1:RecordAudio("1104703057", var_229_10)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703057", "story_v_side_new_1104703.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703057", "story_v_side_new_1104703.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_11 = math.max(var_229_4, arg_226_1.talkMaxDuration)

			if var_229_3 <= arg_226_1.time_ and arg_226_1.time_ < var_229_3 + var_229_11 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_3) / var_229_11

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_3 + var_229_11 and arg_226_1.time_ < var_229_3 + var_229_11 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play1104703058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104703058
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104703059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.85

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1104703058).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 34 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 34)

				if (34 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 34)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1104703059 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104703059
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104703060(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(1104703059).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 18 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 18)

				if (18 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 18)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104703060 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104703060
		arg_238_1.duration_ = 4.9

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104703061(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos104701ui_story = arg_238_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).z)
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles = arg_238_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_238_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["104701ui_story"].transform.position).z)
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["104701ui_story"].transform.localEulerAngles = arg_238_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["104701ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect104701ui_story == nil then
				arg_238_1.var_.characterEffect104701ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect104701ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect104701ui_story then
				arg_238_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_4 = 0
			local var_241_5 = 0.5

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_6 = arg_238_1:GetWordFromCfg(1104703060)
				local var_241_7 = arg_238_1:FormatText(var_241_6.content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 20 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 20)

				if (20 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 20)) > 0 and var_241_5 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703060", "story_v_side_new_1104703.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703060", "story_v_side_new_1104703.awb") / 1000

					if var_241_10 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_4
					end

					if var_241_6.prefab_name ~= "" and arg_238_1.actors_[var_241_6.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_6.prefab_name].transform, "story_v_side_new_1104703", "1104703060", "story_v_side_new_1104703.awb")

						arg_238_1:RecordAudio("1104703060", var_241_11)
						arg_238_1:RecordAudio("1104703060", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703060", "story_v_side_new_1104703.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703060", "story_v_side_new_1104703.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_12 and arg_238_1.time_ < var_241_4 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1104703061 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104703061
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104703062(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["104701ui_story"]) and arg_242_1.var_.characterEffect104701ui_story == nil then
				arg_242_1.var_.characterEffect104701ui_story = arg_242_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["104701ui_story"]) then
				if arg_242_1.var_.characterEffect104701ui_story and not isNil(arg_242_1.actors_["104701ui_story"]) then
					arg_242_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_242_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["104701ui_story"]) and arg_242_1.var_.characterEffect104701ui_story then
				arg_242_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_242_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.075

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(1104703061).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 3 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 3)

				if (3 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 3)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1104703062 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104703062
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104703063(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos104701ui_story = arg_246_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).z)
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles = arg_246_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_246_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["104701ui_story"].transform.position).z)
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["104701ui_story"].transform.localEulerAngles = arg_246_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_249_1 = 0
			local var_249_2 = 0.775

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1104703062).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 31 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 31)

				if (31 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 31)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703063 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104703063
		arg_250_1.duration_ = 3.17

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104703064(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos104701ui_story = arg_250_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).z)
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles = arg_250_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_250_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["104701ui_story"].transform.position).z)
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["104701ui_story"].transform.localEulerAngles = arg_250_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["104701ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect104701ui_story == nil then
				arg_250_1.var_.characterEffect104701ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect104701ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect104701ui_story then
				arg_250_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_250_1.time_ and arg_250_1.time_ <= 0.1 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "se_story_151", "se_story_side_151_water_gun01", "")
			end

			local var_253_5 = 0
			local var_253_6 = 0.225

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:GetWordFromCfg(1104703063)
				local var_253_8 = arg_250_1:FormatText(var_253_7.content)

				arg_250_1.text_.text = var_253_8

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 9 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 9)

				if (9 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 9)) > 0 and var_253_6 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_8
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703063", "story_v_side_new_1104703.awb") ~= 0 then
					local var_253_11 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703063", "story_v_side_new_1104703.awb") / 1000

					if var_253_11 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_5
					end

					if var_253_7.prefab_name ~= "" and arg_250_1.actors_[var_253_7.prefab_name] ~= nil then
						local var_253_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_7.prefab_name].transform, "story_v_side_new_1104703", "1104703063", "story_v_side_new_1104703.awb")

						arg_250_1:RecordAudio("1104703063", var_253_12)
						arg_250_1:RecordAudio("1104703063", var_253_12)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703063", "story_v_side_new_1104703.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703063", "story_v_side_new_1104703.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_13 and arg_250_1.time_ < var_253_5 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play1104703064 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104703064
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104703065(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["104701ui_story"]) and arg_254_1.var_.characterEffect104701ui_story == nil then
				arg_254_1.var_.characterEffect104701ui_story = arg_254_1.actors_["104701ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["104701ui_story"]) then
				if arg_254_1.var_.characterEffect104701ui_story and not isNil(arg_254_1.actors_["104701ui_story"]) then
					arg_254_1.var_.characterEffect104701ui_story.fillFlat = true
					arg_254_1.var_.characterEffect104701ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_0)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["104701ui_story"]) and arg_254_1.var_.characterEffect104701ui_story then
				arg_254_1.var_.characterEffect104701ui_story.fillFlat = true
				arg_254_1.var_.characterEffect104701ui_story.fillRatio = 0.5
			end

			local var_257_1 = arg_254_1.actors_["104701ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos104701ui_story = var_257_1.localPosition
			end

			local var_257_2 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 then
				var_257_1.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_2)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 then
				var_257_1.localPosition = Vector3.New(0, 100, 0)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			local var_257_3 = 0
			local var_257_4 = 0.625

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_3 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_5 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(1104703064).content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 25 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 25)

				if (25 <= 0 and var_257_4 or var_257_4 * (utf8.len(var_257_5) / 25)) > 0 and var_257_4 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_3 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_3
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_4, arg_254_1.talkMaxDuration)

			if var_257_3 <= arg_254_1.time_ and arg_254_1.time_ < var_257_3 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_3) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_3 + var_257_8 and arg_254_1.time_ < var_257_3 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
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
	Play1104703065 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104703065
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104703066(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.325

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1104703065).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 53 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 53)

				if (53 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 53)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104703066 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104703066
		arg_262_1.duration_ = 8.37

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104703067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_9000

			if arg_262_1.bgs_.H09g == nil then
				local var_265_0 = Object.Instantiate(arg_262_1.paintGo_)

				var_265_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H09g")
				var_265_0.name = "H09g"
				var_265_0.transform.parent = arg_262_1.stage_.transform
				var_265_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.bgs_.H09g = var_265_0
			end

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= 2 + arg_265_0 then
				local var_265_1 = arg_262_1.bgs_.H09g

				arg_262_1.bgs_.H09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_265_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_265_2 = var_265_1:GetComponent("SpriteRenderer")

				if var_265_2 and var_265_2.sprite then
					local var_265_3 = 2 * (var_265_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_265_1.transform.localScale = Vector3.New(var_265_3 / var_265_2.sprite.bounds.size.y < var_265_3 * manager.ui.mainCameraCom_.aspect / var_265_2.sprite.bounds.size.x and var_265_3 * manager.ui.mainCameraCom_.aspect / var_265_2.sprite.bounds.size.x or var_265_3 / var_265_2.sprite.bounds.size.y, var_265_3 / var_265_2.sprite.bounds.size.y < var_265_3 * manager.ui.mainCameraCom_.aspect / var_265_2.sprite.bounds.size.x and var_265_3 * manager.ui.mainCameraCom_.aspect / var_265_2.sprite.bounds.size.x or var_265_3 / var_265_2.sprite.bounds.size.y, 0)
				end

				for iter_265_0, iter_265_1 in pairs(arg_262_1.bgs_) do
					if iter_265_0 ~= "H09g" then
						iter_265_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_265_4 = 4

			if 4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.allBtn_.enabled = false
			end

			if arg_262_1.time_ >= var_265_4 + 0.3 and arg_262_1.time_ < var_265_4 + 0.3 + arg_265_0 then
				arg_262_1.allBtn_.enabled = true
			end

			local var_265_5 = 0

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_6 = 2

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_6 then
				local var_265_7 = Color.New(0, 0, 0)

				var_265_7.a = Mathf.Lerp(0, 1, (arg_262_1.time_ - var_265_5) / var_265_6)
				arg_262_1.mask_.color = var_265_7
			end

			if arg_262_1.time_ >= var_265_5 + var_265_6 and arg_262_1.time_ < var_265_5 + var_265_6 + arg_265_0 then
				local var_265_8 = Color.New(0, 0, 0)

				var_265_8.a = 1
				arg_262_1.mask_.color = var_265_8
			end

			local var_265_9 = 2

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 then
				arg_262_1.mask_.enabled = true
				arg_262_1.mask_.raycastTarget = true

				arg_262_1:SetGaussion(false)
			end

			local var_265_10 = 2

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_10 then
				local var_265_11 = Color.New(0, 0, 0)

				var_265_11.a = Mathf.Lerp(1, 0, (arg_262_1.time_ - var_265_9) / var_265_10)
				arg_262_1.mask_.color = var_265_11
			end

			if arg_262_1.time_ >= var_265_9 + var_265_10 and arg_262_1.time_ < var_265_9 + var_265_10 + arg_265_0 then
				local var_265_12 = Color.New(0, 0, 0)

				arg_262_1.mask_.enabled = false
				var_265_12.a = 0
				arg_262_1.mask_.color = var_265_12
			end

			if 2 < arg_262_1.time_ and arg_262_1.time_ <= 2 + arg_265_0 then
				local var_265_13 = arg_262_1.var_.effectboguang1boguang112

				if not arg_262_1.var_.effectboguang1boguang112 then
					var_265_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang_keep"), manager.ui.mainCamera.transform)
					var_265_13.name = "boguang112"
					arg_262_1.var_.effectboguang1boguang112 = var_265_13
				else
					var_265_13.transform:SetParent(var_265_9000)
				end

				var_265_13.transform.localPosition = Vector3.New(0, 0, -5.19)
				var_265_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_262_1.frameCnt_ <= 1 then
				arg_262_1.dialog_:SetActive(false)
			end

			local var_265_15 = 4
			local var_265_16 = 0.325

			if 4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0

				arg_262_1.dialog_:SetActive(true)

				arg_262_1.dialogCg_.alpha = 0

				local var_265_17 = LeanTween.value(arg_262_1.dialog_, 0, 1, 0.3)

				var_265_17:setOnUpdate(LuaHelper.FloatAction(function(arg_266_0)
					arg_262_1.dialogCg_.alpha = arg_266_0
				end))
				var_265_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_262_1.dialog_)
					var_265_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_262_1.duration_ = arg_262_1.duration_ + 0.3

				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_2$naive")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_18 = arg_262_1:GetWordFromCfg(1104703066)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_21 = 13 <= 0 and var_265_16 or var_265_16 * (utf8.len(var_265_19) / 13)

				if (13 <= 0 and var_265_16 or var_265_16 * (utf8.len(var_265_19) / 13)) > 0 and var_265_16 < var_265_21 then
					arg_262_1.talkMaxDuration = var_265_21
					var_265_15 = var_265_15 + 0.3

					if var_265_21 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_21 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703066", "story_v_side_new_1104703.awb") ~= 0 then
					local var_265_22 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703066", "story_v_side_new_1104703.awb") / 1000

					if var_265_22 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_15
					end

					if var_265_18.prefab_name ~= "" and arg_262_1.actors_[var_265_18.prefab_name] ~= nil then
						local var_265_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_18.prefab_name].transform, "story_v_side_new_1104703", "1104703066", "story_v_side_new_1104703.awb")

						arg_262_1:RecordAudio("1104703066", var_265_23)
						arg_262_1:RecordAudio("1104703066", var_265_23)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703066", "story_v_side_new_1104703.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703066", "story_v_side_new_1104703.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_24 = var_265_15 + 0.3
			local var_265_25 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 + 0.3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_25 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_24) / var_265_25

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_24 + var_265_25 and arg_262_1.time_ < var_265_24 + var_265_25 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1104703067 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1104703067
		arg_268_1.duration_ = 2.2

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1104703068(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.125

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:GetWordFromCfg(1104703067)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 5 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 5)

				if (5 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 5)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703067", "story_v_side_new_1104703.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703067", "story_v_side_new_1104703.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_side_new_1104703", "1104703067", "story_v_side_new_1104703.awb")

						arg_268_1:RecordAudio("1104703067", var_271_6)
						arg_268_1:RecordAudio("1104703067", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703067", "story_v_side_new_1104703.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703067", "story_v_side_new_1104703.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1104703068 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1104703068
		arg_272_1.duration_ = 3.33

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1104703069(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.3

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(1104703068)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 12 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 12)

				if (12 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 12)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703068", "story_v_side_new_1104703.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703068", "story_v_side_new_1104703.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_side_new_1104703", "1104703068", "story_v_side_new_1104703.awb")

						arg_272_1:RecordAudio("1104703068", var_275_6)
						arg_272_1:RecordAudio("1104703068", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703068", "story_v_side_new_1104703.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703068", "story_v_side_new_1104703.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1104703069 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1104703069
		arg_276_1.duration_ = 2.07

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1104703070(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.2

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:GetWordFromCfg(1104703069)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 8 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 8)

				if (8 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 8)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703069", "story_v_side_new_1104703.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703069", "story_v_side_new_1104703.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_side_new_1104703", "1104703069", "story_v_side_new_1104703.awb")

						arg_276_1:RecordAudio("1104703069", var_279_6)
						arg_276_1:RecordAudio("1104703069", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703069", "story_v_side_new_1104703.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703069", "story_v_side_new_1104703.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1104703070 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1104703070
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1104703071(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:AudioAction("play", "effect", "se_story_140", "se_story_140_sit_water", "")
			end

			local var_283_1 = 0
			local var_283_2 = 0.9

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_3 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(1104703070).content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 36 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 36)

				if (36 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_3) / 36)) > 0 and var_283_2 < var_283_5 then
					arg_280_1.talkMaxDuration = var_283_5

					if var_283_5 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_6 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_6 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_6

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_6 and arg_280_1.time_ < var_283_1 + var_283_6 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1104703071 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1104703071
		arg_284_1.duration_ = 3.23

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1104703072(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.25

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(1104703071)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 10 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 10)

				if (10 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 10)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703071", "story_v_side_new_1104703.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703071", "story_v_side_new_1104703.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_side_new_1104703", "1104703071", "story_v_side_new_1104703.awb")

						arg_284_1:RecordAudio("1104703071", var_287_6)
						arg_284_1:RecordAudio("1104703071", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703071", "story_v_side_new_1104703.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703071", "story_v_side_new_1104703.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1104703072 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1104703072
		arg_288_1.duration_ = 1.8

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1104703073(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.15

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_5$naive")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:GetWordFromCfg(1104703072)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 6 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 6)

				if (6 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 6)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703072", "story_v_side_new_1104703.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703072", "story_v_side_new_1104703.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_side_new_1104703", "1104703072", "story_v_side_new_1104703.awb")

						arg_288_1:RecordAudio("1104703072", var_291_6)
						arg_288_1:RecordAudio("1104703072", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703072", "story_v_side_new_1104703.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703072", "story_v_side_new_1104703.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1104703073 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1104703073
		arg_292_1.duration_ = 4.9

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1104703074(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.4

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_1 = arg_292_1:GetWordFromCfg(1104703073)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 16 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 16)

				if (16 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 16)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703073", "story_v_side_new_1104703.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703073", "story_v_side_new_1104703.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_side_new_1104703", "1104703073", "story_v_side_new_1104703.awb")

						arg_292_1:RecordAudio("1104703073", var_295_6)
						arg_292_1:RecordAudio("1104703073", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703073", "story_v_side_new_1104703.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703073", "story_v_side_new_1104703.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1104703074 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1104703074
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1104703075(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0.8 < arg_296_1.time_ and arg_296_1.time_ <= 0.8 + arg_299_0 then
				arg_296_1:AudioAction("play", "effect", "se_story_135_02", "se_story_135_02_watergun", "")
			end

			local var_299_1 = 0
			local var_299_2 = 0.7

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1104703074).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)

				if (28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play1104703075 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1104703075
		arg_300_1.duration_ = 3.43

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1104703076(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.25

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:GetWordFromCfg(1104703075)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 10 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 10)

				if (10 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 10)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703075", "story_v_side_new_1104703.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703075", "story_v_side_new_1104703.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_side_new_1104703", "1104703075", "story_v_side_new_1104703.awb")

						arg_300_1:RecordAudio("1104703075", var_303_6)
						arg_300_1:RecordAudio("1104703075", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703075", "story_v_side_new_1104703.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703075", "story_v_side_new_1104703.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1104703076 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1104703076
		arg_304_1.duration_ = 3.6

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1104703077(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:AudioAction("play", "effect", "se_story_151", "se_story_side_151_water_gun01", "")
			end

			local var_307_1 = 0
			local var_307_2 = 0.425

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(1104703076)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_6 = 17 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 17)

				if (17 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_4) / 17)) > 0 and var_307_2 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703076", "story_v_side_new_1104703.awb") ~= 0 then
					local var_307_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703076", "story_v_side_new_1104703.awb") / 1000

					if var_307_7 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_1
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_side_new_1104703", "1104703076", "story_v_side_new_1104703.awb")

						arg_304_1:RecordAudio("1104703076", var_307_8)
						arg_304_1:RecordAudio("1104703076", var_307_8)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703076", "story_v_side_new_1104703.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703076", "story_v_side_new_1104703.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_9 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_9 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_9

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_9 and arg_304_1.time_ < var_307_1 + var_307_9 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1104703077 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1104703077
		arg_308_1.duration_ = 9

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1104703078(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 1.999999999999 < arg_308_1.time_ and arg_308_1.time_ <= 1.999999999999 + arg_311_0 then
				local var_311_0 = arg_308_1.bgs_.ST15

				arg_308_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_311_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_311_1 = var_311_0:GetComponent("SpriteRenderer")

				if var_311_1 and var_311_1.sprite then
					local var_311_2 = 2 * (var_311_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_311_0.transform.localScale = Vector3.New(var_311_2 / var_311_1.sprite.bounds.size.y < var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x and var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x or var_311_2 / var_311_1.sprite.bounds.size.y, var_311_2 / var_311_1.sprite.bounds.size.y < var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x and var_311_2 * manager.ui.mainCameraCom_.aspect / var_311_1.sprite.bounds.size.x or var_311_2 / var_311_1.sprite.bounds.size.y, 0)
				end

				for iter_311_0, iter_311_1 in pairs(arg_308_1.bgs_) do
					if iter_311_0 ~= "ST15" then
						iter_311_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_311_3 = 3.999999999999

			if 3.999999999999 < arg_308_1.time_ and arg_308_1.time_ <= var_311_3 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			if arg_308_1.time_ >= var_311_3 + 0.3 and arg_308_1.time_ < var_311_3 + 0.3 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_4 = 0

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_5 = 2

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_5 then
				local var_311_6 = Color.New(0, 0, 0)

				var_311_6.a = Mathf.Lerp(0, 1, (arg_308_1.time_ - var_311_4) / var_311_5)
				arg_308_1.mask_.color = var_311_6
			end

			if arg_308_1.time_ >= var_311_4 + var_311_5 and arg_308_1.time_ < var_311_4 + var_311_5 + arg_311_0 then
				local var_311_7 = Color.New(0, 0, 0)

				var_311_7.a = 1
				arg_308_1.mask_.color = var_311_7
			end

			local var_311_8 = 2

			if 2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_9 = 2

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_9 then
				local var_311_10 = Color.New(0, 0, 0)

				var_311_10.a = Mathf.Lerp(1, 0, (arg_308_1.time_ - var_311_8) / var_311_9)
				arg_308_1.mask_.color = var_311_10
			end

			if arg_308_1.time_ >= var_311_8 + var_311_9 and arg_308_1.time_ < var_311_8 + var_311_9 + arg_311_0 then
				local var_311_11 = Color.New(0, 0, 0)

				arg_308_1.mask_.enabled = false
				var_311_11.a = 0
				arg_308_1.mask_.color = var_311_11
			end

			if 2 < arg_308_1.time_ and arg_308_1.time_ <= 2 + arg_311_0 then
				if arg_308_1.var_.effectboguang1boguang112 then
					Object.Destroy(arg_308_1.var_.effectboguang1boguang112)

					arg_308_1.var_.effectboguang1boguang112 = nil
				end
			end

			if arg_308_1.frameCnt_ <= 1 then
				arg_308_1.dialog_:SetActive(false)
			end

			local var_311_13 = 3.999999999999
			local var_311_14 = 1.075

			if 3.999999999999 < arg_308_1.time_ and arg_308_1.time_ <= var_311_13 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				arg_308_1.dialog_:SetActive(true)

				arg_308_1.dialogCg_.alpha = 0

				local var_311_15 = LeanTween.value(arg_308_1.dialog_, 0, 1, 0.3)

				var_311_15:setOnUpdate(LuaHelper.FloatAction(function(arg_312_0)
					arg_308_1.dialogCg_.alpha = arg_312_0
				end))
				var_311_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_308_1.dialog_)
					var_311_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_308_1.duration_ = arg_308_1.duration_ + 0.3

				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_16 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1104703077).content)

				arg_308_1.text_.text = var_311_16

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_18 = 43 <= 0 and var_311_14 or var_311_14 * (utf8.len(var_311_16) / 43)

				if (43 <= 0 and var_311_14 or var_311_14 * (utf8.len(var_311_16) / 43)) > 0 and var_311_14 < var_311_18 then
					arg_308_1.talkMaxDuration = var_311_18
					var_311_13 = var_311_13 + 0.3

					if var_311_18 + var_311_13 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_18 + var_311_13
					end
				end

				arg_308_1.text_.text = var_311_16
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_19 = var_311_13 + 0.3
			local var_311_20 = math.max(var_311_14, arg_308_1.talkMaxDuration)

			if var_311_13 + 0.3 <= arg_308_1.time_ and arg_308_1.time_ < var_311_19 + var_311_20 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_19) / var_311_20

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_19 + var_311_20 and arg_308_1.time_ < var_311_19 + var_311_20 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1104703078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1104703078
		arg_314_1.duration_ = 12.4

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1104703079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1.25

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:GetWordFromCfg(1104703078)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 50 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 50)

				if (50 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 50)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703078", "story_v_side_new_1104703.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703078", "story_v_side_new_1104703.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_side_new_1104703", "1104703078", "story_v_side_new_1104703.awb")

						arg_314_1:RecordAudio("1104703078", var_317_6)
						arg_314_1:RecordAudio("1104703078", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703078", "story_v_side_new_1104703.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703078", "story_v_side_new_1104703.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1104703079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1104703079
		arg_318_1.duration_ = 4.53

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1104703080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.575

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1$naive")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:GetWordFromCfg(1104703079)
				local var_321_2 = arg_318_1:FormatText(var_321_1.content)

				arg_318_1.text_.text = var_321_2

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_4 = 23 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 23)

				if (23 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_2) / 23)) > 0 and var_321_0 < var_321_4 then
					arg_318_1.talkMaxDuration = var_321_4

					if var_321_4 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_4 + 0
					end
				end

				arg_318_1.text_.text = var_321_2
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703079", "story_v_side_new_1104703.awb") ~= 0 then
					local var_321_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703079", "story_v_side_new_1104703.awb") / 1000

					if var_321_5 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + 0
					end

					if var_321_1.prefab_name ~= "" and arg_318_1.actors_[var_321_1.prefab_name] ~= nil then
						local var_321_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_1.prefab_name].transform, "story_v_side_new_1104703", "1104703079", "story_v_side_new_1104703.awb")

						arg_318_1:RecordAudio("1104703079", var_321_6)
						arg_318_1:RecordAudio("1104703079", var_321_6)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703079", "story_v_side_new_1104703.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703079", "story_v_side_new_1104703.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_7 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_7

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1104703080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1104703080
		arg_322_1.duration_ = 3.8

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1104703081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.275

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:GetWordFromCfg(1104703080)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 11 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 11)

				if (11 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 11)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703080", "story_v_side_new_1104703.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703080", "story_v_side_new_1104703.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_side_new_1104703", "1104703080", "story_v_side_new_1104703.awb")

						arg_322_1:RecordAudio("1104703080", var_325_6)
						arg_322_1:RecordAudio("1104703080", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703080", "story_v_side_new_1104703.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703080", "story_v_side_new_1104703.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1104703081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1104703081
		arg_326_1.duration_ = 3.4

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1104703082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.35

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1$naive")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(1104703081)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 14 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 14)

				if (14 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 14)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703081", "story_v_side_new_1104703.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703081", "story_v_side_new_1104703.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_side_new_1104703", "1104703081", "story_v_side_new_1104703.awb")

						arg_326_1:RecordAudio("1104703081", var_329_6)
						arg_326_1:RecordAudio("1104703081", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703081", "story_v_side_new_1104703.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703081", "story_v_side_new_1104703.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1104703082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1104703082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1104703083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0.3 < arg_330_1.time_ and arg_330_1.time_ <= 0.3 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_333_1 = 0
			local var_333_2 = 0.8

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1104703082).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 32 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 32)

				if (32 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 32)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1104703083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1104703083
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1104703084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.15

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1104703083).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 6 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 6)

				if (6 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 6)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1104703084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1104703084
		arg_338_1.duration_ = 1.17

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1104703085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.05

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_2$naive")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_1 = arg_338_1:GetWordFromCfg(1104703084)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 2 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 2)

				if (2 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 2)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703084", "story_v_side_new_1104703.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703084", "story_v_side_new_1104703.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_side_new_1104703", "1104703084", "story_v_side_new_1104703.awb")

						arg_338_1:RecordAudio("1104703084", var_341_6)
						arg_338_1:RecordAudio("1104703084", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703084", "story_v_side_new_1104703.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703084", "story_v_side_new_1104703.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1104703085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1104703085
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1104703086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.075

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(1104703085).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 3 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 3)

				if (3 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 3)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1104703086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1104703086
		arg_346_1.duration_ = 2

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1104703087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos104701ui_story = arg_346_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos104701ui_story, Vector3.New(0, -1.13, -6.2), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).z)
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles = arg_346_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_346_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["104701ui_story"].transform.position).z)
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["104701ui_story"].transform.localEulerAngles = arg_346_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_1 = arg_346_1.actors_["104701ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect104701ui_story == nil then
				arg_346_1.var_.characterEffect104701ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect104701ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect104701ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect104701ui_story then
				arg_346_1.var_.characterEffect104701ui_story.fillFlat = false
			end

			if 0.1 < arg_346_1.time_ and arg_346_1.time_ <= 0.1 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "se_story_151", "se_story_side_151_water_gun02", "")
			end

			local var_349_5 = 0
			local var_349_6 = 0.05

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1519].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin02")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_7 = arg_346_1:GetWordFromCfg(1104703086)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 2 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 2)

				if (2 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 2)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703086", "story_v_side_new_1104703.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703086", "story_v_side_new_1104703.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_side_new_1104703", "1104703086", "story_v_side_new_1104703.awb")

						arg_346_1:RecordAudio("1104703086", var_349_12)
						arg_346_1:RecordAudio("1104703086", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703086", "story_v_side_new_1104703.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703086", "story_v_side_new_1104703.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play1104703087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1104703087
		arg_350_1.duration_ = 5.83

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1104703088(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos104701ui_story = arg_350_1.actors_["104701ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["104701ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos104701ui_story, Vector3.New(0, 100, 0), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).z)
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles = arg_350_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["104701ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_350_1.actors_["104701ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["104701ui_story"].transform.position).z)
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["104701ui_story"].transform.localEulerAngles = arg_350_1.actors_["104701ui_story"].transform.localEulerAngles
			end

			local var_353_1 = 0

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_2 = 0.5

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = Color.New(1, 1, 1)

				var_353_3.a = Mathf.Lerp(0, 1, (arg_350_1.time_ - var_353_1) / var_353_2)
				arg_350_1.mask_.color = var_353_3
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				local var_353_4 = Color.New(1, 1, 1)

				var_353_4.a = 1
				arg_350_1.mask_.color = var_353_4
			end

			local var_353_5 = 0.5

			if 0.5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_6 = 0.5

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_6 then
				local var_353_7 = Color.New(1, 1, 1)

				var_353_7.a = Mathf.Lerp(1, 0, (arg_350_1.time_ - var_353_5) / var_353_6)
				arg_350_1.mask_.color = var_353_7
			end

			if arg_350_1.time_ >= var_353_5 + var_353_6 and arg_350_1.time_ < var_353_5 + var_353_6 + arg_353_0 then
				local var_353_8 = Color.New(1, 1, 1)

				arg_350_1.mask_.enabled = false
				var_353_8.a = 0
				arg_350_1.mask_.color = var_353_8
			end

			if arg_350_1.frameCnt_ <= 1 then
				arg_350_1.dialog_:SetActive(false)
			end

			local var_353_9 = 0.833333333333333
			local var_353_10 = 1.125

			if 0.833333333333333 < arg_350_1.time_ and arg_350_1.time_ <= var_353_9 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0

				arg_350_1.dialog_:SetActive(true)

				arg_350_1.dialogCg_.alpha = 0

				local var_353_11 = LeanTween.value(arg_350_1.dialog_, 0, 1, 0.3)

				var_353_11:setOnUpdate(LuaHelper.FloatAction(function(arg_354_0)
					arg_350_1.dialogCg_.alpha = arg_354_0
				end))
				var_353_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_350_1.dialog_)
					var_353_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_350_1.duration_ = arg_350_1.duration_ + 0.3

				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_12 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1104703087).content)

				arg_350_1.text_.text = var_353_12

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_14 = 45 <= 0 and var_353_10 or var_353_10 * (utf8.len(var_353_12) / 45)

				if (45 <= 0 and var_353_10 or var_353_10 * (utf8.len(var_353_12) / 45)) > 0 and var_353_10 < var_353_14 then
					arg_350_1.talkMaxDuration = var_353_14
					var_353_9 = var_353_9 + 0.3

					if var_353_14 + var_353_9 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_14 + var_353_9
					end
				end

				arg_350_1.text_.text = var_353_12
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_15 = var_353_9 + 0.3
			local var_353_16 = math.max(var_353_10, arg_350_1.talkMaxDuration)

			if var_353_9 + 0.3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_16 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_16

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_16 and arg_350_1.time_ < var_353_15 + var_353_16 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1104703088 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1104703088
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1104703089(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.55

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_1 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1104703088).content)

				arg_356_1.text_.text = var_359_1

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_3 = 22 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 22)

				if (22 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 22)) > 0 and var_359_0 < var_359_3 then
					arg_356_1.talkMaxDuration = var_359_3

					if var_359_3 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_3 + 0
					end
				end

				arg_356_1.text_.text = var_359_1
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_4 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_4 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_4

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_4 and arg_356_1.time_ < 0 + var_359_4 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1104703089 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1104703089
		arg_360_1.duration_ = 1.9

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1104703090(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.25

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_1 = arg_360_1:GetWordFromCfg(1104703089)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 10 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 10)

				if (10 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 10)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703089", "story_v_side_new_1104703.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703089", "story_v_side_new_1104703.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_side_new_1104703", "1104703089", "story_v_side_new_1104703.awb")

						arg_360_1:RecordAudio("1104703089", var_363_6)
						arg_360_1:RecordAudio("1104703089", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703089", "story_v_side_new_1104703.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703089", "story_v_side_new_1104703.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1104703090 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1104703090
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1104703091(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.1

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(1104703090).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 4 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 4)

				if (4 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 4)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1104703091 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1104703091
		arg_368_1.duration_ = 6.3

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1104703092(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.7

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1$naive")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:GetWordFromCfg(1104703091)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 28 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 28)

				if (28 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 28)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703091", "story_v_side_new_1104703.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703091", "story_v_side_new_1104703.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_side_new_1104703", "1104703091", "story_v_side_new_1104703.awb")

						arg_368_1:RecordAudio("1104703091", var_371_6)
						arg_368_1:RecordAudio("1104703091", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703091", "story_v_side_new_1104703.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703091", "story_v_side_new_1104703.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1104703092 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1104703092
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1104703093(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.975

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1104703092).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 39 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 39)

				if (39 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 39)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1104703093 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1104703093
		arg_376_1.duration_ = 5.1

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1104703094(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_1 = arg_376_1:GetWordFromCfg(1104703093)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 19 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 19)

				if (19 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 19)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703093", "story_v_side_new_1104703.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703093", "story_v_side_new_1104703.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_side_new_1104703", "1104703093", "story_v_side_new_1104703.awb")

						arg_376_1:RecordAudio("1104703093", var_379_6)
						arg_376_1:RecordAudio("1104703093", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703093", "story_v_side_new_1104703.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703093", "story_v_side_new_1104703.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1104703094 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1104703094
		arg_380_1.duration_ = 3.4

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1104703095(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_383_1 = 0
			local var_383_2 = 0.275

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(1104703094)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 11 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 11)

				if (11 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 11)) > 0 and var_383_2 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703094", "story_v_side_new_1104703.awb") ~= 0 then
					local var_383_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703094", "story_v_side_new_1104703.awb") / 1000

					if var_383_7 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_1
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_side_new_1104703", "1104703094", "story_v_side_new_1104703.awb")

						arg_380_1:RecordAudio("1104703094", var_383_8)
						arg_380_1:RecordAudio("1104703094", var_383_8)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703094", "story_v_side_new_1104703.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703094", "story_v_side_new_1104703.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_9 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_9 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_9

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_9 and arg_380_1.time_ < var_383_1 + var_383_9 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1104703095 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1104703095
		arg_384_1.duration_ = 9

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1104703096(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if arg_384_1.bgs_.ST27 == nil then
				local var_387_0 = Object.Instantiate(arg_384_1.paintGo_)

				var_387_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27")
				var_387_0.name = "ST27"
				var_387_0.transform.parent = arg_384_1.stage_.transform
				var_387_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_384_1.bgs_.ST27 = var_387_0
			end

			if 2 < arg_384_1.time_ and arg_384_1.time_ <= 2 + arg_387_0 then
				local var_387_1 = arg_384_1.bgs_.ST27

				arg_384_1.bgs_.ST27.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_387_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_387_2 = var_387_1:GetComponent("SpriteRenderer")

				if var_387_2 and var_387_2.sprite then
					local var_387_3 = 2 * (var_387_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_387_1.transform.localScale = Vector3.New(var_387_3 / var_387_2.sprite.bounds.size.y < var_387_3 * manager.ui.mainCameraCom_.aspect / var_387_2.sprite.bounds.size.x and var_387_3 * manager.ui.mainCameraCom_.aspect / var_387_2.sprite.bounds.size.x or var_387_3 / var_387_2.sprite.bounds.size.y, var_387_3 / var_387_2.sprite.bounds.size.y < var_387_3 * manager.ui.mainCameraCom_.aspect / var_387_2.sprite.bounds.size.x and var_387_3 * manager.ui.mainCameraCom_.aspect / var_387_2.sprite.bounds.size.x or var_387_3 / var_387_2.sprite.bounds.size.y, 0)
				end

				for iter_387_0, iter_387_1 in pairs(arg_384_1.bgs_) do
					if iter_387_0 ~= "ST27" then
						iter_387_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_387_4 = 4

			if 4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.allBtn_.enabled = false
			end

			if arg_384_1.time_ >= var_387_4 + 0.3 and arg_384_1.time_ < var_387_4 + 0.3 + arg_387_0 then
				arg_384_1.allBtn_.enabled = true
			end

			local var_387_5 = 0

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = true

				arg_384_1:SetGaussion(false)
			end

			local var_387_6 = 2

			if var_387_5 <= arg_384_1.time_ and arg_384_1.time_ < var_387_5 + var_387_6 then
				local var_387_7 = Color.New(0, 0, 0)

				var_387_7.a = Mathf.Lerp(0, 1, (arg_384_1.time_ - var_387_5) / var_387_6)
				arg_384_1.mask_.color = var_387_7
			end

			if arg_384_1.time_ >= var_387_5 + var_387_6 and arg_384_1.time_ < var_387_5 + var_387_6 + arg_387_0 then
				local var_387_8 = Color.New(0, 0, 0)

				var_387_8.a = 1
				arg_384_1.mask_.color = var_387_8
			end

			local var_387_9 = 2

			if 2 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = true

				arg_384_1:SetGaussion(false)
			end

			local var_387_10 = 2

			if var_387_9 <= arg_384_1.time_ and arg_384_1.time_ < var_387_9 + var_387_10 then
				local var_387_11 = Color.New(0, 0, 0)

				var_387_11.a = Mathf.Lerp(1, 0, (arg_384_1.time_ - var_387_9) / var_387_10)
				arg_384_1.mask_.color = var_387_11
			end

			if arg_384_1.time_ >= var_387_9 + var_387_10 and arg_384_1.time_ < var_387_9 + var_387_10 + arg_387_0 then
				local var_387_12 = Color.New(0, 0, 0)

				arg_384_1.mask_.enabled = false
				var_387_12.a = 0
				arg_384_1.mask_.color = var_387_12
			end

			if 0.1 < arg_384_1.time_ and arg_384_1.time_ <= 0.1 + arg_387_0 then
				arg_384_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1.2 < arg_384_1.time_ and arg_384_1.time_ <= 1.2 + arg_387_0 then
				arg_384_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if 1 < arg_384_1.time_ and arg_384_1.time_ <= 1 + arg_387_0 then
				arg_384_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_387_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_384_1.bgmTxt_.text ~= var_387_17 and arg_384_1.bgmTxt_.text ~= "" then
						if arg_384_1.bgmTxt2_.text ~= "" then
							arg_384_1.bgmTxt_.text = arg_384_1.bgmTxt2_.text
						end

						arg_384_1.bgmTxt2_.text = var_387_17

						arg_384_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_384_1.bgmTxt_.text = var_387_17
						arg_384_1.bgmTxt2_.text = var_387_17
					end

					if arg_384_1.bgmTimer then
						arg_384_1.bgmTimer:Stop()

						arg_384_1.bgmTimer = nil
					end

					if arg_384_1.settingData.show_music_name == 1 then
						arg_384_1.musicController:SetSelectedState("show")
						arg_384_1.musicAnimator_:Play("open", 0, 0)

						if arg_384_1.settingData.music_time ~= 0 then
							arg_384_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_384_1.settingData.music_time), function()
								if arg_384_1 == nil or isNil(arg_384_1.bgmTxt_) then
									return
								end

								arg_384_1.musicController:SetSelectedState("hide")
								arg_384_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_384_1.frameCnt_ <= 1 then
				arg_384_1.dialog_:SetActive(false)
			end

			local var_387_18 = 4
			local var_387_19 = 1.3

			if 4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_18 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0

				arg_384_1.dialog_:SetActive(true)

				arg_384_1.dialogCg_.alpha = 0

				local var_387_20 = LeanTween.value(arg_384_1.dialog_, 0, 1, 0.3)

				var_387_20:setOnUpdate(LuaHelper.FloatAction(function(arg_389_0)
					arg_384_1.dialogCg_.alpha = arg_389_0
				end))
				var_387_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_384_1.dialog_)
					var_387_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_384_1.duration_ = arg_384_1.duration_ + 0.3

				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_21 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1104703095).content)

				arg_384_1.text_.text = var_387_21

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_23 = 52 <= 0 and var_387_19 or var_387_19 * (utf8.len(var_387_21) / 52)

				if (52 <= 0 and var_387_19 or var_387_19 * (utf8.len(var_387_21) / 52)) > 0 and var_387_19 < var_387_23 then
					arg_384_1.talkMaxDuration = var_387_23
					var_387_18 = var_387_18 + 0.3

					if var_387_23 + var_387_18 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_23 + var_387_18
					end
				end

				arg_384_1.text_.text = var_387_21
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_24 = var_387_18 + 0.3
			local var_387_25 = math.max(var_387_19, arg_384_1.talkMaxDuration)

			if var_387_18 + 0.3 <= arg_384_1.time_ and arg_384_1.time_ < var_387_24 + var_387_25 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_24) / var_387_25

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_24 + var_387_25 and arg_384_1.time_ < var_387_24 + var_387_25 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1104703096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1104703096
		arg_391_1.duration_ = 3.63

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1104703097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if arg_391_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_394_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_391_1.stage_.transform)

				var_394_0.name = "1047ui_story"
				var_394_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_391_1.actors_["1047ui_story"] = var_394_0

				local var_394_1 = var_394_0:GetComponentInChildren(typeof(CharacterEffect))

				var_394_1.enabled = true

				local var_394_2 = GameObjectTools.GetOrAddComponent(var_394_0, typeof(DynamicBoneHelper))

				if var_394_2 then
					var_394_2:EnableDynamicBone(false)
				end

				arg_391_1:ShowWeapon(var_394_1.transform, false)

				arg_391_1.var_["1047ui_story" .. "Animator"] = var_394_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_391_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_391_1.var_["1047ui_story" .. "LipSync"] = var_394_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_394_3 = arg_391_1.actors_["1047ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1047ui_story = var_394_3.localPosition
			end

			local var_394_4 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				var_394_3.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_391_1.time_ - 0) / var_394_4)
				var_394_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_3.position).x, (manager.ui.mainCamera.transform.position - var_394_3.position).y, (manager.ui.mainCamera.transform.position - var_394_3.position).z)
				var_394_3.localEulerAngles.z = 0
				var_394_3.localEulerAngles.x = 0
				var_394_3.localEulerAngles = var_394_3.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				var_394_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_394_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_3.position).x, (manager.ui.mainCamera.transform.position - var_394_3.position).y, (manager.ui.mainCamera.transform.position - var_394_3.position).z)
				var_394_3.localEulerAngles.z = 0
				var_394_3.localEulerAngles.x = 0
				var_394_3.localEulerAngles = var_394_3.localEulerAngles
			end

			local var_394_5 = arg_391_1.actors_["1047ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_5) and arg_391_1.var_.characterEffect1047ui_story == nil then
				arg_391_1.var_.characterEffect1047ui_story = var_394_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_6 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_6 and not isNil(var_394_5) then
				if arg_391_1.var_.characterEffect1047ui_story and not isNil(var_394_5) then
					arg_391_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_6 and arg_391_1.time_ < 0 + var_394_6 + arg_394_0 and not isNil(var_394_5) and arg_391_1.var_.characterEffect1047ui_story then
				arg_391_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_394_8 = 0
			local var_394_9 = 0.375

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_8 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_10 = arg_391_1:GetWordFromCfg(1104703096)
				local var_394_11 = arg_391_1:FormatText(var_394_10.content)

				arg_391_1.text_.text = var_394_11

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_13 = 15 <= 0 and var_394_9 or var_394_9 * (utf8.len(var_394_11) / 15)

				if (15 <= 0 and var_394_9 or var_394_9 * (utf8.len(var_394_11) / 15)) > 0 and var_394_9 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_8 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_8
					end
				end

				arg_391_1.text_.text = var_394_11
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703096", "story_v_side_new_1104703.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703096", "story_v_side_new_1104703.awb") / 1000

					if var_394_14 + var_394_8 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_8
					end

					if var_394_10.prefab_name ~= "" and arg_391_1.actors_[var_394_10.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_10.prefab_name].transform, "story_v_side_new_1104703", "1104703096", "story_v_side_new_1104703.awb")

						arg_391_1:RecordAudio("1104703096", var_394_15)
						arg_391_1:RecordAudio("1104703096", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703096", "story_v_side_new_1104703.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703096", "story_v_side_new_1104703.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_9, arg_391_1.talkMaxDuration)

			if var_394_8 <= arg_391_1.time_ and arg_391_1.time_ < var_394_8 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_8) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_8 + var_394_16 and arg_391_1.time_ < var_394_8 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
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

		arg_391_1:InitPlayNodeList()
	end,
	Play1104703097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1104703097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1104703098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1047ui_story"]) and arg_395_1.var_.characterEffect1047ui_story == nil then
				arg_395_1.var_.characterEffect1047ui_story = arg_395_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1047ui_story"]) then
				if arg_395_1.var_.characterEffect1047ui_story and not isNil(arg_395_1.actors_["1047ui_story"]) then
					arg_395_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1047ui_story"]) and arg_395_1.var_.characterEffect1047ui_story then
				arg_395_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.5

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1104703097).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 20 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 20)

				if (20 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 20)) > 0 and var_398_2 < var_398_5 then
					arg_395_1.talkMaxDuration = var_398_5

					if var_398_5 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_6 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_6 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_6

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_6 and arg_395_1.time_ < var_398_1 + var_398_6 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1104703098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1104703098
		arg_399_1.duration_ = 4.8

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1104703099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1047ui_story = arg_399_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).z)
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles = arg_399_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_399_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1047ui_story"].transform.position).z)
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1047ui_story"].transform.localEulerAngles = arg_399_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1047ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1047ui_story == nil then
				arg_399_1.var_.characterEffect1047ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect1047ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1047ui_story then
				arg_399_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_402_4 = 0
			local var_402_5 = 0.45

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(1104703098)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_9 = 18 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 18)

				if (18 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 18)) > 0 and var_402_5 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703098", "story_v_side_new_1104703.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703098", "story_v_side_new_1104703.awb") / 1000

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end

					if var_402_6.prefab_name ~= "" and arg_399_1.actors_[var_402_6.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_6.prefab_name].transform, "story_v_side_new_1104703", "1104703098", "story_v_side_new_1104703.awb")

						arg_399_1:RecordAudio("1104703098", var_402_11)
						arg_399_1:RecordAudio("1104703098", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703098", "story_v_side_new_1104703.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703098", "story_v_side_new_1104703.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_12 and arg_399_1.time_ < var_402_4 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
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

		arg_399_1:InitPlayNodeList()
	end,
	Play1104703099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1104703099
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1104703100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1047ui_story"]) and arg_403_1.var_.characterEffect1047ui_story == nil then
				arg_403_1.var_.characterEffect1047ui_story = arg_403_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1047ui_story"]) then
				if arg_403_1.var_.characterEffect1047ui_story and not isNil(arg_403_1.actors_["1047ui_story"]) then
					arg_403_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1047ui_story"]) and arg_403_1.var_.characterEffect1047ui_story then
				arg_403_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 0.25

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1104703099).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 10 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 10)

				if (10 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 10)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1104703100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1104703100
		arg_407_1.duration_ = 7.1

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1104703101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1047ui_story"]) and arg_407_1.var_.characterEffect1047ui_story == nil then
				arg_407_1.var_.characterEffect1047ui_story = arg_407_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1047ui_story"]) then
				if arg_407_1.var_.characterEffect1047ui_story and not isNil(arg_407_1.actors_["1047ui_story"]) then
					arg_407_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1047ui_story"]) and arg_407_1.var_.characterEffect1047ui_story then
				arg_407_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action424")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_410_2 = 0
			local var_410_3 = 0.825

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(1104703100)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 33 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 33)

				if (33 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 33)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703100", "story_v_side_new_1104703.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703100", "story_v_side_new_1104703.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_new_1104703", "1104703100", "story_v_side_new_1104703.awb")

						arg_407_1:RecordAudio("1104703100", var_410_9)
						arg_407_1:RecordAudio("1104703100", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703100", "story_v_side_new_1104703.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703100", "story_v_side_new_1104703.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1104703101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1104703101
		arg_411_1.duration_ = 2.63

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1104703102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_414_0 = 0
			local var_414_1 = 0.35

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_2 = arg_411_1:GetWordFromCfg(1104703101)
				local var_414_3 = arg_411_1:FormatText(var_414_2.content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 14 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 14)

				if (14 <= 0 and var_414_1 or var_414_1 * (utf8.len(var_414_3) / 14)) > 0 and var_414_1 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_0
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703101", "story_v_side_new_1104703.awb") ~= 0 then
					local var_414_6 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703101", "story_v_side_new_1104703.awb") / 1000

					if var_414_6 + var_414_0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_0
					end

					if var_414_2.prefab_name ~= "" and arg_411_1.actors_[var_414_2.prefab_name] ~= nil then
						local var_414_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_2.prefab_name].transform, "story_v_side_new_1104703", "1104703101", "story_v_side_new_1104703.awb")

						arg_411_1:RecordAudio("1104703101", var_414_7)
						arg_411_1:RecordAudio("1104703101", var_414_7)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703101", "story_v_side_new_1104703.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703101", "story_v_side_new_1104703.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_8 = math.max(var_414_1, arg_411_1.talkMaxDuration)

			if var_414_0 <= arg_411_1.time_ and arg_411_1.time_ < var_414_0 + var_414_8 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_0) / var_414_8

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_0 + var_414_8 and arg_411_1.time_ < var_414_0 + var_414_8 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1104703102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1104703102
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1104703103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1047ui_story"]) and arg_415_1.var_.characterEffect1047ui_story == nil then
				arg_415_1.var_.characterEffect1047ui_story = arg_415_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1047ui_story"]) then
				if arg_415_1.var_.characterEffect1047ui_story and not isNil(arg_415_1.actors_["1047ui_story"]) then
					arg_415_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_0)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1047ui_story"]) and arg_415_1.var_.characterEffect1047ui_story then
				arg_415_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_418_1 = 0
			local var_418_2 = 0.275

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1104703102).content)

				arg_415_1.text_.text = var_418_3

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 11 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 11)

				if (11 <= 0 and var_418_2 or var_418_2 * (utf8.len(var_418_3) / 11)) > 0 and var_418_2 < var_418_5 then
					arg_415_1.talkMaxDuration = var_418_5

					if var_418_5 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + var_418_1
					end
				end

				arg_415_1.text_.text = var_418_3
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_6 = math.max(var_418_2, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_6 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_1) / var_418_6

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_6 and arg_415_1.time_ < var_418_1 + var_418_6 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1104703103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1104703103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1104703104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1047ui_story = arg_419_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).z)
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles = arg_419_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1047ui_story"].transform.position).z)
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1047ui_story"].transform.localEulerAngles = arg_419_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_422_1 = 0
			local var_422_2 = 0.525

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(1104703103).content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 21 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 21)

				if (21 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 21)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_6 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_6 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_6

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_6 and arg_419_1.time_ < var_422_1 + var_422_6 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
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

		arg_419_1:InitPlayNodeList()
	end,
	Play1104703104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1104703104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1104703105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.9

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1104703104).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 36 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 36)

				if (36 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 36)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1104703105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1104703105
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1104703106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.4

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1104703105).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 16 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 16)

				if (16 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 16)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1104703106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1104703106
		arg_431_1.duration_ = 6.47

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1104703107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_9000

			if arg_431_1.bgs_.ST22 == nil then
				local var_434_0 = Object.Instantiate(arg_431_1.paintGo_)

				var_434_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_434_0.name = "ST22"
				var_434_0.transform.parent = arg_431_1.stage_.transform
				var_434_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_431_1.bgs_.ST22 = var_434_0
			end

			if 0.7 < arg_431_1.time_ and arg_431_1.time_ <= 0.7 + arg_434_0 then
				local var_434_1 = arg_431_1.bgs_.ST22

				arg_431_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_434_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_434_2 = var_434_1:GetComponent("SpriteRenderer")

				if var_434_2 and var_434_2.sprite then
					local var_434_3 = 2 * (var_434_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_434_1.transform.localScale = Vector3.New(var_434_3 / var_434_2.sprite.bounds.size.y < var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x and var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x or var_434_3 / var_434_2.sprite.bounds.size.y, var_434_3 / var_434_2.sprite.bounds.size.y < var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x and var_434_3 * manager.ui.mainCameraCom_.aspect / var_434_2.sprite.bounds.size.x or var_434_3 / var_434_2.sprite.bounds.size.y, 0)
				end

				for iter_434_0, iter_434_1 in pairs(arg_431_1.bgs_) do
					if iter_434_0 ~= "ST22" then
						iter_434_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_434_4 = 1

			if 1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.allBtn_.enabled = false
			end

			if arg_431_1.time_ >= var_434_4 + 0.3 and arg_431_1.time_ < var_434_4 + 0.3 + arg_434_0 then
				arg_431_1.allBtn_.enabled = true
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				local var_434_5 = arg_431_1.var_.effectzhuanchangyixia1

				if not arg_431_1.var_.effectzhuanchangyixia1 then
					var_434_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_434_5.name = "zhuanchangyixia1"
					arg_431_1.var_.effectzhuanchangyixia1 = var_434_5
				else
					var_434_5.transform:SetParent(var_434_9000)
				end

				var_434_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_434_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_434_5.transform.localScale = Vector3.New(var_434_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_434_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_434_5.transform.localScale.z)
			end

			local var_434_7 = 0

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_7 + arg_434_0 then
				arg_431_1.allBtn_.enabled = false
			end

			if arg_431_1.time_ >= var_434_7 + 1.674999999999 and arg_431_1.time_ < var_434_7 + 1.674999999999 + arg_434_0 then
				arg_431_1.allBtn_.enabled = true
			end

			if 1.2 < arg_431_1.time_ and arg_431_1.time_ <= 1.2 + arg_434_0 then
				arg_431_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street01", "")
			end

			if 0.1 < arg_431_1.time_ and arg_431_1.time_ <= 0.1 + arg_434_0 then
				arg_431_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_10 = 1.46666666666667
			local var_434_11 = 0.7

			if 1.46666666666667 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_12 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_12:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_13 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(1104703106).content)

				arg_431_1.text_.text = var_434_13

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_15 = 28 <= 0 and var_434_11 or var_434_11 * (utf8.len(var_434_13) / 28)

				if (28 <= 0 and var_434_11 or var_434_11 * (utf8.len(var_434_13) / 28)) > 0 and var_434_11 < var_434_15 then
					arg_431_1.talkMaxDuration = var_434_15
					var_434_10 = var_434_10 + 0.3

					if var_434_15 + var_434_10 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_15 + var_434_10
					end
				end

				arg_431_1.text_.text = var_434_13
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = var_434_10 + 0.3
			local var_434_17 = math.max(var_434_11, arg_431_1.talkMaxDuration)

			if var_434_10 + 0.3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_16 + var_434_17 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_16) / var_434_17

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_16 + var_434_17 and arg_431_1.time_ < var_434_16 + var_434_17 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1104703107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104703107
		arg_437_1.duration_ = 6.93

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104703108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1047ui_story = arg_437_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1047ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story == nil then
				arg_437_1.var_.characterEffect1047ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1047ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story then
				arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_440_4 = 0
			local var_440_5 = 0.65

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1104703107)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 26 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 26)

				if (26 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 26)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703107", "story_v_side_new_1104703.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703107", "story_v_side_new_1104703.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1104703", "1104703107", "story_v_side_new_1104703.awb")

						arg_437_1:RecordAudio("1104703107", var_440_11)
						arg_437_1:RecordAudio("1104703107", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703107", "story_v_side_new_1104703.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703107", "story_v_side_new_1104703.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
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

		arg_437_1:InitPlayNodeList()
	end,
	Play1104703108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104703108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104703109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1047ui_story"]) and arg_441_1.var_.characterEffect1047ui_story == nil then
				arg_441_1.var_.characterEffect1047ui_story = arg_441_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1047ui_story"]) then
				if arg_441_1.var_.characterEffect1047ui_story and not isNil(arg_441_1.actors_["1047ui_story"]) then
					arg_441_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1047ui_story"]) and arg_441_1.var_.characterEffect1047ui_story then
				arg_441_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.25

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1104703108).content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 10 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 10)

				if (10 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 10)) > 0 and var_444_2 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_6 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_6 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_6

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_6 and arg_441_1.time_ < var_444_1 + var_444_6 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104703109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104703109
		arg_445_1.duration_ = 7.43

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104703110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1047ui_story = arg_445_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).z)
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles = arg_445_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_445_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).z)
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles = arg_445_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_448_1 = arg_445_1.actors_["1047ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1047ui_story == nil then
				arg_445_1.var_.characterEffect1047ui_story = var_448_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_2 and not isNil(var_448_1) then
				if arg_445_1.var_.characterEffect1047ui_story and not isNil(var_448_1) then
					arg_445_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_2 and arg_445_1.time_ < 0 + var_448_2 + arg_448_0 and not isNil(var_448_1) and arg_445_1.var_.characterEffect1047ui_story then
				arg_445_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_448_4 = 0
			local var_448_5 = 0.875

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(1104703109)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 35 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 35)

				if (35 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 35)) > 0 and var_448_5 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703109", "story_v_side_new_1104703.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703109", "story_v_side_new_1104703.awb") / 1000

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end

					if var_448_6.prefab_name ~= "" and arg_445_1.actors_[var_448_6.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_6.prefab_name].transform, "story_v_side_new_1104703", "1104703109", "story_v_side_new_1104703.awb")

						arg_445_1:RecordAudio("1104703109", var_448_11)
						arg_445_1:RecordAudio("1104703109", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703109", "story_v_side_new_1104703.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703109", "story_v_side_new_1104703.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_12 and arg_445_1.time_ < var_448_4 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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

		arg_445_1:InitPlayNodeList()
	end,
	Play1104703110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104703110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104703111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) and arg_449_1.var_.characterEffect1047ui_story == nil then
				arg_449_1.var_.characterEffect1047ui_story = arg_449_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) then
				if arg_449_1.var_.characterEffect1047ui_story and not isNil(arg_449_1.actors_["1047ui_story"]) then
					arg_449_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) and arg_449_1.var_.characterEffect1047ui_story then
				arg_449_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_452_1 = 0
			local var_452_2 = 0.475

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1104703110).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 19 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 19)

				if (19 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 19)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104703111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104703111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104703112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1047ui_story = arg_453_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1047ui_story"].transform.position).z)
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1047ui_story"].transform.localEulerAngles = arg_453_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_456_1 = 0
			local var_456_2 = 0.5

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1104703111).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 20 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 20)

				if (20 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 20)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play1104703112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104703112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104703113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.975

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1104703112).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 39 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 39)

				if (39 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 39)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104703113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104703113
		arg_461_1.duration_ = 10.77

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104703114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1047ui_story = arg_461_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_461_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1047ui_story"].transform.position).z)
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1047ui_story"].transform.localEulerAngles = arg_461_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["1047ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1047ui_story == nil then
				arg_461_1.var_.characterEffect1047ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1047ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1047ui_story then
				arg_461_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_464_4 = 0
			local var_464_5 = 1.35

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(1104703113)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 54 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 54)

				if (54 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 54)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703113", "story_v_side_new_1104703.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703113", "story_v_side_new_1104703.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_side_new_1104703", "1104703113", "story_v_side_new_1104703.awb")

						arg_461_1:RecordAudio("1104703113", var_464_11)
						arg_461_1:RecordAudio("1104703113", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703113", "story_v_side_new_1104703.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703113", "story_v_side_new_1104703.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play1104703114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104703114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104703115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) and arg_465_1.var_.characterEffect1047ui_story == nil then
				arg_465_1.var_.characterEffect1047ui_story = arg_465_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) then
				if arg_465_1.var_.characterEffect1047ui_story and not isNil(arg_465_1.actors_["1047ui_story"]) then
					arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) and arg_465_1.var_.characterEffect1047ui_story then
				arg_465_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0
			local var_468_2 = 0.775

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
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

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1104703114).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 31 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 31)

				if (31 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 31)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104703115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104703115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104703116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.675

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

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1104703115).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 27 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 27)

				if (27 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 27)) > 0 and var_472_0 < var_472_3 then
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
	Play1104703116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104703116
		arg_473_1.duration_ = 4.93

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104703117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1047ui_story"]) and arg_473_1.var_.characterEffect1047ui_story == nil then
				arg_473_1.var_.characterEffect1047ui_story = arg_473_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1047ui_story"]) then
				if arg_473_1.var_.characterEffect1047ui_story and not isNil(arg_473_1.actors_["1047ui_story"]) then
					arg_473_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1047ui_story"]) and arg_473_1.var_.characterEffect1047ui_story then
				arg_473_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_476_2 = 0
			local var_476_3 = 0.525

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:GetWordFromCfg(1104703116)
				local var_476_5 = arg_473_1:FormatText(var_476_4.content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 21 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 21)

				if (21 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 21)) > 0 and var_476_3 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703116", "story_v_side_new_1104703.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703116", "story_v_side_new_1104703.awb") / 1000

					if var_476_8 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_2
					end

					if var_476_4.prefab_name ~= "" and arg_473_1.actors_[var_476_4.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_4.prefab_name].transform, "story_v_side_new_1104703", "1104703116", "story_v_side_new_1104703.awb")

						arg_473_1:RecordAudio("1104703116", var_476_9)
						arg_473_1:RecordAudio("1104703116", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703116", "story_v_side_new_1104703.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703116", "story_v_side_new_1104703.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_10 and arg_473_1.time_ < var_476_2 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104703117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104703117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104703118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1047ui_story"]) and arg_477_1.var_.characterEffect1047ui_story == nil then
				arg_477_1.var_.characterEffect1047ui_story = arg_477_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1047ui_story"]) then
				if arg_477_1.var_.characterEffect1047ui_story and not isNil(arg_477_1.actors_["1047ui_story"]) then
					arg_477_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1047ui_story"]) and arg_477_1.var_.characterEffect1047ui_story then
				arg_477_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_480_1 = arg_477_1.actors_["1047ui_story"].transform

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1047ui_story = var_480_1.localPosition
			end

			local var_480_2 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 then
				var_480_1.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 0) / var_480_2)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 then
				var_480_1.localPosition = Vector3.New(0, 100, 0)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			local var_480_3 = 0
			local var_480_4 = 0.325

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_3 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_5 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1104703117).content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 13 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_5) / 13)

				if (13 <= 0 and var_480_4 or var_480_4 * (utf8.len(var_480_5) / 13)) > 0 and var_480_4 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_3 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_3
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_4, arg_477_1.talkMaxDuration)

			if var_480_3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_3 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_3) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_3 + var_480_8 and arg_477_1.time_ < var_480_3 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play1104703118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104703118
		arg_481_1.duration_ = 5.6

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104703119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1047ui_story = arg_481_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).z)
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles = arg_481_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_481_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1047ui_story"].transform.position).z)
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1047ui_story"].transform.localEulerAngles = arg_481_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1047ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1047ui_story == nil then
				arg_481_1.var_.characterEffect1047ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1047ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1047ui_story then
				arg_481_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_484_4 = 0
			local var_484_5 = 0.575

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_6 = arg_481_1:GetWordFromCfg(1104703118)
				local var_484_7 = arg_481_1:FormatText(var_484_6.content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 23 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 23)

				if (23 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 23)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703118", "story_v_side_new_1104703.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703118", "story_v_side_new_1104703.awb") / 1000

					if var_484_10 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_4
					end

					if var_484_6.prefab_name ~= "" and arg_481_1.actors_[var_484_6.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_6.prefab_name].transform, "story_v_side_new_1104703", "1104703118", "story_v_side_new_1104703.awb")

						arg_481_1:RecordAudio("1104703118", var_484_11)
						arg_481_1:RecordAudio("1104703118", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703118", "story_v_side_new_1104703.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703118", "story_v_side_new_1104703.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_12 and arg_481_1.time_ < var_484_4 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play1104703119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104703119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104703120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1047ui_story"]) and arg_485_1.var_.characterEffect1047ui_story == nil then
				arg_485_1.var_.characterEffect1047ui_story = arg_485_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1047ui_story"]) then
				if arg_485_1.var_.characterEffect1047ui_story and not isNil(arg_485_1.actors_["1047ui_story"]) then
					arg_485_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_0)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1047ui_story"]) and arg_485_1.var_.characterEffect1047ui_story then
				arg_485_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_488_1 = arg_485_1.actors_["1047ui_story"].transform

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1047ui_story = var_488_1.localPosition
			end

			local var_488_2 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 then
				var_488_1.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_2)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 then
				var_488_1.localPosition = Vector3.New(0, 100, 0)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			local var_488_3 = 0
			local var_488_4 = 1.175

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_3 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1104703119).content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 47 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 47)

				if (47 <= 0 and var_488_4 or var_488_4 * (utf8.len(var_488_5) / 47)) > 0 and var_488_4 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_3 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_3
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_8 = math.max(var_488_4, arg_485_1.talkMaxDuration)

			if var_488_3 <= arg_485_1.time_ and arg_485_1.time_ < var_488_3 + var_488_8 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_3) / var_488_8

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_3 + var_488_8 and arg_485_1.time_ < var_488_3 + var_488_8 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play1104703120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104703120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104703121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.225

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1104703120).content)

				arg_489_1.text_.text = var_492_1

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_3 = 9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 9)

				if (9 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_1) / 9)) > 0 and var_492_0 < var_492_3 then
					arg_489_1.talkMaxDuration = var_492_3

					if var_492_3 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_3 + 0
					end
				end

				arg_489_1.text_.text = var_492_1
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_4 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_4

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104703121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104703121
		arg_493_1.duration_ = 2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104703122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1047ui_story = arg_493_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).z)
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles = arg_493_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_493_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1047ui_story"].transform.position).z)
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1047ui_story"].transform.localEulerAngles = arg_493_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1047ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1047ui_story == nil then
				arg_493_1.var_.characterEffect1047ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1047ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1047ui_story then
				arg_493_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_496_4 = 0
			local var_496_5 = 0.1

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(1104703121)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 4 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 4)

				if (4 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 4)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703121", "story_v_side_new_1104703.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703121", "story_v_side_new_1104703.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_side_new_1104703", "1104703121", "story_v_side_new_1104703.awb")

						arg_493_1:RecordAudio("1104703121", var_496_11)
						arg_493_1:RecordAudio("1104703121", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703121", "story_v_side_new_1104703.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703121", "story_v_side_new_1104703.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play1104703122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104703122
		arg_497_1.duration_ = 4.47

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104703123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1047ui_story = arg_497_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).z)
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles = arg_497_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_497_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1047ui_story"].transform.position).z)
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1047ui_story"].transform.localEulerAngles = arg_497_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_500_1 = 0
			local var_500_2 = 0.55

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(1104703122)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 22 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 22)

				if (22 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 22)) > 0 and var_500_2 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703122", "story_v_side_new_1104703.awb") ~= 0 then
					local var_500_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703122", "story_v_side_new_1104703.awb") / 1000

					if var_500_7 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_1
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_side_new_1104703", "1104703122", "story_v_side_new_1104703.awb")

						arg_497_1:RecordAudio("1104703122", var_500_8)
						arg_497_1:RecordAudio("1104703122", var_500_8)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703122", "story_v_side_new_1104703.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703122", "story_v_side_new_1104703.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_9 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_9 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_9

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_9 and arg_497_1.time_ < var_500_1 + var_500_9 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
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

		arg_497_1:InitPlayNodeList()
	end,
	Play1104703123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104703123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104703124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1047ui_story"]) and arg_501_1.var_.characterEffect1047ui_story == nil then
				arg_501_1.var_.characterEffect1047ui_story = arg_501_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1047ui_story"]) then
				if arg_501_1.var_.characterEffect1047ui_story and not isNil(arg_501_1.actors_["1047ui_story"]) then
					arg_501_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1047ui_story"]) and arg_501_1.var_.characterEffect1047ui_story then
				arg_501_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_504_1 = 0
			local var_504_2 = 1.225

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1104703123).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 49 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 49)

				if (49 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 49)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104703124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104703124
		arg_505_1.duration_ = 8.37

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104703125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1047ui_story"]) and arg_505_1.var_.characterEffect1047ui_story == nil then
				arg_505_1.var_.characterEffect1047ui_story = arg_505_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1047ui_story"]) then
				if arg_505_1.var_.characterEffect1047ui_story and not isNil(arg_505_1.actors_["1047ui_story"]) then
					arg_505_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1047ui_story"]) and arg_505_1.var_.characterEffect1047ui_story then
				arg_505_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_508_2 = 0
			local var_508_3 = 0.875

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_2 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_4 = arg_505_1:GetWordFromCfg(1104703124)
				local var_508_5 = arg_505_1:FormatText(var_508_4.content)

				arg_505_1.text_.text = var_508_5

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_7 = 35 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_5) / 35)

				if (35 <= 0 and var_508_3 or var_508_3 * (utf8.len(var_508_5) / 35)) > 0 and var_508_3 < var_508_7 then
					arg_505_1.talkMaxDuration = var_508_7

					if var_508_7 + var_508_2 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_7 + var_508_2
					end
				end

				arg_505_1.text_.text = var_508_5
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703124", "story_v_side_new_1104703.awb") ~= 0 then
					local var_508_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703124", "story_v_side_new_1104703.awb") / 1000

					if var_508_8 + var_508_2 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_8 + var_508_2
					end

					if var_508_4.prefab_name ~= "" and arg_505_1.actors_[var_508_4.prefab_name] ~= nil then
						local var_508_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_4.prefab_name].transform, "story_v_side_new_1104703", "1104703124", "story_v_side_new_1104703.awb")

						arg_505_1:RecordAudio("1104703124", var_508_9)
						arg_505_1:RecordAudio("1104703124", var_508_9)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703124", "story_v_side_new_1104703.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703124", "story_v_side_new_1104703.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_10 = math.max(var_508_3, arg_505_1.talkMaxDuration)

			if var_508_2 <= arg_505_1.time_ and arg_505_1.time_ < var_508_2 + var_508_10 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_2) / var_508_10

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_2 + var_508_10 and arg_505_1.time_ < var_508_2 + var_508_10 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104703125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104703125
		arg_509_1.duration_ = 4.7

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1104703126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_512_0 = 0
			local var_512_1 = 0.525

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_2 = arg_509_1:GetWordFromCfg(1104703125)
				local var_512_3 = arg_509_1:FormatText(var_512_2.content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 21 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 21)

				if (21 <= 0 and var_512_1 or var_512_1 * (utf8.len(var_512_3) / 21)) > 0 and var_512_1 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_0
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703125", "story_v_side_new_1104703.awb") ~= 0 then
					local var_512_6 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703125", "story_v_side_new_1104703.awb") / 1000

					if var_512_6 + var_512_0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_6 + var_512_0
					end

					if var_512_2.prefab_name ~= "" and arg_509_1.actors_[var_512_2.prefab_name] ~= nil then
						local var_512_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_2.prefab_name].transform, "story_v_side_new_1104703", "1104703125", "story_v_side_new_1104703.awb")

						arg_509_1:RecordAudio("1104703125", var_512_7)
						arg_509_1:RecordAudio("1104703125", var_512_7)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703125", "story_v_side_new_1104703.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703125", "story_v_side_new_1104703.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_8 = math.max(var_512_1, arg_509_1.talkMaxDuration)

			if var_512_0 <= arg_509_1.time_ and arg_509_1.time_ < var_512_0 + var_512_8 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_0) / var_512_8

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_0 + var_512_8 and arg_509_1.time_ < var_512_0 + var_512_8 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104703126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104703126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1104703127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1047ui_story"]) and arg_513_1.var_.characterEffect1047ui_story == nil then
				arg_513_1.var_.characterEffect1047ui_story = arg_513_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1047ui_story"]) then
				if arg_513_1.var_.characterEffect1047ui_story and not isNil(arg_513_1.actors_["1047ui_story"]) then
					arg_513_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1047ui_story"]) and arg_513_1.var_.characterEffect1047ui_story then
				arg_513_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.35

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1104703126).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 14 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 14)

				if (14 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 14)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1104703127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104703127
		arg_517_1.duration_ = 4.73

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104703128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(arg_517_1.actors_["1047ui_story"]) and arg_517_1.var_.characterEffect1047ui_story == nil then
				arg_517_1.var_.characterEffect1047ui_story = arg_517_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_0 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 and not isNil(arg_517_1.actors_["1047ui_story"]) then
				if arg_517_1.var_.characterEffect1047ui_story and not isNil(arg_517_1.actors_["1047ui_story"]) then
					arg_517_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 and not isNil(arg_517_1.actors_["1047ui_story"]) and arg_517_1.var_.characterEffect1047ui_story then
				arg_517_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action462")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_520_2 = 0
			local var_520_3 = 0.45

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_2 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_4 = arg_517_1:GetWordFromCfg(1104703127)
				local var_520_5 = arg_517_1:FormatText(var_520_4.content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 18 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 18)

				if (18 <= 0 and var_520_3 or var_520_3 * (utf8.len(var_520_5) / 18)) > 0 and var_520_3 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_2
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703127", "story_v_side_new_1104703.awb") ~= 0 then
					local var_520_8 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703127", "story_v_side_new_1104703.awb") / 1000

					if var_520_8 + var_520_2 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_8 + var_520_2
					end

					if var_520_4.prefab_name ~= "" and arg_517_1.actors_[var_520_4.prefab_name] ~= nil then
						local var_520_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_4.prefab_name].transform, "story_v_side_new_1104703", "1104703127", "story_v_side_new_1104703.awb")

						arg_517_1:RecordAudio("1104703127", var_520_9)
						arg_517_1:RecordAudio("1104703127", var_520_9)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703127", "story_v_side_new_1104703.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703127", "story_v_side_new_1104703.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_10 = math.max(var_520_3, arg_517_1.talkMaxDuration)

			if var_520_2 <= arg_517_1.time_ and arg_517_1.time_ < var_520_2 + var_520_10 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_2) / var_520_10

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_2 + var_520_10 and arg_517_1.time_ < var_520_2 + var_520_10 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104703128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104703128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104703129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1047ui_story"]) and arg_521_1.var_.characterEffect1047ui_story == nil then
				arg_521_1.var_.characterEffect1047ui_story = arg_521_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1047ui_story"]) then
				if arg_521_1.var_.characterEffect1047ui_story and not isNil(arg_521_1.actors_["1047ui_story"]) then
					arg_521_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1047ui_story"]) and arg_521_1.var_.characterEffect1047ui_story then
				arg_521_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_524_1 = arg_521_1.actors_["1047ui_story"].transform

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.var_.moveOldPos1047ui_story = var_524_1.localPosition
			end

			local var_524_2 = 0.001

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 then
				var_524_1.localPosition = Vector3.Lerp(arg_521_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_521_1.time_ - 0) / var_524_2)
				var_524_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_524_1.position).x, (manager.ui.mainCamera.transform.position - var_524_1.position).y, (manager.ui.mainCamera.transform.position - var_524_1.position).z)
				var_524_1.localEulerAngles.z = 0
				var_524_1.localEulerAngles.x = 0
				var_524_1.localEulerAngles = var_524_1.localEulerAngles
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 then
				var_524_1.localPosition = Vector3.New(0, 100, 0)
				var_524_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_524_1.position).x, (manager.ui.mainCamera.transform.position - var_524_1.position).y, (manager.ui.mainCamera.transform.position - var_524_1.position).z)
				var_524_1.localEulerAngles.z = 0
				var_524_1.localEulerAngles.x = 0
				var_524_1.localEulerAngles = var_524_1.localEulerAngles
			end

			local var_524_3 = 0
			local var_524_4 = 0.8

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_3 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_5 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1104703128).content)

				arg_521_1.text_.text = var_524_5

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_7 = 32 <= 0 and var_524_4 or var_524_4 * (utf8.len(var_524_5) / 32)

				if (32 <= 0 and var_524_4 or var_524_4 * (utf8.len(var_524_5) / 32)) > 0 and var_524_4 < var_524_7 then
					arg_521_1.talkMaxDuration = var_524_7

					if var_524_7 + var_524_3 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_7 + var_524_3
					end
				end

				arg_521_1.text_.text = var_524_5
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_8 = math.max(var_524_4, arg_521_1.talkMaxDuration)

			if var_524_3 <= arg_521_1.time_ and arg_521_1.time_ < var_524_3 + var_524_8 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_3) / var_524_8

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_3 + var_524_8 and arg_521_1.time_ < var_524_3 + var_524_8 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {
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

		arg_521_1:InitPlayNodeList()
	end,
	Play1104703129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104703129
		arg_525_1.duration_ = 6.87

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1104703130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1047ui_story = arg_525_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_528_0 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 then
				arg_525_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_525_1.time_ - 0) / var_528_0)
				arg_525_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).z)
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles = arg_525_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 then
				arg_525_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_525_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1047ui_story"].transform.position).z)
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1047ui_story"].transform.localEulerAngles = arg_525_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_528_1 = arg_525_1.actors_["1047ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1047ui_story == nil then
				arg_525_1.var_.characterEffect1047ui_story = var_528_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_2 and not isNil(var_528_1) then
				if arg_525_1.var_.characterEffect1047ui_story and not isNil(var_528_1) then
					arg_525_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_2 and arg_525_1.time_ < 0 + var_528_2 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1047ui_story then
				arg_525_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_528_4 = 0
			local var_528_5 = 0.825

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_6 = arg_525_1:GetWordFromCfg(1104703129)
				local var_528_7 = arg_525_1:FormatText(var_528_6.content)

				arg_525_1.text_.text = var_528_7

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_9 = 33 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 33)

				if (33 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 33)) > 0 and var_528_5 < var_528_9 then
					arg_525_1.talkMaxDuration = var_528_9

					if var_528_9 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_4
					end
				end

				arg_525_1.text_.text = var_528_7
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703129", "story_v_side_new_1104703.awb") ~= 0 then
					local var_528_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703129", "story_v_side_new_1104703.awb") / 1000

					if var_528_10 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_4
					end

					if var_528_6.prefab_name ~= "" and arg_525_1.actors_[var_528_6.prefab_name] ~= nil then
						local var_528_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_6.prefab_name].transform, "story_v_side_new_1104703", "1104703129", "story_v_side_new_1104703.awb")

						arg_525_1:RecordAudio("1104703129", var_528_11)
						arg_525_1:RecordAudio("1104703129", var_528_11)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703129", "story_v_side_new_1104703.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703129", "story_v_side_new_1104703.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_12 = math.max(var_528_5, arg_525_1.talkMaxDuration)

			if var_528_4 <= arg_525_1.time_ and arg_525_1.time_ < var_528_4 + var_528_12 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_4) / var_528_12

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_4 + var_528_12 and arg_525_1.time_ < var_528_4 + var_528_12 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
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

		arg_525_1:InitPlayNodeList()
	end,
	Play1104703130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104703130
		arg_529_1.duration_ = 12.8

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1104703131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = 1.25

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_1 = arg_529_1:GetWordFromCfg(1104703130)
				local var_532_2 = arg_529_1:FormatText(var_532_1.content)

				arg_529_1.text_.text = var_532_2

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_4 = 50 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 50)

				if (50 <= 0 and var_532_0 or var_532_0 * (utf8.len(var_532_2) / 50)) > 0 and var_532_0 < var_532_4 then
					arg_529_1.talkMaxDuration = var_532_4

					if var_532_4 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_4 + 0
					end
				end

				arg_529_1.text_.text = var_532_2
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703130", "story_v_side_new_1104703.awb") ~= 0 then
					local var_532_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703130", "story_v_side_new_1104703.awb") / 1000

					if var_532_5 + 0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + 0
					end

					if var_532_1.prefab_name ~= "" and arg_529_1.actors_[var_532_1.prefab_name] ~= nil then
						local var_532_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_1.prefab_name].transform, "story_v_side_new_1104703", "1104703130", "story_v_side_new_1104703.awb")

						arg_529_1:RecordAudio("1104703130", var_532_6)
						arg_529_1:RecordAudio("1104703130", var_532_6)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703130", "story_v_side_new_1104703.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703130", "story_v_side_new_1104703.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_7 = math.max(var_532_0, arg_529_1.talkMaxDuration)

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_7 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - 0) / var_532_7

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= 0 + var_532_7 and arg_529_1.time_ < 0 + var_532_7 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104703131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1104703131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1104703132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(arg_533_1.actors_["1047ui_story"]) and arg_533_1.var_.characterEffect1047ui_story == nil then
				arg_533_1.var_.characterEffect1047ui_story = arg_533_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_0 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 and not isNil(arg_533_1.actors_["1047ui_story"]) then
				if arg_533_1.var_.characterEffect1047ui_story and not isNil(arg_533_1.actors_["1047ui_story"]) then
					arg_533_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_0)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 and not isNil(arg_533_1.actors_["1047ui_story"]) and arg_533_1.var_.characterEffect1047ui_story then
				arg_533_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_536_1 = 0
			local var_536_2 = 0.6

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, true)
				arg_533_1.iconController_:SetSelectedState("hero")

				arg_533_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_533_1.callingController_:SetSelectedState("normal")

				arg_533_1.keyicon_.color = Color.New(1, 1, 1)
				arg_533_1.icon_.color = Color.New(1, 1, 1)

				local var_536_3 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1104703131).content)

				arg_533_1.text_.text = var_536_3

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_5 = 24 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 24)

				if (24 <= 0 and var_536_2 or var_536_2 * (utf8.len(var_536_3) / 24)) > 0 and var_536_2 < var_536_5 then
					arg_533_1.talkMaxDuration = var_536_5

					if var_536_5 + var_536_1 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + var_536_1
					end
				end

				arg_533_1.text_.text = var_536_3
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_6 = math.max(var_536_2, arg_533_1.talkMaxDuration)

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_6 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_1) / var_536_6

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_1 + var_536_6 and arg_533_1.time_ < var_536_1 + var_536_6 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1104703132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1104703132
		arg_537_1.duration_ = 4.53

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1104703133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1047ui_story = arg_537_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_540_0 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 then
				arg_537_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_537_1.time_ - 0) / var_540_0)
				arg_537_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).z)
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles = arg_537_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 then
				arg_537_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_537_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_537_1.actors_["1047ui_story"].transform.position).z)
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_537_1.actors_["1047ui_story"].transform.localEulerAngles = arg_537_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_540_1 = arg_537_1.actors_["1047ui_story"]

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1047ui_story == nil then
				arg_537_1.var_.characterEffect1047ui_story = var_540_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_2 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_2 and not isNil(var_540_1) then
				if arg_537_1.var_.characterEffect1047ui_story and not isNil(var_540_1) then
					arg_537_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_2 and arg_537_1.time_ < 0 + var_540_2 + arg_540_0 and not isNil(var_540_1) and arg_537_1.var_.characterEffect1047ui_story then
				arg_537_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_4 = 0
			local var_540_5 = 0.525

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_4 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_6 = arg_537_1:GetWordFromCfg(1104703132)
				local var_540_7 = arg_537_1:FormatText(var_540_6.content)

				arg_537_1.text_.text = var_540_7

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_9 = 21 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 21)

				if (21 <= 0 and var_540_5 or var_540_5 * (utf8.len(var_540_7) / 21)) > 0 and var_540_5 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_4
					end
				end

				arg_537_1.text_.text = var_540_7
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703132", "story_v_side_new_1104703.awb") ~= 0 then
					local var_540_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703132", "story_v_side_new_1104703.awb") / 1000

					if var_540_10 + var_540_4 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_4
					end

					if var_540_6.prefab_name ~= "" and arg_537_1.actors_[var_540_6.prefab_name] ~= nil then
						local var_540_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_6.prefab_name].transform, "story_v_side_new_1104703", "1104703132", "story_v_side_new_1104703.awb")

						arg_537_1:RecordAudio("1104703132", var_540_11)
						arg_537_1:RecordAudio("1104703132", var_540_11)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703132", "story_v_side_new_1104703.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703132", "story_v_side_new_1104703.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_12 = math.max(var_540_5, arg_537_1.talkMaxDuration)

			if var_540_4 <= arg_537_1.time_ and arg_537_1.time_ < var_540_4 + var_540_12 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_4) / var_540_12

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_4 + var_540_12 and arg_537_1.time_ < var_540_4 + var_540_12 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
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

		arg_537_1:InitPlayNodeList()
	end,
	Play1104703133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1104703133
		arg_541_1.duration_ = 7.17

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1104703134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1047ui_story = arg_541_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).z)
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles = arg_541_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_541_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["1047ui_story"].transform.position).z)
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["1047ui_story"].transform.localEulerAngles = arg_541_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_544_1 = 0
			local var_544_2 = 0.85

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(1104703133)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_6 = 34 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_4) / 34)

				if (34 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_4) / 34)) > 0 and var_544_2 < var_544_6 then
					arg_541_1.talkMaxDuration = var_544_6

					if var_544_6 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_6 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703133", "story_v_side_new_1104703.awb") ~= 0 then
					local var_544_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703133", "story_v_side_new_1104703.awb") / 1000

					if var_544_7 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_1
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1104703", "1104703133", "story_v_side_new_1104703.awb")

						arg_541_1:RecordAudio("1104703133", var_544_8)
						arg_541_1:RecordAudio("1104703133", var_544_8)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703133", "story_v_side_new_1104703.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703133", "story_v_side_new_1104703.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_9 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_9 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_9

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_9 and arg_541_1.time_ < var_544_1 + var_544_9 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
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

		arg_541_1:InitPlayNodeList()
	end,
	Play1104703134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1104703134
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1104703135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["1047ui_story"]) and arg_545_1.var_.characterEffect1047ui_story == nil then
				arg_545_1.var_.characterEffect1047ui_story = arg_545_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["1047ui_story"]) then
				if arg_545_1.var_.characterEffect1047ui_story and not isNil(arg_545_1.actors_["1047ui_story"]) then
					arg_545_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_545_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_0)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["1047ui_story"]) and arg_545_1.var_.characterEffect1047ui_story then
				arg_545_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_545_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_548_1 = 0
			local var_548_2 = 0.25

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_1 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1104703134).content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 10 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_3) / 10)

				if (10 <= 0 and var_548_2 or var_548_2 * (utf8.len(var_548_3) / 10)) > 0 and var_548_2 < var_548_5 then
					arg_545_1.talkMaxDuration = var_548_5

					if var_548_5 + var_548_1 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + var_548_1
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_6 = math.max(var_548_2, arg_545_1.talkMaxDuration)

			if var_548_1 <= arg_545_1.time_ and arg_545_1.time_ < var_548_1 + var_548_6 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_1) / var_548_6

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_1 + var_548_6 and arg_545_1.time_ < var_548_1 + var_548_6 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1104703135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104703135
		arg_549_1.duration_ = 2

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104703136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.var_.moveOldPos1047ui_story = arg_549_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_552_0 = 0.001

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 then
				arg_549_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_549_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_549_1.time_ - 0) / var_552_0)
				arg_549_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).z)
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles = arg_549_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 then
				arg_549_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_549_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_549_1.actors_["1047ui_story"].transform.position).z)
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_549_1.actors_["1047ui_story"].transform.localEulerAngles = arg_549_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_552_1 = arg_549_1.actors_["1047ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1047ui_story == nil then
				arg_549_1.var_.characterEffect1047ui_story = var_552_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_2 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_2 and not isNil(var_552_1) then
				if arg_549_1.var_.characterEffect1047ui_story and not isNil(var_552_1) then
					arg_549_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= 0 + var_552_2 and arg_549_1.time_ < 0 + var_552_2 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1047ui_story then
				arg_549_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action442")
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_552_4 = 0
			local var_552_5 = 0.175

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_4 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_6 = arg_549_1:GetWordFromCfg(1104703135)
				local var_552_7 = arg_549_1:FormatText(var_552_6.content)

				arg_549_1.text_.text = var_552_7

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_9 = 7 <= 0 and var_552_5 or var_552_5 * (utf8.len(var_552_7) / 7)

				if (7 <= 0 and var_552_5 or var_552_5 * (utf8.len(var_552_7) / 7)) > 0 and var_552_5 < var_552_9 then
					arg_549_1.talkMaxDuration = var_552_9

					if var_552_9 + var_552_4 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_9 + var_552_4
					end
				end

				arg_549_1.text_.text = var_552_7
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703135", "story_v_side_new_1104703.awb") ~= 0 then
					local var_552_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703135", "story_v_side_new_1104703.awb") / 1000

					if var_552_10 + var_552_4 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_10 + var_552_4
					end

					if var_552_6.prefab_name ~= "" and arg_549_1.actors_[var_552_6.prefab_name] ~= nil then
						local var_552_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_6.prefab_name].transform, "story_v_side_new_1104703", "1104703135", "story_v_side_new_1104703.awb")

						arg_549_1:RecordAudio("1104703135", var_552_11)
						arg_549_1:RecordAudio("1104703135", var_552_11)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703135", "story_v_side_new_1104703.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703135", "story_v_side_new_1104703.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_12 = math.max(var_552_5, arg_549_1.talkMaxDuration)

			if var_552_4 <= arg_549_1.time_ and arg_549_1.time_ < var_552_4 + var_552_12 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_4) / var_552_12

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_4 + var_552_12 and arg_549_1.time_ < var_552_4 + var_552_12 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {
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

		arg_549_1:InitPlayNodeList()
	end,
	Play1104703136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104703136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104703137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1047ui_story"]) and arg_553_1.var_.characterEffect1047ui_story == nil then
				arg_553_1.var_.characterEffect1047ui_story = arg_553_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1047ui_story"]) then
				if arg_553_1.var_.characterEffect1047ui_story and not isNil(arg_553_1.actors_["1047ui_story"]) then
					arg_553_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1047ui_story"]) and arg_553_1.var_.characterEffect1047ui_story then
				arg_553_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_556_1 = arg_553_1.actors_["1047ui_story"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1047ui_story = var_556_1.localPosition
			end

			local var_556_2 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 then
				var_556_1.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_553_1.time_ - 0) / var_556_2)
				var_556_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_556_1.position).x, (manager.ui.mainCamera.transform.position - var_556_1.position).y, (manager.ui.mainCamera.transform.position - var_556_1.position).z)
				var_556_1.localEulerAngles.z = 0
				var_556_1.localEulerAngles.x = 0
				var_556_1.localEulerAngles = var_556_1.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 then
				var_556_1.localPosition = Vector3.New(0, 100, 0)
				var_556_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_556_1.position).x, (manager.ui.mainCamera.transform.position - var_556_1.position).y, (manager.ui.mainCamera.transform.position - var_556_1.position).z)
				var_556_1.localEulerAngles.z = 0
				var_556_1.localEulerAngles.x = 0
				var_556_1.localEulerAngles = var_556_1.localEulerAngles
			end

			local var_556_3 = 0
			local var_556_4 = 0.7

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_3 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_5 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1104703136).content)

				arg_553_1.text_.text = var_556_5

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_7 = 28 <= 0 and var_556_4 or var_556_4 * (utf8.len(var_556_5) / 28)

				if (28 <= 0 and var_556_4 or var_556_4 * (utf8.len(var_556_5) / 28)) > 0 and var_556_4 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_3 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_3
					end
				end

				arg_553_1.text_.text = var_556_5
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_8 = math.max(var_556_4, arg_553_1.talkMaxDuration)

			if var_556_3 <= arg_553_1.time_ and arg_553_1.time_ < var_556_3 + var_556_8 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_3) / var_556_8

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_3 + var_556_8 and arg_553_1.time_ < var_556_3 + var_556_8 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
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

		arg_553_1:InitPlayNodeList()
	end,
	Play1104703137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104703137
		arg_557_1.duration_ = 7.1

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104703138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1047ui_story = arg_557_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_560_0 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 then
				arg_557_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_557_1.time_ - 0) / var_560_0)
				arg_557_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).z)
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles = arg_557_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 then
				arg_557_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_557_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["1047ui_story"].transform.position).z)
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["1047ui_story"].transform.localEulerAngles = arg_557_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_560_1 = arg_557_1.actors_["1047ui_story"]

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(var_560_1) and arg_557_1.var_.characterEffect1047ui_story == nil then
				arg_557_1.var_.characterEffect1047ui_story = var_560_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_2 and not isNil(var_560_1) then
				if arg_557_1.var_.characterEffect1047ui_story and not isNil(var_560_1) then
					arg_557_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= 0 + var_560_2 and arg_557_1.time_ < 0 + var_560_2 + arg_560_0 and not isNil(var_560_1) and arg_557_1.var_.characterEffect1047ui_story then
				arg_557_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_560_4 = 0
			local var_560_5 = 0.65

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_6 = arg_557_1:GetWordFromCfg(1104703137)
				local var_560_7 = arg_557_1:FormatText(var_560_6.content)

				arg_557_1.text_.text = var_560_7

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_9 = 26 <= 0 and var_560_5 or var_560_5 * (utf8.len(var_560_7) / 26)

				if (26 <= 0 and var_560_5 or var_560_5 * (utf8.len(var_560_7) / 26)) > 0 and var_560_5 < var_560_9 then
					arg_557_1.talkMaxDuration = var_560_9

					if var_560_9 + var_560_4 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_9 + var_560_4
					end
				end

				arg_557_1.text_.text = var_560_7
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703137", "story_v_side_new_1104703.awb") ~= 0 then
					local var_560_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703137", "story_v_side_new_1104703.awb") / 1000

					if var_560_10 + var_560_4 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_10 + var_560_4
					end

					if var_560_6.prefab_name ~= "" and arg_557_1.actors_[var_560_6.prefab_name] ~= nil then
						local var_560_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_6.prefab_name].transform, "story_v_side_new_1104703", "1104703137", "story_v_side_new_1104703.awb")

						arg_557_1:RecordAudio("1104703137", var_560_11)
						arg_557_1:RecordAudio("1104703137", var_560_11)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703137", "story_v_side_new_1104703.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703137", "story_v_side_new_1104703.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_12 = math.max(var_560_5, arg_557_1.talkMaxDuration)

			if var_560_4 <= arg_557_1.time_ and arg_557_1.time_ < var_560_4 + var_560_12 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_4) / var_560_12

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_4 + var_560_12 and arg_557_1.time_ < var_560_4 + var_560_12 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
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

		arg_557_1:InitPlayNodeList()
	end,
	Play1104703138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104703138
		arg_561_1.duration_ = 3.97

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104703139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.475

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_1 = arg_561_1:GetWordFromCfg(1104703138)
				local var_564_2 = arg_561_1:FormatText(var_564_1.content)

				arg_561_1.text_.text = var_564_2

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_4 = 19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 19)

				if (19 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_2) / 19)) > 0 and var_564_0 < var_564_4 then
					arg_561_1.talkMaxDuration = var_564_4

					if var_564_4 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_4 + 0
					end
				end

				arg_561_1.text_.text = var_564_2
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703138", "story_v_side_new_1104703.awb") ~= 0 then
					local var_564_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703138", "story_v_side_new_1104703.awb") / 1000

					if var_564_5 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + 0
					end

					if var_564_1.prefab_name ~= "" and arg_561_1.actors_[var_564_1.prefab_name] ~= nil then
						local var_564_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_1.prefab_name].transform, "story_v_side_new_1104703", "1104703138", "story_v_side_new_1104703.awb")

						arg_561_1:RecordAudio("1104703138", var_564_6)
						arg_561_1:RecordAudio("1104703138", var_564_6)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703138", "story_v_side_new_1104703.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703138", "story_v_side_new_1104703.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_7 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_7 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_7

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_7 and arg_561_1.time_ < 0 + var_564_7 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104703139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104703139
		arg_565_1.duration_ = 8.93

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104703140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1047ui_story = arg_565_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_568_0 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 then
				arg_565_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_565_1.time_ - 0) / var_568_0)
				arg_565_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).z)
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles = arg_565_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 then
				arg_565_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_565_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1047ui_story"].transform.position).z)
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1047ui_story"].transform.localEulerAngles = arg_565_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_568_1 = 0
			local var_568_2 = 1.125

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(1104703139)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_6 = 45 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 45)

				if (45 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 45)) > 0 and var_568_2 < var_568_6 then
					arg_565_1.talkMaxDuration = var_568_6

					if var_568_6 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_6 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703139", "story_v_side_new_1104703.awb") ~= 0 then
					local var_568_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703139", "story_v_side_new_1104703.awb") / 1000

					if var_568_7 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_1
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_side_new_1104703", "1104703139", "story_v_side_new_1104703.awb")

						arg_565_1:RecordAudio("1104703139", var_568_8)
						arg_565_1:RecordAudio("1104703139", var_568_8)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703139", "story_v_side_new_1104703.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703139", "story_v_side_new_1104703.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_9 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_9 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_9

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_9 and arg_565_1.time_ < var_568_1 + var_568_9 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
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

		arg_565_1:InitPlayNodeList()
	end,
	Play1104703140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104703140
		arg_569_1.duration_ = 6.17

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1104703141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos1047ui_story = arg_569_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_572_0 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 then
				arg_569_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_569_1.time_ - 0) / var_572_0)
				arg_569_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).z)
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles = arg_569_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 then
				arg_569_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_569_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1047ui_story"].transform.position).z)
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1047ui_story"].transform.localEulerAngles = arg_569_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_572_1 = 0
			local var_572_2 = 0.65

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:GetWordFromCfg(1104703140)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_6 = 26 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_4) / 26)

				if (26 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_4) / 26)) > 0 and var_572_2 < var_572_6 then
					arg_569_1.talkMaxDuration = var_572_6

					if var_572_6 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_6 + var_572_1
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703140", "story_v_side_new_1104703.awb") ~= 0 then
					local var_572_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703140", "story_v_side_new_1104703.awb") / 1000

					if var_572_7 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_1
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_side_new_1104703", "1104703140", "story_v_side_new_1104703.awb")

						arg_569_1:RecordAudio("1104703140", var_572_8)
						arg_569_1:RecordAudio("1104703140", var_572_8)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703140", "story_v_side_new_1104703.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703140", "story_v_side_new_1104703.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_9 = math.max(var_572_2, arg_569_1.talkMaxDuration)

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_9 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_1) / var_572_9

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_1 + var_572_9 and arg_569_1.time_ < var_572_1 + var_572_9 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
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

		arg_569_1:InitPlayNodeList()
	end,
	Play1104703141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104703141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104703142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1047ui_story"]) and arg_573_1.var_.characterEffect1047ui_story == nil then
				arg_573_1.var_.characterEffect1047ui_story = arg_573_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1047ui_story"]) then
				if arg_573_1.var_.characterEffect1047ui_story and not isNil(arg_573_1.actors_["1047ui_story"]) then
					arg_573_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_0)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1047ui_story"]) and arg_573_1.var_.characterEffect1047ui_story then
				arg_573_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_576_1 = arg_573_1.actors_["1047ui_story"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1047ui_story = var_576_1.localPosition
			end

			local var_576_2 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_2 then
				var_576_1.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_573_1.time_ - 0) / var_576_2)
				var_576_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_1.position).x, (manager.ui.mainCamera.transform.position - var_576_1.position).y, (manager.ui.mainCamera.transform.position - var_576_1.position).z)
				var_576_1.localEulerAngles.z = 0
				var_576_1.localEulerAngles.x = 0
				var_576_1.localEulerAngles = var_576_1.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_2 and arg_573_1.time_ < 0 + var_576_2 + arg_576_0 then
				var_576_1.localPosition = Vector3.New(0, 100, 0)
				var_576_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_1.position).x, (manager.ui.mainCamera.transform.position - var_576_1.position).y, (manager.ui.mainCamera.transform.position - var_576_1.position).z)
				var_576_1.localEulerAngles.z = 0
				var_576_1.localEulerAngles.x = 0
				var_576_1.localEulerAngles = var_576_1.localEulerAngles
			end

			local var_576_3 = 0
			local var_576_4 = 0.7

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_3 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_5 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1104703141).content)

				arg_573_1.text_.text = var_576_5

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_7 = 28 <= 0 and var_576_4 or var_576_4 * (utf8.len(var_576_5) / 28)

				if (28 <= 0 and var_576_4 or var_576_4 * (utf8.len(var_576_5) / 28)) > 0 and var_576_4 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_3 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_3
					end
				end

				arg_573_1.text_.text = var_576_5
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_4, arg_573_1.talkMaxDuration)

			if var_576_3 <= arg_573_1.time_ and arg_573_1.time_ < var_576_3 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_3) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_3 + var_576_8 and arg_573_1.time_ < var_576_3 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
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

		arg_573_1:InitPlayNodeList()
	end,
	Play1104703142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104703142
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104703143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.7

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_1 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1104703142).content)

				arg_577_1.text_.text = var_580_1

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_3 = 28 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 28)

				if (28 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 28)) > 0 and var_580_0 < var_580_3 then
					arg_577_1.talkMaxDuration = var_580_3

					if var_580_3 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_3 + 0
					end
				end

				arg_577_1.text_.text = var_580_1
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_4 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_4 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_4

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_4 and arg_577_1.time_ < 0 + var_580_4 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104703143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104703143
		arg_581_1.duration_ = 5.57

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1104703144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1047ui_story = arg_581_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).z)
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles = arg_581_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_581_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1047ui_story"].transform.position).z)
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1047ui_story"].transform.localEulerAngles = arg_581_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_584_1 = arg_581_1.actors_["1047ui_story"]

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1047ui_story == nil then
				arg_581_1.var_.characterEffect1047ui_story = var_584_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_2 and not isNil(var_584_1) then
				if arg_581_1.var_.characterEffect1047ui_story and not isNil(var_584_1) then
					arg_581_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_2 and arg_581_1.time_ < 0 + var_584_2 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1047ui_story then
				arg_581_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_584_4 = 0
			local var_584_5 = 0.775

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_6 = arg_581_1:GetWordFromCfg(1104703143)
				local var_584_7 = arg_581_1:FormatText(var_584_6.content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 31 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 31)

				if (31 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 31)) > 0 and var_584_5 < var_584_9 then
					arg_581_1.talkMaxDuration = var_584_9

					if var_584_9 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_9 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703143", "story_v_side_new_1104703.awb") ~= 0 then
					local var_584_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703143", "story_v_side_new_1104703.awb") / 1000

					if var_584_10 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_4
					end

					if var_584_6.prefab_name ~= "" and arg_581_1.actors_[var_584_6.prefab_name] ~= nil then
						local var_584_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_6.prefab_name].transform, "story_v_side_new_1104703", "1104703143", "story_v_side_new_1104703.awb")

						arg_581_1:RecordAudio("1104703143", var_584_11)
						arg_581_1:RecordAudio("1104703143", var_584_11)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703143", "story_v_side_new_1104703.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703143", "story_v_side_new_1104703.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_12 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_12 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_12

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_12 and arg_581_1.time_ < var_584_4 + var_584_12 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play1104703144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104703144
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104703145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1047ui_story"]) and arg_585_1.var_.characterEffect1047ui_story == nil then
				arg_585_1.var_.characterEffect1047ui_story = arg_585_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_0 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1047ui_story"]) then
				if arg_585_1.var_.characterEffect1047ui_story and not isNil(arg_585_1.actors_["1047ui_story"]) then
					arg_585_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_585_1.time_ - 0) / var_588_0)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1047ui_story"]) and arg_585_1.var_.characterEffect1047ui_story then
				arg_585_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_588_1 = 0
			local var_588_2 = 0.05

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_3 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1104703144).content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 2 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_3) / 2)

				if (2 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_3) / 2)) > 0 and var_588_2 < var_588_5 then
					arg_585_1.talkMaxDuration = var_588_5

					if var_588_5 + var_588_1 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_5 + var_588_1
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_6 = math.max(var_588_2, arg_585_1.talkMaxDuration)

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_6 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_1) / var_588_6

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_1 + var_588_6 and arg_585_1.time_ < var_588_1 + var_588_6 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104703145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104703145
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104703146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 1.2

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1104703145).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 48 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 48)

				if (48 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 48)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104703146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104703146
		arg_593_1.duration_ = 6.8

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104703147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1047ui_story = arg_593_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_596_0 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 then
				arg_593_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_593_1.time_ - 0) / var_596_0)
				arg_593_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).z)
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles = arg_593_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 then
				arg_593_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_593_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1047ui_story"].transform.position).z)
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1047ui_story"].transform.localEulerAngles = arg_593_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_596_1 = arg_593_1.actors_["1047ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1047ui_story == nil then
				arg_593_1.var_.characterEffect1047ui_story = var_596_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_2 and not isNil(var_596_1) then
				if arg_593_1.var_.characterEffect1047ui_story and not isNil(var_596_1) then
					arg_593_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_2 and arg_593_1.time_ < 0 + var_596_2 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1047ui_story then
				arg_593_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_596_4 = 0
			local var_596_5 = 0.825

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_6 = arg_593_1:GetWordFromCfg(1104703146)
				local var_596_7 = arg_593_1:FormatText(var_596_6.content)

				arg_593_1.text_.text = var_596_7

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_9 = 33 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 33)

				if (33 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 33)) > 0 and var_596_5 < var_596_9 then
					arg_593_1.talkMaxDuration = var_596_9

					if var_596_9 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_9 + var_596_4
					end
				end

				arg_593_1.text_.text = var_596_7
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703146", "story_v_side_new_1104703.awb") ~= 0 then
					local var_596_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703146", "story_v_side_new_1104703.awb") / 1000

					if var_596_10 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_10 + var_596_4
					end

					if var_596_6.prefab_name ~= "" and arg_593_1.actors_[var_596_6.prefab_name] ~= nil then
						local var_596_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_6.prefab_name].transform, "story_v_side_new_1104703", "1104703146", "story_v_side_new_1104703.awb")

						arg_593_1:RecordAudio("1104703146", var_596_11)
						arg_593_1:RecordAudio("1104703146", var_596_11)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703146", "story_v_side_new_1104703.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703146", "story_v_side_new_1104703.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_12 = math.max(var_596_5, arg_593_1.talkMaxDuration)

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_12 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_4) / var_596_12

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_4 + var_596_12 and arg_593_1.time_ < var_596_4 + var_596_12 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
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

		arg_593_1:InitPlayNodeList()
	end,
	Play1104703147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104703147
		arg_597_1.duration_ = 6.4

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104703148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.var_.moveOldPos1047ui_story = arg_597_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_600_0 = 0.001

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 then
				arg_597_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_597_1.time_ - 0) / var_600_0)
				arg_597_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).z)
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles = arg_597_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 then
				arg_597_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_597_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_597_1.actors_["1047ui_story"].transform.position).z)
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_597_1.actors_["1047ui_story"].transform.localEulerAngles = arg_597_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action428")
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_600_1 = 0
			local var_600_2 = 0.725

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_3 = arg_597_1:GetWordFromCfg(1104703147)
				local var_600_4 = arg_597_1:FormatText(var_600_3.content)

				arg_597_1.text_.text = var_600_4

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_6 = 29 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_4) / 29)

				if (29 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_4) / 29)) > 0 and var_600_2 < var_600_6 then
					arg_597_1.talkMaxDuration = var_600_6

					if var_600_6 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_4
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703147", "story_v_side_new_1104703.awb") ~= 0 then
					local var_600_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703147", "story_v_side_new_1104703.awb") / 1000

					if var_600_7 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_1
					end

					if var_600_3.prefab_name ~= "" and arg_597_1.actors_[var_600_3.prefab_name] ~= nil then
						local var_600_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_3.prefab_name].transform, "story_v_side_new_1104703", "1104703147", "story_v_side_new_1104703.awb")

						arg_597_1:RecordAudio("1104703147", var_600_8)
						arg_597_1:RecordAudio("1104703147", var_600_8)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703147", "story_v_side_new_1104703.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703147", "story_v_side_new_1104703.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_9 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_9 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_9

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_9 and arg_597_1.time_ < var_600_1 + var_600_9 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
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

		arg_597_1:InitPlayNodeList()
	end,
	Play1104703148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104703148
		arg_601_1.duration_ = 12.77

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104703149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.var_.moveOldPos1047ui_story = arg_601_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_604_0 = 0.001

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 then
				arg_601_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_601_1.time_ - 0) / var_604_0)
				arg_601_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).z)
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles = arg_601_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 then
				arg_601_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_601_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1047ui_story"].transform.position).z)
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1047ui_story"].transform.localEulerAngles = arg_601_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action8_2")
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_604_1 = 0
			local var_604_2 = 1.225

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:GetWordFromCfg(1104703148)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_6 = 49 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_4) / 49)

				if (49 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_4) / 49)) > 0 and var_604_2 < var_604_6 then
					arg_601_1.talkMaxDuration = var_604_6

					if var_604_6 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_6 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703148", "story_v_side_new_1104703.awb") ~= 0 then
					local var_604_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703148", "story_v_side_new_1104703.awb") / 1000

					if var_604_7 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_1
					end

					if var_604_3.prefab_name ~= "" and arg_601_1.actors_[var_604_3.prefab_name] ~= nil then
						local var_604_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_3.prefab_name].transform, "story_v_side_new_1104703", "1104703148", "story_v_side_new_1104703.awb")

						arg_601_1:RecordAudio("1104703148", var_604_8)
						arg_601_1:RecordAudio("1104703148", var_604_8)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703148", "story_v_side_new_1104703.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703148", "story_v_side_new_1104703.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_9 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_9 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_9

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_9 and arg_601_1.time_ < var_604_1 + var_604_9 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {
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

		arg_601_1:InitPlayNodeList()
	end,
	Play1104703149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1104703149
		arg_605_1.duration_ = 6.33

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1104703150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.75

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:GetWordFromCfg(1104703149)
				local var_608_2 = arg_605_1:FormatText(var_608_1.content)

				arg_605_1.text_.text = var_608_2

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_4 = 30 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 30)

				if (30 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_2) / 30)) > 0 and var_608_0 < var_608_4 then
					arg_605_1.talkMaxDuration = var_608_4

					if var_608_4 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_4 + 0
					end
				end

				arg_605_1.text_.text = var_608_2
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703149", "story_v_side_new_1104703.awb") ~= 0 then
					local var_608_5 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703149", "story_v_side_new_1104703.awb") / 1000

					if var_608_5 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + 0
					end

					if var_608_1.prefab_name ~= "" and arg_605_1.actors_[var_608_1.prefab_name] ~= nil then
						local var_608_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_1.prefab_name].transform, "story_v_side_new_1104703", "1104703149", "story_v_side_new_1104703.awb")

						arg_605_1:RecordAudio("1104703149", var_608_6)
						arg_605_1:RecordAudio("1104703149", var_608_6)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703149", "story_v_side_new_1104703.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703149", "story_v_side_new_1104703.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_7 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_7 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_7

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_7 and arg_605_1.time_ < 0 + var_608_7 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1104703150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1104703150
		arg_609_1.duration_ = 10.67

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1104703151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.var_.moveOldPos1047ui_story = arg_609_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_612_0 = 0.001

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_0 then
				arg_609_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_609_1.time_ - 0) / var_612_0)
				arg_609_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).z)
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles = arg_609_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_609_1.time_ >= 0 + var_612_0 and arg_609_1.time_ < 0 + var_612_0 + arg_612_0 then
				arg_609_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_609_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1047ui_story"].transform.position).z)
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1047ui_story"].transform.localEulerAngles = arg_609_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_612_1 = 0
			local var_612_2 = 1.1

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_3 = arg_609_1:GetWordFromCfg(1104703150)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_6 = 44 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_4) / 44)

				if (44 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_4) / 44)) > 0 and var_612_2 < var_612_6 then
					arg_609_1.talkMaxDuration = var_612_6

					if var_612_6 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_6 + var_612_1
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703150", "story_v_side_new_1104703.awb") ~= 0 then
					local var_612_7 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703150", "story_v_side_new_1104703.awb") / 1000

					if var_612_7 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_1
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_side_new_1104703", "1104703150", "story_v_side_new_1104703.awb")

						arg_609_1:RecordAudio("1104703150", var_612_8)
						arg_609_1:RecordAudio("1104703150", var_612_8)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703150", "story_v_side_new_1104703.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703150", "story_v_side_new_1104703.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_9 = math.max(var_612_2, arg_609_1.talkMaxDuration)

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_9 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_1) / var_612_9

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_1 + var_612_9 and arg_609_1.time_ < var_612_1 + var_612_9 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
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

		arg_609_1:InitPlayNodeList()
	end,
	Play1104703151 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1104703151
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1104703152(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["1047ui_story"]) and arg_613_1.var_.characterEffect1047ui_story == nil then
				arg_613_1.var_.characterEffect1047ui_story = arg_613_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["1047ui_story"]) then
				if arg_613_1.var_.characterEffect1047ui_story and not isNil(arg_613_1.actors_["1047ui_story"]) then
					arg_613_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_0)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["1047ui_story"]) and arg_613_1.var_.characterEffect1047ui_story then
				arg_613_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_616_1 = 0
			local var_616_2 = 0.7

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1104703151).content)

				arg_613_1.text_.text = var_616_3

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 28 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 28)

				if (28 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 28)) > 0 and var_616_2 < var_616_5 then
					arg_613_1.talkMaxDuration = var_616_5

					if var_616_5 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + var_616_1
					end
				end

				arg_613_1.text_.text = var_616_3
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_6 = math.max(var_616_2, arg_613_1.talkMaxDuration)

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_6 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_1) / var_616_6

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_1 + var_616_6 and arg_613_1.time_ < var_616_1 + var_616_6 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1104703152 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1104703152
		arg_617_1.duration_ = 6.93

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1104703153(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.var_.moveOldPos1047ui_story = arg_617_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_620_0 = 0.001

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 then
				arg_617_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_617_1.time_ - 0) / var_620_0)
				arg_617_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).z)
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles = arg_617_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 then
				arg_617_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_617_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1047ui_story"].transform.position).z)
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1047ui_story"].transform.localEulerAngles = arg_617_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_620_1 = arg_617_1.actors_["1047ui_story"]

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1047ui_story == nil then
				arg_617_1.var_.characterEffect1047ui_story = var_620_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_2 and not isNil(var_620_1) then
				if arg_617_1.var_.characterEffect1047ui_story and not isNil(var_620_1) then
					arg_617_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_2 and arg_617_1.time_ < 0 + var_620_2 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1047ui_story then
				arg_617_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action437")
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_620_4 = 0
			local var_620_5 = 0.65

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_6 = arg_617_1:GetWordFromCfg(1104703152)
				local var_620_7 = arg_617_1:FormatText(var_620_6.content)

				arg_617_1.text_.text = var_620_7

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_9 = 26 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 26)

				if (26 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 26)) > 0 and var_620_5 < var_620_9 then
					arg_617_1.talkMaxDuration = var_620_9

					if var_620_9 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_9 + var_620_4
					end
				end

				arg_617_1.text_.text = var_620_7
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703152", "story_v_side_new_1104703.awb") ~= 0 then
					local var_620_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703152", "story_v_side_new_1104703.awb") / 1000

					if var_620_10 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_10 + var_620_4
					end

					if var_620_6.prefab_name ~= "" and arg_617_1.actors_[var_620_6.prefab_name] ~= nil then
						local var_620_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_6.prefab_name].transform, "story_v_side_new_1104703", "1104703152", "story_v_side_new_1104703.awb")

						arg_617_1:RecordAudio("1104703152", var_620_11)
						arg_617_1:RecordAudio("1104703152", var_620_11)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703152", "story_v_side_new_1104703.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703152", "story_v_side_new_1104703.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_12 = math.max(var_620_5, arg_617_1.talkMaxDuration)

			if var_620_4 <= arg_617_1.time_ and arg_617_1.time_ < var_620_4 + var_620_12 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_4) / var_620_12

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_4 + var_620_12 and arg_617_1.time_ < var_620_4 + var_620_12 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
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

		arg_617_1:InitPlayNodeList()
	end,
	Play1104703153 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1104703153
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1104703154(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(arg_621_1.actors_["1047ui_story"]) and arg_621_1.var_.characterEffect1047ui_story == nil then
				arg_621_1.var_.characterEffect1047ui_story = arg_621_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_0 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 and not isNil(arg_621_1.actors_["1047ui_story"]) then
				if arg_621_1.var_.characterEffect1047ui_story and not isNil(arg_621_1.actors_["1047ui_story"]) then
					arg_621_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_621_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_621_1.time_ - 0) / var_624_0)
				end
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 and not isNil(arg_621_1.actors_["1047ui_story"]) and arg_621_1.var_.characterEffect1047ui_story then
				arg_621_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_621_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_624_1 = arg_621_1.actors_["1047ui_story"].transform

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.var_.moveOldPos1047ui_story = var_624_1.localPosition
			end

			local var_624_2 = 0.001

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_2 then
				var_624_1.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_621_1.time_ - 0) / var_624_2)
				var_624_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_624_1.position).x, (manager.ui.mainCamera.transform.position - var_624_1.position).y, (manager.ui.mainCamera.transform.position - var_624_1.position).z)
				var_624_1.localEulerAngles.z = 0
				var_624_1.localEulerAngles.x = 0
				var_624_1.localEulerAngles = var_624_1.localEulerAngles
			end

			if arg_621_1.time_ >= 0 + var_624_2 and arg_621_1.time_ < 0 + var_624_2 + arg_624_0 then
				var_624_1.localPosition = Vector3.New(0, 100, 0)
				var_624_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_624_1.position).x, (manager.ui.mainCamera.transform.position - var_624_1.position).y, (manager.ui.mainCamera.transform.position - var_624_1.position).z)
				var_624_1.localEulerAngles.z = 0
				var_624_1.localEulerAngles.x = 0
				var_624_1.localEulerAngles = var_624_1.localEulerAngles
			end

			local var_624_3 = 0
			local var_624_4 = 0.975

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_3 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, false)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_5 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(1104703153).content)

				arg_621_1.text_.text = var_624_5

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_7 = 39 <= 0 and var_624_4 or var_624_4 * (utf8.len(var_624_5) / 39)

				if (39 <= 0 and var_624_4 or var_624_4 * (utf8.len(var_624_5) / 39)) > 0 and var_624_4 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_3 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_3
					end
				end

				arg_621_1.text_.text = var_624_5
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_8 = math.max(var_624_4, arg_621_1.talkMaxDuration)

			if var_624_3 <= arg_621_1.time_ and arg_621_1.time_ < var_624_3 + var_624_8 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_3) / var_624_8

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_3 + var_624_8 and arg_621_1.time_ < var_624_3 + var_624_8 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {
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

		arg_621_1:InitPlayNodeList()
	end,
	Play1104703154 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1104703154
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1104703155(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.625

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_1 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(1104703154).content)

				arg_625_1.text_.text = var_628_1

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_3 = 25 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 25)

				if (25 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 25)) > 0 and var_628_0 < var_628_3 then
					arg_625_1.talkMaxDuration = var_628_3

					if var_628_3 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_3 + 0
					end
				end

				arg_625_1.text_.text = var_628_1
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_4 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_4

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1104703155 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1104703155
		arg_629_1.duration_ = 2

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1104703156(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.var_.moveOldPos1047ui_story = arg_629_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_632_0 = 0.001

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 then
				arg_629_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_629_1.time_ - 0) / var_632_0)
				arg_629_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).z)
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles = arg_629_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 then
				arg_629_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_629_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1047ui_story"].transform.position).z)
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1047ui_story"].transform.localEulerAngles = arg_629_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_632_1 = arg_629_1.actors_["1047ui_story"]

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 and not isNil(var_632_1) and arg_629_1.var_.characterEffect1047ui_story == nil then
				arg_629_1.var_.characterEffect1047ui_story = var_632_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_2 = 0.200000002980232

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_2 and not isNil(var_632_1) then
				if arg_629_1.var_.characterEffect1047ui_story and not isNil(var_632_1) then
					arg_629_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_629_1.time_ >= 0 + var_632_2 and arg_629_1.time_ < 0 + var_632_2 + arg_632_0 and not isNil(var_632_1) and arg_629_1.var_.characterEffect1047ui_story then
				arg_629_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_632_4 = 0
			local var_632_5 = 0.1

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_4 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_6 = arg_629_1:GetWordFromCfg(1104703155)
				local var_632_7 = arg_629_1:FormatText(var_632_6.content)

				arg_629_1.text_.text = var_632_7

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_9 = 4 <= 0 and var_632_5 or var_632_5 * (utf8.len(var_632_7) / 4)

				if (4 <= 0 and var_632_5 or var_632_5 * (utf8.len(var_632_7) / 4)) > 0 and var_632_5 < var_632_9 then
					arg_629_1.talkMaxDuration = var_632_9

					if var_632_9 + var_632_4 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_9 + var_632_4
					end
				end

				arg_629_1.text_.text = var_632_7
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703155", "story_v_side_new_1104703.awb") ~= 0 then
					local var_632_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703155", "story_v_side_new_1104703.awb") / 1000

					if var_632_10 + var_632_4 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_10 + var_632_4
					end

					if var_632_6.prefab_name ~= "" and arg_629_1.actors_[var_632_6.prefab_name] ~= nil then
						local var_632_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_6.prefab_name].transform, "story_v_side_new_1104703", "1104703155", "story_v_side_new_1104703.awb")

						arg_629_1:RecordAudio("1104703155", var_632_11)
						arg_629_1:RecordAudio("1104703155", var_632_11)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703155", "story_v_side_new_1104703.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703155", "story_v_side_new_1104703.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_12 = math.max(var_632_5, arg_629_1.talkMaxDuration)

			if var_632_4 <= arg_629_1.time_ and arg_629_1.time_ < var_632_4 + var_632_12 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_4) / var_632_12

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_4 + var_632_12 and arg_629_1.time_ < var_632_4 + var_632_12 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
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

		arg_629_1:InitPlayNodeList()
	end,
	Play1104703156 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1104703156
		arg_633_1.duration_ = 5

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1104703157(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(arg_633_1.actors_["1047ui_story"]) and arg_633_1.var_.characterEffect1047ui_story == nil then
				arg_633_1.var_.characterEffect1047ui_story = arg_633_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_0 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 and not isNil(arg_633_1.actors_["1047ui_story"]) then
				if arg_633_1.var_.characterEffect1047ui_story and not isNil(arg_633_1.actors_["1047ui_story"]) then
					arg_633_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_633_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_633_1.time_ - 0) / var_636_0)
				end
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 and not isNil(arg_633_1.actors_["1047ui_story"]) and arg_633_1.var_.characterEffect1047ui_story then
				arg_633_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_633_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_636_1 = 0
			local var_636_2 = 0.9

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, true)
				arg_633_1.iconController_:SetSelectedState("hero")

				arg_633_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_633_1.callingController_:SetSelectedState("normal")

				arg_633_1.keyicon_.color = Color.New(1, 1, 1)
				arg_633_1.icon_.color = Color.New(1, 1, 1)

				local var_636_3 = arg_633_1:FormatText(arg_633_1:GetWordFromCfg(1104703156).content)

				arg_633_1.text_.text = var_636_3

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_5 = 36 <= 0 and var_636_2 or var_636_2 * (utf8.len(var_636_3) / 36)

				if (36 <= 0 and var_636_2 or var_636_2 * (utf8.len(var_636_3) / 36)) > 0 and var_636_2 < var_636_5 then
					arg_633_1.talkMaxDuration = var_636_5

					if var_636_5 + var_636_1 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_5 + var_636_1
					end
				end

				arg_633_1.text_.text = var_636_3
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)
				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_6 = math.max(var_636_2, arg_633_1.talkMaxDuration)

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_6 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_1) / var_636_6

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_1 + var_636_6 and arg_633_1.time_ < var_636_1 + var_636_6 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1104703157 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1104703157
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1104703158(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.var_.moveOldPos1047ui_story = arg_637_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_640_0 = 0.001

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_0 then
				arg_637_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_637_1.time_ - 0) / var_640_0)
				arg_637_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).z)
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles = arg_637_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_637_1.time_ >= 0 + var_640_0 and arg_637_1.time_ < 0 + var_640_0 + arg_640_0 then
				arg_637_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_637_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["1047ui_story"].transform.position).z)
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_637_1.actors_["1047ui_story"].transform.localEulerAngles = arg_637_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_640_1 = 0
			local var_640_2 = 0.55

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_3 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(1104703157).content)

				arg_637_1.text_.text = var_640_3

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 22 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 22)

				if (22 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 22)) > 0 and var_640_2 < var_640_5 then
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

		arg_637_1.nodeConfigList_ = {
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

		arg_637_1:InitPlayNodeList()
	end,
	Play1104703158 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1104703158
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1104703159(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0.875

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, true)
				arg_641_1.iconController_:SetSelectedState("hero")

				arg_641_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_641_1.callingController_:SetSelectedState("normal")

				arg_641_1.keyicon_.color = Color.New(1, 1, 1)
				arg_641_1.icon_.color = Color.New(1, 1, 1)

				local var_644_1 = arg_641_1:FormatText(arg_641_1:GetWordFromCfg(1104703158).content)

				arg_641_1.text_.text = var_644_1

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_3 = 35 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_1) / 35)

				if (35 <= 0 and var_644_0 or var_644_0 * (utf8.len(var_644_1) / 35)) > 0 and var_644_0 < var_644_3 then
					arg_641_1.talkMaxDuration = var_644_3

					if var_644_3 + 0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_3 + 0
					end
				end

				arg_641_1.text_.text = var_644_1
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_4 = math.max(var_644_0, arg_641_1.talkMaxDuration)

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_4 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - 0) / var_644_4

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= 0 + var_644_4 and arg_641_1.time_ < 0 + var_644_4 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1104703159 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1104703159
		arg_645_1.duration_ = 8.3

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1104703160(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.var_.moveOldPos1047ui_story = arg_645_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_648_0 = 0.001

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_0 then
				arg_645_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_645_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_645_1.time_ - 0) / var_648_0)
				arg_645_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).z)
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles = arg_645_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_645_1.time_ >= 0 + var_648_0 and arg_645_1.time_ < 0 + var_648_0 + arg_648_0 then
				arg_645_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_645_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_645_1.actors_["1047ui_story"].transform.position).z)
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_645_1.actors_["1047ui_story"].transform.localEulerAngles = arg_645_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_648_1 = arg_645_1.actors_["1047ui_story"]

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 and not isNil(var_648_1) and arg_645_1.var_.characterEffect1047ui_story == nil then
				arg_645_1.var_.characterEffect1047ui_story = var_648_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_2 = 0.200000002980232

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_2 and not isNil(var_648_1) then
				if arg_645_1.var_.characterEffect1047ui_story and not isNil(var_648_1) then
					arg_645_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_645_1.time_ >= 0 + var_648_2 and arg_645_1.time_ < 0 + var_648_2 + arg_648_0 and not isNil(var_648_1) and arg_645_1.var_.characterEffect1047ui_story then
				arg_645_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_648_4 = 0
			local var_648_5 = 0.55

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_4 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_6 = arg_645_1:GetWordFromCfg(1104703159)
				local var_648_7 = arg_645_1:FormatText(var_648_6.content)

				arg_645_1.text_.text = var_648_7

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_9 = 22 <= 0 and var_648_5 or var_648_5 * (utf8.len(var_648_7) / 22)

				if (22 <= 0 and var_648_5 or var_648_5 * (utf8.len(var_648_7) / 22)) > 0 and var_648_5 < var_648_9 then
					arg_645_1.talkMaxDuration = var_648_9

					if var_648_9 + var_648_4 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_9 + var_648_4
					end
				end

				arg_645_1.text_.text = var_648_7
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703159", "story_v_side_new_1104703.awb") ~= 0 then
					local var_648_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703159", "story_v_side_new_1104703.awb") / 1000

					if var_648_10 + var_648_4 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_10 + var_648_4
					end

					if var_648_6.prefab_name ~= "" and arg_645_1.actors_[var_648_6.prefab_name] ~= nil then
						local var_648_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_6.prefab_name].transform, "story_v_side_new_1104703", "1104703159", "story_v_side_new_1104703.awb")

						arg_645_1:RecordAudio("1104703159", var_648_11)
						arg_645_1:RecordAudio("1104703159", var_648_11)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703159", "story_v_side_new_1104703.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703159", "story_v_side_new_1104703.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_12 = math.max(var_648_5, arg_645_1.talkMaxDuration)

			if var_648_4 <= arg_645_1.time_ and arg_645_1.time_ < var_648_4 + var_648_12 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_4) / var_648_12

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_4 + var_648_12 and arg_645_1.time_ < var_648_4 + var_648_12 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {
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

		arg_645_1:InitPlayNodeList()
	end,
	Play1104703160 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1104703160
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1104703161(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 and not isNil(arg_649_1.actors_["1047ui_story"]) and arg_649_1.var_.characterEffect1047ui_story == nil then
				arg_649_1.var_.characterEffect1047ui_story = arg_649_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_0 = 0.200000002980232

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_0 and not isNil(arg_649_1.actors_["1047ui_story"]) then
				if arg_649_1.var_.characterEffect1047ui_story and not isNil(arg_649_1.actors_["1047ui_story"]) then
					arg_649_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_649_1.time_ - 0) / var_652_0)
				end
			end

			if arg_649_1.time_ >= 0 + var_652_0 and arg_649_1.time_ < 0 + var_652_0 + arg_652_0 and not isNil(arg_649_1.actors_["1047ui_story"]) and arg_649_1.var_.characterEffect1047ui_story then
				arg_649_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_652_1 = arg_649_1.actors_["1047ui_story"].transform

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.var_.moveOldPos1047ui_story = var_652_1.localPosition
			end

			local var_652_2 = 0.001

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_2 then
				var_652_1.localPosition = Vector3.Lerp(arg_649_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_649_1.time_ - 0) / var_652_2)
				var_652_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_652_1.position).x, (manager.ui.mainCamera.transform.position - var_652_1.position).y, (manager.ui.mainCamera.transform.position - var_652_1.position).z)
				var_652_1.localEulerAngles.z = 0
				var_652_1.localEulerAngles.x = 0
				var_652_1.localEulerAngles = var_652_1.localEulerAngles
			end

			if arg_649_1.time_ >= 0 + var_652_2 and arg_649_1.time_ < 0 + var_652_2 + arg_652_0 then
				var_652_1.localPosition = Vector3.New(0, 100, 0)
				var_652_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_652_1.position).x, (manager.ui.mainCamera.transform.position - var_652_1.position).y, (manager.ui.mainCamera.transform.position - var_652_1.position).z)
				var_652_1.localEulerAngles.z = 0
				var_652_1.localEulerAngles.x = 0
				var_652_1.localEulerAngles = var_652_1.localEulerAngles
			end

			local var_652_3 = 0
			local var_652_4 = 0.425

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_3 + arg_652_0 then
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

				local var_652_5 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1104703160).content)

				arg_649_1.text_.text = var_652_5

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_7 = 17 <= 0 and var_652_4 or var_652_4 * (utf8.len(var_652_5) / 17)

				if (17 <= 0 and var_652_4 or var_652_4 * (utf8.len(var_652_5) / 17)) > 0 and var_652_4 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_3 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_3
					end
				end

				arg_649_1.text_.text = var_652_5
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_8 = math.max(var_652_4, arg_649_1.talkMaxDuration)

			if var_652_3 <= arg_649_1.time_ and arg_649_1.time_ < var_652_3 + var_652_8 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_3) / var_652_8

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_3 + var_652_8 and arg_649_1.time_ < var_652_3 + var_652_8 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {
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

		arg_649_1:InitPlayNodeList()
	end,
	Play1104703161 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1104703161
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1104703162(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0.475

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(1104703161).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 19 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 19)

				if (19 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 19)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1104703162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1104703162
		arg_657_1.duration_ = 6.87

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1104703163(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.var_.moveOldPos1047ui_story = arg_657_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_660_0 = 0.001

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 then
				arg_657_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_657_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_657_1.time_ - 0) / var_660_0)
				arg_657_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).z)
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles = arg_657_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 then
				arg_657_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_657_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_657_1.actors_["1047ui_story"].transform.position).z)
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_657_1.actors_["1047ui_story"].transform.localEulerAngles = arg_657_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_660_1 = arg_657_1.actors_["1047ui_story"]

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1047ui_story == nil then
				arg_657_1.var_.characterEffect1047ui_story = var_660_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_2 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_2 and not isNil(var_660_1) then
				if arg_657_1.var_.characterEffect1047ui_story and not isNil(var_660_1) then
					arg_657_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_657_1.time_ >= 0 + var_660_2 and arg_657_1.time_ < 0 + var_660_2 + arg_660_0 and not isNil(var_660_1) and arg_657_1.var_.characterEffect1047ui_story then
				arg_657_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_660_4 = 0
			local var_660_5 = 0.65

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_6 = arg_657_1:GetWordFromCfg(1104703162)
				local var_660_7 = arg_657_1:FormatText(var_660_6.content)

				arg_657_1.text_.text = var_660_7

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_9 = 26 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 26)

				if (26 <= 0 and var_660_5 or var_660_5 * (utf8.len(var_660_7) / 26)) > 0 and var_660_5 < var_660_9 then
					arg_657_1.talkMaxDuration = var_660_9

					if var_660_9 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_9 + var_660_4
					end
				end

				arg_657_1.text_.text = var_660_7
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703162", "story_v_side_new_1104703.awb") ~= 0 then
					local var_660_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703162", "story_v_side_new_1104703.awb") / 1000

					if var_660_10 + var_660_4 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_10 + var_660_4
					end

					if var_660_6.prefab_name ~= "" and arg_657_1.actors_[var_660_6.prefab_name] ~= nil then
						local var_660_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_6.prefab_name].transform, "story_v_side_new_1104703", "1104703162", "story_v_side_new_1104703.awb")

						arg_657_1:RecordAudio("1104703162", var_660_11)
						arg_657_1:RecordAudio("1104703162", var_660_11)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703162", "story_v_side_new_1104703.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703162", "story_v_side_new_1104703.awb")
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
				actorName = "1047ui_story",
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
	Play1104703163 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1104703163
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1104703164(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1047ui_story"]) and arg_661_1.var_.characterEffect1047ui_story == nil then
				arg_661_1.var_.characterEffect1047ui_story = arg_661_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.200000002980232

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1047ui_story"]) then
				if arg_661_1.var_.characterEffect1047ui_story and not isNil(arg_661_1.actors_["1047ui_story"]) then
					arg_661_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_661_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_661_1.time_ - 0) / var_664_0)
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1047ui_story"]) and arg_661_1.var_.characterEffect1047ui_story then
				arg_661_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_661_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_664_1 = arg_661_1.actors_["1047ui_story"].transform

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.var_.moveOldPos1047ui_story = var_664_1.localPosition
			end

			local var_664_2 = 0.001

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_2 then
				var_664_1.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_661_1.time_ - 0) / var_664_2)
				var_664_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_1.position).x, (manager.ui.mainCamera.transform.position - var_664_1.position).y, (manager.ui.mainCamera.transform.position - var_664_1.position).z)
				var_664_1.localEulerAngles.z = 0
				var_664_1.localEulerAngles.x = 0
				var_664_1.localEulerAngles = var_664_1.localEulerAngles
			end

			if arg_661_1.time_ >= 0 + var_664_2 and arg_661_1.time_ < 0 + var_664_2 + arg_664_0 then
				var_664_1.localPosition = Vector3.New(0, 100, 0)
				var_664_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_664_1.position).x, (manager.ui.mainCamera.transform.position - var_664_1.position).y, (manager.ui.mainCamera.transform.position - var_664_1.position).z)
				var_664_1.localEulerAngles.z = 0
				var_664_1.localEulerAngles.x = 0
				var_664_1.localEulerAngles = var_664_1.localEulerAngles
			end

			local var_664_3 = 0
			local var_664_4 = 0.475

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_3 + arg_664_0 then
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

				local var_664_5 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(1104703163).content)

				arg_661_1.text_.text = var_664_5

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 19 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_5) / 19)

				if (19 <= 0 and var_664_4 or var_664_4 * (utf8.len(var_664_5) / 19)) > 0 and var_664_4 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_3 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_3
					end
				end

				arg_661_1.text_.text = var_664_5
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_8 = math.max(var_664_4, arg_661_1.talkMaxDuration)

			if var_664_3 <= arg_661_1.time_ and arg_661_1.time_ < var_664_3 + var_664_8 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_3) / var_664_8

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_3 + var_664_8 and arg_661_1.time_ < var_664_3 + var_664_8 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
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

		arg_661_1:InitPlayNodeList()
	end,
	Play1104703164 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1104703164
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1104703165(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0.675

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, false)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_1 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(1104703164).content)

				arg_665_1.text_.text = var_668_1

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_3 = 27 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 27)

				if (27 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 27)) > 0 and var_668_0 < var_668_3 then
					arg_665_1.talkMaxDuration = var_668_3

					if var_668_3 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_3 + 0
					end
				end

				arg_665_1.text_.text = var_668_1
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_4 = math.max(var_668_0, arg_665_1.talkMaxDuration)

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_4 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - 0) / var_668_4

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= 0 + var_668_4 and arg_665_1.time_ < 0 + var_668_4 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1104703165 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1104703165
		arg_669_1.duration_ = 4.03

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play1104703166(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.var_.moveOldPos1047ui_story = arg_669_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_672_0 = 0.001

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 then
				arg_669_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_669_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_669_1.time_ - 0) / var_672_0)
				arg_669_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).z)
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles = arg_669_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 then
				arg_669_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_669_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["1047ui_story"].transform.position).z)
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_669_1.actors_["1047ui_story"].transform.localEulerAngles = arg_669_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_672_1 = arg_669_1.actors_["1047ui_story"]

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(var_672_1) and arg_669_1.var_.characterEffect1047ui_story == nil then
				arg_669_1.var_.characterEffect1047ui_story = var_672_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_2 and not isNil(var_672_1) then
				if arg_669_1.var_.characterEffect1047ui_story and not isNil(var_672_1) then
					arg_669_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= 0 + var_672_2 and arg_669_1.time_ < 0 + var_672_2 + arg_672_0 and not isNil(var_672_1) and arg_669_1.var_.characterEffect1047ui_story then
				arg_669_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_672_4 = 0
			local var_672_5 = 0.15

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_6 = arg_669_1:GetWordFromCfg(1104703165)
				local var_672_7 = arg_669_1:FormatText(var_672_6.content)

				arg_669_1.text_.text = var_672_7

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_9 = 6 <= 0 and var_672_5 or var_672_5 * (utf8.len(var_672_7) / 6)

				if (6 <= 0 and var_672_5 or var_672_5 * (utf8.len(var_672_7) / 6)) > 0 and var_672_5 < var_672_9 then
					arg_669_1.talkMaxDuration = var_672_9

					if var_672_9 + var_672_4 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_9 + var_672_4
					end
				end

				arg_669_1.text_.text = var_672_7
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703165", "story_v_side_new_1104703.awb") ~= 0 then
					local var_672_10 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703165", "story_v_side_new_1104703.awb") / 1000

					if var_672_10 + var_672_4 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_10 + var_672_4
					end

					if var_672_6.prefab_name ~= "" and arg_669_1.actors_[var_672_6.prefab_name] ~= nil then
						local var_672_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_6.prefab_name].transform, "story_v_side_new_1104703", "1104703165", "story_v_side_new_1104703.awb")

						arg_669_1:RecordAudio("1104703165", var_672_11)
						arg_669_1:RecordAudio("1104703165", var_672_11)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703165", "story_v_side_new_1104703.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703165", "story_v_side_new_1104703.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_12 = math.max(var_672_5, arg_669_1.talkMaxDuration)

			if var_672_4 <= arg_669_1.time_ and arg_669_1.time_ < var_672_4 + var_672_12 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_4) / var_672_12

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_4 + var_672_12 and arg_669_1.time_ < var_672_4 + var_672_12 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {
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

		arg_669_1:InitPlayNodeList()
	end,
	Play1104703166 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1104703166
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
			arg_673_1.auto_ = false
		end

		function arg_673_1.playNext_(arg_675_0)
			arg_673_1.onStoryFinished_()
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["1047ui_story"]) and arg_673_1.var_.characterEffect1047ui_story == nil then
				arg_673_1.var_.characterEffect1047ui_story = arg_673_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["1047ui_story"]) then
				if arg_673_1.var_.characterEffect1047ui_story and not isNil(arg_673_1.actors_["1047ui_story"]) then
					arg_673_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_673_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_673_1.time_ - 0) / var_676_0)
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["1047ui_story"]) and arg_673_1.var_.characterEffect1047ui_story then
				arg_673_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_673_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_676_2 = 0
			local var_676_3 = 0.15

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_2 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_4 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(1104703166).content)

				arg_673_1.text_.text = var_676_4

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_6 = 6 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_4) / 6)

				if (6 <= 0 and var_676_3 or var_676_3 * (utf8.len(var_676_4) / 6)) > 0 and var_676_3 < var_676_6 then
					arg_673_1.talkMaxDuration = var_676_6

					if var_676_6 + var_676_2 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_6 + var_676_2
					end
				end

				arg_673_1.text_.text = var_676_4
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_7 = math.max(var_676_3, arg_673_1.talkMaxDuration)

			if var_676_2 <= arg_673_1.time_ and arg_673_1.time_ < var_676_2 + var_676_7 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_2) / var_676_7

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_2 + var_676_7 and arg_673_1.time_ < var_676_2 + var_676_7 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play1104703043 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1104703043
		arg_677_1.duration_ = 5.77

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play1104703044(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if arg_677_1.actors_["104701ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104701ui_story"))) then
				local var_680_0 = Object.Instantiate(Asset.Load("Char/" .. "104701ui_story"), arg_677_1.stage_.transform)

				var_680_0.name = "104701ui_story"
				var_680_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.actors_["104701ui_story"] = var_680_0

				local var_680_1 = var_680_0:GetComponentInChildren(typeof(CharacterEffect))

				var_680_1.enabled = true

				local var_680_2 = GameObjectTools.GetOrAddComponent(var_680_0, typeof(DynamicBoneHelper))

				if var_680_2 then
					var_680_2:EnableDynamicBone(false)
				end

				arg_677_1:ShowWeapon(var_680_1.transform, false)

				arg_677_1.var_["104701ui_story" .. "Animator"] = var_680_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_677_1.var_["104701ui_story" .. "Animator"].applyRootMotion = true
				arg_677_1.var_["104701ui_story" .. "LipSync"] = var_680_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			local var_680_3 = "104701ui_story"

			if arg_677_1.actors_["104701ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104701ui_story"))) then
				local var_680_4 = Object.Instantiate(Asset.Load("Char/" .. "104701ui_story"), arg_677_1.stage_.transform)

				var_680_4.name = var_680_3
				var_680_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_677_1.actors_[var_680_3] = var_680_4

				local var_680_5 = var_680_4:GetComponentInChildren(typeof(CharacterEffect))

				var_680_5.enabled = true

				local var_680_6 = GameObjectTools.GetOrAddComponent(var_680_4, typeof(DynamicBoneHelper))

				if var_680_6 then
					var_680_6:EnableDynamicBone(false)
				end

				arg_677_1:ShowWeapon(var_680_5.transform, false)

				arg_677_1.var_[var_680_3 .. "Animator"] = var_680_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_677_1.var_[var_680_3 .. "Animator"].applyRootMotion = true
				arg_677_1.var_[var_680_3 .. "LipSync"] = var_680_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("104701ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_680_7 = 0
			local var_680_8 = 0.5

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_7 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_9 = arg_677_1:GetWordFromCfg(1104703043)
				local var_680_10 = arg_677_1:FormatText(var_680_9.content)

				arg_677_1.text_.text = var_680_10

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_12 = 20 <= 0 and var_680_8 or var_680_8 * (utf8.len(var_680_10) / 20)

				if (20 <= 0 and var_680_8 or var_680_8 * (utf8.len(var_680_10) / 20)) > 0 and var_680_8 < var_680_12 then
					arg_677_1.talkMaxDuration = var_680_12

					if var_680_12 + var_680_7 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_12 + var_680_7
					end
				end

				arg_677_1.text_.text = var_680_10
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703043", "story_v_side_new_1104703.awb") ~= 0 then
					local var_680_13 = manager.audio:GetVoiceLength("story_v_side_new_1104703", "1104703043", "story_v_side_new_1104703.awb") / 1000

					if var_680_13 + var_680_7 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_13 + var_680_7
					end

					if var_680_9.prefab_name ~= "" and arg_677_1.actors_[var_680_9.prefab_name] ~= nil then
						local var_680_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_9.prefab_name].transform, "story_v_side_new_1104703", "1104703043", "story_v_side_new_1104703.awb")

						arg_677_1:RecordAudio("1104703043", var_680_14)
						arg_677_1:RecordAudio("1104703043", var_680_14)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_new_1104703", "1104703043", "story_v_side_new_1104703.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_new_1104703", "1104703043", "story_v_side_new_1104703.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_15 = math.max(var_680_8, arg_677_1.talkMaxDuration)

			if var_680_7 <= arg_677_1.time_ and arg_677_1.time_ < var_680_7 + var_680_15 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_7) / var_680_15

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_7 + var_680_15 and arg_677_1.time_ < var_680_7 + var_680_15 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/H09g",
		"TextureConfig/Background/ST27",
		"TextureConfig/Background/ST22"
	},
	voices = {
		"story_v_side_new_1104703.awb"
	}
}
